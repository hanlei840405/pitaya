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
        List<CustomerAddr> result = jdbcTemplate.query("SELECT * FROM mall_customer_addr WHERE id=? AND customer=?", ps -> {
            ps.setLong(1, id);
            ps.setString(2, cusCode);
        }, new CustomerAddrMapper());
        if (!result.isEmpty()) {
            return result.get(0);
        }
        return null;
    }

    public CustomerAddr getDefault(String cusCode) {
        List<CustomerAddr> result = jdbcTemplate.query("SELECT * FROM mall_customer_addr WHERE used='1' AND customer=?", ps -> {
            ps.setString(1, cusCode);
        }, new CustomerAddrMapper());
        if (!result.isEmpty()) {
            return result.get(0);
        }
        result = jdbcTemplate.query("SELECT * FROM mall_customer_addr WHERE customer=?", ps -> {
            ps.setString(1, cusCode);
        }, new CustomerAddrMapper());
        if (!result.isEmpty()) {
            return result.get(0);
        }
        return null;
    }

    public List<CustomerAddr> findByCustomer(String cusCode) {
        return jdbcTemplate.query("SELECT * FROM mall_customer_addr WHERE customer=?", ps -> {
            ps.setString(1, cusCode);
        }, new CustomerAddrMapper());
    }

    @Transactional
    public void insert(CustomerAddr customerAddr) {
        jdbcTemplate.update("INSERT INTO mall_customer_addr (customer,addr,recipient,phone) VALUES (?,?,?,?)",
                ps -> {
                    ps.setString(1, customerAddr.getCustomer());
                    ps.setString(2, customerAddr.getAddr());
                    ps.setString(3, customerAddr.getRecipient());
                    ps.setString(4, customerAddr.getPhone());
                });
    }

    @Transactional
    public void update(CustomerAddr customerAddr) {
        jdbcTemplate.update("UPDATE mall_customer_addr SET addr=?,recipient=?,phone=? WHERE id=?",
                ps -> {
                    ps.setString(1, customerAddr.getAddr());
                    ps.setString(2, customerAddr.getRecipient());
                    ps.setString(3, customerAddr.getPhone());
                    ps.setLong(4, customerAddr.getId());
                });
    }

    @Transactional
    public void updateUsed(String cusCode, long id) {
        jdbcTemplate.update("UPDATE mall_customer_addr SET used='0' WHERE customer=?", new Object[]{cusCode});
        jdbcTemplate.update("UPDATE mall_customer_addr SET used='1' WHERE customer=? AND id=?", ps -> {
            ps.setString(1, cusCode);
            ps.setLong(2, id);
        });
    }

    @Transactional
    public void delete(long id) {
        jdbcTemplate.update("DELETE FROM mall_customer_addr WHERE id=?",
                ps -> {
                    ps.setLong(1, id);
                });
    }
}
