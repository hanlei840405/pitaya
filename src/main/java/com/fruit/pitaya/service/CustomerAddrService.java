package com.fruit.pitaya.service;

import com.fruit.pitaya.mapper.CustomerAddrMapper;
import com.fruit.pitaya.model.CustomerAddr;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by hanlei6 on 2016/10/18.
 */
@Service
public class CustomerAddrService {
    private static final Logger log = LoggerFactory.getLogger(CustomerAddrService.class);
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public CustomerAddr get(long id, String cusCode) {
        List<CustomerAddr> result = jdbcTemplate.query("SELECT * FROM mall_customer_addr WHERE id=? AND customer=?", new Object[]{id, cusCode}, new CustomerAddrMapper());
        if (!result.isEmpty()) {
            return result.get(0);
        }
        return null;
    }

    public List<CustomerAddr> findByCustomer(String cusCode) {
        return jdbcTemplate.query("SELECT * FROM mall_customer_addr WHERE customer=?", new Object[]{cusCode}, new CustomerAddrMapper());
    }

    @Transactional
    public void insert(CustomerAddr customerAddr) {
        jdbcTemplate.update("INSERT INTO mall_customer_addr (customer,addr,recipient,phone) VALUE (?,?,?,?)",
                new Object[]{customerAddr.getCustomer(), customerAddr.getAddr(), customerAddr.getRecipient(), customerAddr.getPhone()});
    }

    @Transactional
    public void update(CustomerAddr customerAddr) {
        jdbcTemplate.update("UPDATE mall_customer_addr SET addr=?,recipient=?,phone=? WHERE id=?",
                new Object[]{customerAddr.getAddr(), customerAddr.getRecipient(), customerAddr.getPhone(), customerAddr.getId()});
    }

    @Transactional
    public void delete(long id) {
        jdbcTemplate.update("DELETE FROM mall_customer_addr WHERE id=?",
                new Object[]{id});
    }
}
