package com.fruit.pitaya.service;

import com.fruit.pitaya.mapper.OrderDetailMapper;
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
import org.springframework.util.StringUtils;

import java.math.BigDecimal;
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
    @Autowired
    private SkuSPriceService skuSPriceService;
    @Autowired
    private CustomerRatedService customerRatedService;
    @Autowired
    private CustomerService customerService;

    public List<OrderVO> findSentByCustomer(String customer) {
        List<OrderVO> orderVOs = jdbcTemplate.query("SELECT t1.*,t2.addr,t3.cusName AS customerName,t4.realName AS reviewerName FROM od_order t1 INNER JOIN od_order_addr t2 on t1.orderID = t2.orderID INNER JOIN mall_customer t3 ON t1.customer = t3.cusCode LEFT JOIN sys_user t4 ON t1.reviewer=t4.name WHERE customer=? AND t1.status=3 ORDER BY status ASC, odtime DESC", ps -> {
            ps.setString(1, customer);
        }, new OrderVOMapper());
        orderVOs.forEach(orderVO -> orderVO.setOrderDetailVOs(jdbcTemplate.query("SELECT t1.*,t2.skuName,t2.specName,t2.image FROM od_order_de t1 INNER JOIN mall_sku t2 ON t1.sku=t2.sku WHERE t1.orderID=?", ps -> {
            ps.setString(1, orderVO.getOrderID());
        }, new OrderDetailVOMapper())));
        return orderVOs;
    }

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

    public List<OrderDetail> findByOrderId(String orderId) {
        List<OrderDetail> orderDetails = jdbcTemplate.query("SELECT * FROM od_order_de WHERE orderID=?", ps -> {
            ps.setString(1, orderId);
        }, new OrderDetailMapper());
        return orderDetails;
    }

    public Long count(String customer) {
        Map<String, Object> result = jdbcTemplate.queryForMap("SELECT COUNT(*) AS cnt FROM od_order WHERE customer=?", customer);
        return (Long) result.get("cnt");
    }

    @Transactional
    public void create(String cusCode, Long addressId, String address) throws Exception {
        String orderID = "O" + sequenceService.generateCode("订单");
        Cart cart = cartService.get(cusCode);
        if (addressId == null) {
            try {
                jdbcTemplate.update("INSERT INTO od_order (orderID, customer, status, odtime) VALUES (?,?,0,now())",
                        ps -> {
                            ps.setString(1, orderID);
                            ps.setString(2, cusCode);
                        });
            }catch (Exception e) {
                throw new Exception("新建订单出错", e);
            }
        } else {
            try {
                jdbcTemplate.update("INSERT INTO od_order (orderID, customer, addrID, status, odtime) VALUES (?,?,?,0,now())",
                        ps -> {
                            ps.setString(1, orderID);
                            ps.setString(2, cusCode);
                            ps.setLong(3, addressId);
                        });
            }catch (Exception e) {
                throw new Exception("新建订单出错", e);
            }
        }

        final BigDecimal[] totalPriceArray = {new BigDecimal(0)};
        cart.getCartDetailVOs().forEach(cartDetailVO -> {
            int count = cartDetailVO.getSkuCount();
            String sku = cartDetailVO.getSku();
            String skuName = cartDetailVO.getSkuName();
            String specName = cartDetailVO.getSpecName();
            Stock stock = stockService.get(sku);
            if (stock == null || stock.getQuantity() < count) { // 缺货
                throw new RuntimeException(skuName + " " + specName + "(" + sku + ")" + "缺货");
            }
            totalPriceArray[0] = totalPriceArray[0].add(cartDetailVO.getSkuAmount());
            stockService.update(sku, count);
        });

        try {
            jdbcTemplate.batchUpdate("INSERT INTO od_order_de (orderID, sku, quantity, price) VALUES (?,?,?,?)", new BatchPreparedStatementSetter() {
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
        }catch (Exception e) {
            throw new Exception("购物车明细转为订单明细失败", e);
        }

        try {
            // 更新订单总金额
            jdbcTemplate.update("UPDATE od_order SET amount = ? WHERE orderID = ?",
                    ps -> {
                        ps.setBigDecimal(1, totalPriceArray[0]);
                        ps.setString(2, orderID);
                    });
        }catch (Exception e) {
            throw new Exception("更新订单总金额失败", e);
        }

        if (addressId == null || addressId == 0) { // 如果地址是手动输入（适用于微商或不想将地址保留为常用地址的选择）
            try {
                jdbcTemplate.update("INSERT INTO od_order_addr (orderID, addr) VALUES (?,?)",
                        ps -> {
                            ps.setString(1, orderID);
                            ps.setString(2, address);
                        });
            }catch (Exception e) {
                throw new Exception("收件地址未填写", e);
            }
        } else {
            CustomerAddr customerAddr = customerAddrService.get(addressId, cusCode);
            try {
                jdbcTemplate.update("INSERT INTO od_order_addr (orderID, addr) VALUES (?,?)",
                        ps -> {
                            ps.setString(1, orderID);
                            ps.setString(2, customerAddr.getAddr() + " " + customerAddr.getRecipient() + " " + customerAddr.getPhone());
                        });
            }catch (Exception e) {
                throw new Exception("未找到默认收件地址", e);
            }
        }
        try {
            cartService.clearCart(cusCode);
        }catch (Exception e) {
            throw new Exception("清空购物车失败", e);
        }


        // 设置首次购买的sku为非首次购买
        // 1,如果为S类型商户，将设置特殊价格的数据的首次购买字段设为1.2,如果为非S类型商户，新增一条首次购买字段为1的数据插入表中
        cart.getCartDetailVOs().forEach(cartDetailVO -> {
            SkuSPrice skuSPrice = skuSPriceService.findByCusCodeAndSku(cusCode, cartDetailVO.getSku());
            if (skuSPrice != null) {
                if (StringUtils.isEmpty(skuSPrice.getFirstbuy())) {
                    skuSPriceService.updateFirstbuy(cusCode, cartDetailVO.getSku());
                }
            } else {
                skuSPriceService.insert(cusCode, cartDetailVO.getSku(), "1");
            }
        });
        customerService.updateCoupon(cusCode);
    }

    @Transactional
    public int uploadCertificate(String customer, String orderId, String certificate) {
        return jdbcTemplate.update("UPDATE od_order SET certificate=?,status=1 WHERE orderID=? AND customer=?", ps -> {
            ps.setString(1, certificate);
            ps.setString(2, orderId);
            ps.setString(3, customer);
        });
    }

    public long receivedSkuCount(String customer, String sku) {
        Map<String, Object> result = jdbcTemplate.queryForMap("SELECT COUNT(1) AS cnt FROM od_order_de t1 INNER JOIN od_order t2 ON t1.orderID=t2.orderID WHERE t2.customer=? AND t1.sku=?", customer, sku);
        return (Long) result.get("cnt");
    }
}
