package com.fruit.pitaya.service;

import com.fruit.pitaya.mapper.OrderVOMapper;
import com.fruit.pitaya.model.Cart;
import com.fruit.pitaya.model.CustomerAddr;
import com.fruit.pitaya.model.OrderVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by hanlei6 on 2016/10/31.
 */
@Service
public class OrderService {
    @Autowired
    private JdbcTemplate jdbcTemplate;
    @Autowired
    private CartService cartService;
    @Autowired
    private SequenceService sequenceService;
    @Autowired
    private CustomerAddrService customerAddrService;

    public List<OrderVO> findByCustomer(String customer) {
        return jdbcTemplate.query("SELECT t1.*,t2.addr,t3.cusName AS customerName,t4.realName AS reviewerName FROM od_order t1 INNER JOIN od_order_addr t2 on t1.addrID = t2.id INNER JOIN mall_customer t3 ON t1.customer = t3.cusCode INNER JOIN sys_user t4 ON t1.reviewer=t4.name WHERE customer=?", new Object[]{customer}, new OrderVOMapper());
    }

    public OrderVO get(String orderId, String customer) {
        List<OrderVO> orderVOs = jdbcTemplate.query("SELECT t1.*,t2.addr,t3.cusName AS customerName,t4.realName AS reviewerName FROM od_order t1 INNER JOIN od_order_addr t2 on t1.addrID = t2.id INNER JOIN mall_customer t3 ON t1.customer = t3.cusCode INNER JOIN sys_user t4 ON t1.reviewer=t4.name WHERE orderID=? AND customer=?", new Object[]{orderId, customer}, new OrderVOMapper());
        if (orderVOs.isEmpty()) {
            return null;
        }
        return orderVOs.get(0);
    }

    @Transactional
    public void create(String cusCode, Long addressId) {
        String orderID = "O" + sequenceService.generateCode("订单");
        Cart cart = cartService.get(cusCode);
        jdbcTemplate.update("INSERT INTO od_order (orderID, customer, addrID, amount, status, odtime) VALUE (?,?,?,?,0,now())",
                orderID, cusCode, addressId, cart.getAmount());

        Map<String, BigDecimal> skuCost = new HashMap<>();
        cart.getCartDetailVOs().forEach(cartDetailVO -> {
            int count = cartDetailVO.getSkuCount();
            String sku = cartDetailVO.getSku();
            String skuName = cartDetailVO.getSkuName();
            String specName = cartDetailVO.getSpecName();
            BigDecimal allcost = new BigDecimal(0);
            int index = 0;
            while (count > 0) {
                Map<String, Object> result = jdbcTemplate.queryForMap("SELECT sum(quantity) as totalCount FROM sku_inbound_de WHERE sku=? AND status = 1", cart.getCartDetailVOs().get(0).getSku());
                int totalCount = ((BigDecimal) result.get("totalCount")).intValue();
                if (totalCount < count) { // 缺货
                    throw new RuntimeException(skuName + " " + specName + "(" + sku + ")" + "缺货");
                }
                result.clear();
                result = jdbcTemplate.queryForMap("SELECT id, cost, quantity FROM sku_inbound_de t1 INNER JOIN sku_inbound t2 ON t1.inboundID = t2.inboundID WHERE sku=? AND status = 1 ORDER BY extime LIMIT ?, 1", new Object[]{cart.getCartDetailVOs().get(0).getSku(), index});
                Integer quantity = (Integer) result.get("quantity");
                Long id = (Long) result.get("id");
                // 计算总成本
                if (quantity - count > 0) {
                    // 入库明细单库存数量大于订单数量
                    allcost = allcost.add(((BigDecimal) result.get("cost")).multiply(BigDecimal.valueOf(count)));
                    // 设置入库单剩余数量
                    jdbcTemplate.update("UPDATE sku_inbound_de SET leftQty=leftQty - ? WHERE id=?", count, id);
                } else {
                    // 如果入库数量少于订单数量，将入库明细单状态设置为0,剩余数量设置为0
                    jdbcTemplate.update("UPDATE sku_inbound_de SET status=0, leftQty=0 WHERE id=?", id);
                    allcost = allcost.add(((BigDecimal) result.get("cost")).multiply(BigDecimal.valueOf(quantity)));
                }
                // 订单中待分配的sku数量
                count -= quantity;
                index++;
            }
            skuCost.put(sku, allcost);
        });


        jdbcTemplate.batchUpdate("INSERT INTO od_order_de (orderID, sku, quantity, price, allcost) VALUE (?,?,?,?,?)", new BatchPreparedStatementSetter() {
            @Override
            public void setValues(PreparedStatement preparedStatement, int i) throws SQLException {
                preparedStatement.setString(1, orderID);
                preparedStatement.setString(2, cart.getCartDetailVOs().get(i).getSku());
                preparedStatement.setLong(3, cart.getCartDetailVOs().get(i).getSkuCount());
                preparedStatement.setBigDecimal(4, cart.getCartDetailVOs().get(i).getPrice());
                preparedStatement.setBigDecimal(5, skuCost.get(cart.getCartDetailVOs().get(i).getSku()));
            }

            @Override
            public int getBatchSize() {
                return cart.getCartDetailVOs().size();
            }
        });
        CustomerAddr customerAddr = customerAddrService.get(addressId, cusCode);
        jdbcTemplate.update("INSERT INTO od_order_addr (orderID, addr) VALUE (?,?)", orderID, customerAddr.getAddr() + " " + customerAddr.getRecipient() + " " + customerAddr.getPhone());
        cartService.clearCart(cusCode);
    }
}
