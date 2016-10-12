package com.fruit.pitaya.service;

import com.fruit.pitaya.mapper.CustomerMapper;
import com.fruit.pitaya.model.Customer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by hanlei6 on 2016/10/12.
 */
@Service
public class CustomerService {
    private static final Logger log = LoggerFactory.getLogger(CustomerService.class);
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public Customer get(long id) {
        return jdbcTemplate.queryForObject("SELECT * FROM mall_customer WHERE id=?", new Object[]{id}, new CustomerMapper());
    }

    public Customer get(String cusCode) {
        return jdbcTemplate.queryForObject("SELECT * FROM mall_customer WHERE cusCode=?", new Object[]{cusCode}, new CustomerMapper());
    }

    @Transactional
    public Customer insert(Customer customer) throws Exception {
        try {
            jdbcTemplate.update("INSERT INTO mall_customer (cusCode,cusName,passwd,rate) VALUE (?,?,?,1)", new Object[]{customer.getCusCode(), customer.getCusName(), customer.getPasswd()});
        } catch (Exception e) {
            log.error("INSERT CUSTOMER : {}", customer);
            throw new Exception(e.getCause());
        }
        return get(customer.getCusCode());
    }

    @Transactional
    public Customer update(Customer customer) throws Exception {
        try {
            jdbcTemplate.update("UPDATE mall_customer SET sex=?,birthday=?,email=?,phone=?,wechat=?,upCode=?,upCustomer=?,saler=? WHERE id=?",
                    new Object[]{customer.getSex(), customer.getBirthday(), customer.getEmail(), customer.getPhone(),
                            customer.getWechat(), customer.getUpCode(), customer.getUpCustomer(), customer.getSaler(), customer.getId()});
        } catch (Exception e) {
            log.error("UPDATE CUSTOMER : {}", customer);
            throw new Exception(e.getCause());
        }
        return get(customer.getCusCode());
    }

    @Transactional
    public Customer changePassword(long id, String passwd) throws Exception {
        try {
            jdbcTemplate.update("UPDATE mall_customer SET password=? WHERE id=?", new Object[]{id, passwd});
        } catch (Exception e) {
            log.error("CHANGE PASSWORD CUSTOMER : {}", id);
            throw new Exception(e.getCause());
        }
        return get(id);
    }
}
