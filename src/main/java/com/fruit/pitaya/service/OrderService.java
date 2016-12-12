package com.fruit.pitaya.service;

import com.fruit.pitaya.mapper.OrderDetailVOMapper;
import com.fruit.pitaya.mapper.OrderMapper;
import com.fruit.pitaya.mapper.OrderVOMapper;
import com.fruit.pitaya.model.*;
import com.fruit.pitaya.util.Constant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.PreparedStatement;
import java.sql.SQLException;
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
    @Autowired
    private StockService stockService;

    public List<OrderVO> findByCustomer(String customer, int page) {
        List<OrderVO> orderVOs = jdbcTemplate.query("SELECT t1.*,t2.addr,t3.cusName AS customerName,t4.realName AS reviewerName FROM od_order t1 INNER JOIN od_order_addr t2 on t1.orderID = t2.orderID INNER JOIN mall_customer t3 ON t1.customer = t3.cusCode LEFT JOIN sys_user t4 ON t1.reviewer=t4.name WHERE customer=? ORDER BY status ASC, odtime DESC LIMIT ?,?", ps -> {
            ps.setString(1, customer);
            ps.setInt(2, (page - 1) * Constant.PAGE_SIZE);
            ps.setInt(3, Constant.PAGE_SIZE);
        }, new OrderVOMapper());
        orderVOs.forEach(orderVO -> orderVO.setOrderDetailVOs(jdbcTemplate.query("SELECT t1.*,t2.skuName,t2.specName,t2.image FROM od_order_de t1 INNER JOIN mall_sku t2 ON t1.sku=t2.sku WHERE t1.orderID=?", ps -> {
            ps.setString(1, orderVO.getOrderID());
        }, new OrderDetailVOMapper())));
        return orderVOs;
    }

    public Order get(String orderId, String customer) {
        List<Order> orders = jdbcTemplate.query("SELECT * FROM od_order WHERE orderID=? AND customer=?", ps -> {
            ps.setString(1, orderId);
            ps.setString(2, customer);
        }, new OrderMapper());
        if (orders.isEmpty()) {
            return null;
        }
        return orders.get(0);
    }

    public Long count(String customer) {
        Map<String, Object> result = jdbcTemplate.queryForMap("SELECT COUNT(*) AS cnt FROM od_order WHERE customer=?", customer);
        return (Long) result.get("cnt");
    }

    @Transactional
    public void create(String cusCode, Long addressId) {
        String orderID = "O" + sequenceService.generateCode("订单");
        Cart cart = cartService.get(cusCode);
        jdbcTemplate.update("INSERT INTO od_order (orderID, customer, addrID, amount, status, odtime) VALUE (?,?,?,?,0,now())",
                ps -> {
                    ps.setString(1, orderID);
                    ps.setString(2, cusCode);
                    ps.setLong(3, addressId);
                    ps.setBigDecimal(4, cart.getAmount());
                });

        cart.getCartDetailVOs().forEach(cartDetailVO -> {
            int count = cartDetailVO.getSkuCount();
            String sku = cartDetailVO.getSku();
            String skuName = cartDetailVO.getSkuName();
            String specName = cartDetailVO.getSpecName();
            Stock stock = stockService.get(sku);
            if (stock == null || stock.getQuantity() < count) { // 缺货
                throw new RuntimeException(skuName + " " + specName + "(" + sku + ")" + "缺货");
            }
            stockService.update(sku, count);
        });


        jdbcTemplate.batchUpdate("INSERT INTO od_order_de (orderID, sku, quantity, price) VALUE (?,?,?,?)", new BatchPreparedStatementSetter() {
            @Override
            public void setValues(PreparedStatement preparedStatement, int i) throws SQLException {
                preparedStatement.setString(1, orderID);
                preparedStatement.setString(2, cart.getCartDetailVOs().get(i).getSku());
                preparedStatement.setLong(3, cart.getCartDetailVOs().get(i).getSkuCount());
                preparedStatement.setBigDecimal(4, cart.getCartDetailVOs().get(i).getPrice());
            }

            @Override
            public int getBatchSize() {
                return cart.getCartDetailVOs().size();
            }
        });
        CustomerAddr customerAddr = customerAddrService.get(addressId, cusCode);
        jdbcTemplate.update("INSERT INTO od_order_addr (orderID, addr) VALUE (?,?)",
                ps -> {
                    ps.setString(1, orderID);
                    ps.setString(2, customerAddr.getAddr() + " " + customerAddr.getRecipient() + " " + customerAddr.getPhone());
                });
        cartService.clearCart(cusCode);
        cartService.clearCart(cusCode);
    }

    @Transactional
    public int uploadCertificate(String customer, String orderId, String certificate) {
        return jdbcTemplate.update("UPDATE od_order SET certificate=?,status=1 WHERE orderID=? AND customer=?", ps -> {
            ps.setString(1, certificate);
            ps.setString(2, orderId);
            ps.setString(3, customer);
        });
    }
}
