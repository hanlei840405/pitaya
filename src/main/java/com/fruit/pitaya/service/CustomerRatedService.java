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
