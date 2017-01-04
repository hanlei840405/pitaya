package com.fruit.pitaya.service;

import com.fruit.pitaya.model.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

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

    @Transactional
    public void create(String orderId, Customer customer) {
        Order order = orderService.get(orderId, customer.getCusCode());
        List<OrderDetail> orderDetails = orderService.findByOrderId(order.getOrderID());
        KeyHolder keyHolder = new GeneratedKeyHolder();
        jdbcTemplate.update(con -> {
            PreparedStatement ps = con.prepareStatement("INSERT INTO customer_rated (customer, orderID, amount) VALUES (?,?)", Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, customer.getCusCode());
            ps.setString(2, orderId);
            return ps;
        }, keyHolder);
        final BigDecimal[] totalAmount = {new BigDecimal(0)};
        List<CustomerRatedDe> customerRatedDes = new ArrayList<>();
        orderDetails.forEach(orderDetail -> {
            CustomerRatedDe customerRatedDe = new CustomerRatedDe();
            BigDecimal price = orderDetail.getPrice();
            SkuSPrice skuSPrice = skuSPriceService.findByCusCodeAndSku(customer.getCusCode(), orderDetail.getSku());
            BigDecimal amount = new BigDecimal(0); // 下线的最低价格减去上线的最高价格
            if (skuSPrice.getPrice() != null) {
                amount = price.subtract(skuSPrice.getPrice());
            } else {
                SkuNPrice skuNPrice = skuNPriceService.findBySkuAndType(orderDetail.getSku(), customer.getPriceType());
                amount = price.subtract(skuNPrice.getPrice1());
            }
            totalAmount[0] = totalAmount[0].add(amount);
            customerRatedDe.setOrderDeID(orderDetail.getId());
            customerRatedDe.setRateID(keyHolder.getKey().longValue());
            customerRatedDe.setSku(orderDetail.getSku());
            customerRatedDe.setAmount(amount);
            customerRatedDes.add(customerRatedDe);
        });

        jdbcTemplate.batchUpdate("INSERT INTO customer_rated_de (ratedID, orderDeID, sku,, amount) VALUES (?,?,?,?)", new BatchPreparedStatementSetter() {
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
}
