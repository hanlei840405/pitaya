package com.fruit.pitaya.service;

import com.fruit.pitaya.mapper.CustomerRatedDeVOMapper;
import com.fruit.pitaya.mapper.CustomerRatedVOMapper;
import com.fruit.pitaya.mapper.CustomerUpRatedMapper;
import com.fruit.pitaya.model.*;
import com.fruit.pitaya.util.Constant;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by hanlei6 on 2017/1/4.
 */
@Service
public class CustomerRatedService {
    private static final Logger log = LoggerFactory.getLogger(CustomerRatedService.class);
    @Autowired
    private JdbcTemplate jdbcTemplate;
    @Autowired
    private OrderService orderService;
    @Autowired
    private SkuSPriceService skuSPriceService;
    @Autowired
    private SkuNPriceService skuNPriceService;
    @Autowired
    private CustomerService customerService;

    @Transactional
    public void create(String orderId, String customer) {
        Customer cus = customerService.get(customer);
        if (StringUtils.isEmpty(cus.getUpCode())) {
            return;
        }
        List<OrderDetail> orderDetails = orderService.findByOrderId(orderId);
        KeyHolder keyHolder = new GeneratedKeyHolder();
        jdbcTemplate.update(con -> {
            PreparedStatement ps = con.prepareStatement("INSERT INTO customer_rated (customer, orderID, status) VALUES (?,?, '0')", Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, cus.getUpCode());
            ps.setString(2, orderId);
            return ps;
        }, keyHolder);
        final BigDecimal[] totalAmount = {new BigDecimal(0)};
        List<CustomerRatedDe> customerRatedDes = new ArrayList<>();
        orderDetails.forEach(orderDetail -> {
            BigDecimal amount = new BigDecimal(0);
            CustomerRatedDe customerRatedDe = new CustomerRatedDe();
            // 查询该商户的商品有没有配置与上级商家的固定提成
            List<CustomerUpRated> customerUpRateds = jdbcTemplate.query("SELECT * FROM customer_up_rated WHERE customer=? AND sku=? AND up=?", ps -> {
                ps.setString(1, customer);
                ps.setString(2, orderDetail.getSku());
                ps.setString(3, cus.getUpCode());
            }, new CustomerUpRatedMapper());

            if (!customerUpRateds.isEmpty()) { // 从配置中获取固定提成
                amount = customerUpRateds.get(0).getRated();
            } else { // 下线的最低价格减去上线的最高价格
                BigDecimal price = orderDetail.getPrice();
                SkuSPrice skuSPrice = skuSPriceService.findByCusCodeAndSku(customer, orderDetail.getSku());
                if (skuSPrice.getPrice() != null) {
                    amount = price.subtract(skuSPrice.getPrice());
                } else {
                    SkuNPrice skuNPrice = skuNPriceService.findBySkuAndType(orderDetail.getSku(), cus.getPriceType());
                    amount = price.subtract(skuNPrice.getPrice1());
                }
            }
            totalAmount[0] = totalAmount[0].add(amount.doubleValue() > 0d ? amount : new BigDecimal(0));
            customerRatedDe.setOrderDeID(orderDetail.getId());
            customerRatedDe.setRateID(keyHolder.getKey().longValue());
            customerRatedDe.setSku(orderDetail.getSku());
            customerRatedDe.setAmount(amount);
            customerRatedDes.add(customerRatedDe);
        });

        jdbcTemplate.batchUpdate("INSERT INTO customer_rated_de (ratedID, orderDeID, sku, amount) VALUES (?,?,?,?)", new BatchPreparedStatementSetter() {
            @Override
            public void setValues(PreparedStatement preparedStatement, int i) throws SQLException {
                preparedStatement.setLong(1, customerRatedDes.get(i).getRateID());
                preparedStatement.setLong(2, customerRatedDes.get(i).getOrderDeID());
                preparedStatement.setString(3, customerRatedDes.get(i).getSku());
                preparedStatement.setBigDecimal(4, customerRatedDes.get(i).getAmount());
            }

            @Override
            public int getBatchSize() {
                return customerRatedDes.size();
            }
        });

        jdbcTemplate.update("UPDATE customer_rated SET amount=?", totalAmount);
    }

    public List<CustomerRatedVO> findByCustomer(String customer, int page) {
        List<CustomerRatedVO> customerRatedVOs = jdbcTemplate.query("SELECT t1.*,t2.cusName,t3.odtime, t4.cusName as orderOwner FROM customer_rated t1 INNER JOIN mall_customer t2 ON t1.customer = t2.cusCode INNER JOIN od_order t3 ON t1.orderID=t3.orderID INNER JOIN mall_customer t4 ON t3.customer = t4.cusCode WHERE t1.customer=? LIMIT ?,?", ps -> {
            ps.setString(1, customer);
            ps.setInt(2, (page - 1) * Constant.PAGE_SIZE);
            ps.setInt(3, Constant.PAGE_SIZE);
        }, new CustomerRatedVOMapper());
        customerRatedVOs.forEach(customerRatedVO -> customerRatedVO.setCustomerRatedDeVOs(jdbcTemplate.query("SELECT t1.*,t2.skuName,t3.quantity,t3.price  FROM customer_rated_de t1 INNER JOIN mall_sku t2 ON t1.sku = t2.sku INNER JOIN od_order_de t3 ON t1.orderDeID=t3.id AND t1.ratedID = ?", ps -> {
            ps.setLong(1, customerRatedVO.getId());
        }, new CustomerRatedDeVOMapper())));
        return customerRatedVOs;
    }

    public Long count(String customer) {
        Map<String, Object> result = jdbcTemplate.queryForMap("SELECT COUNT(*) AS cnt FROM customer_rated WHERE customer=?", customer);
        return (Long) result.get("cnt");
    }
}
