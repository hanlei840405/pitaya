package com.fruit.pitaya.service;

import com.fruit.pitaya.mapper.CustomerMapper;
import com.fruit.pitaya.model.Customer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.authentication.encoding.Md5PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Date;
import java.util.List;

/**
 * Created by hanlei6 on 2016/10/12.
 */
@Service
public class CustomerService {
    private static final Logger log = LoggerFactory.getLogger(CustomerService.class);
    @Autowired
    private JdbcTemplate jdbcTemplate;
    @Autowired
    private SequenceService sequenceService;

    public Customer get(long id) {
        List<Customer> result = jdbcTemplate.query("SELECT * FROM mall_customer WHERE id=?", ps -> {
            ps.setLong(1, id);
        }, new CustomerMapper());
        if (!result.isEmpty()) {
            return result.get(0);
        }
        return null;
    }

    public Customer get(String cusCode) {
        List<Customer> result = jdbcTemplate.query("SELECT * FROM mall_customer WHERE cusCode=?", ps -> {
            ps.setString(1, cusCode);
        }, new CustomerMapper());
        if (!result.isEmpty()) {
            return result.get(0);
        }
        return null;
    }

    @Transactional
    public Customer insert(Customer customer) throws Exception {
        try {
            Customer upper = get(customer.getUpCode());
            if (upper == null) {
                customer.setUpCode(null);
            }
            String cusCode = sequenceService.generateCode("商家");
            customer.setCusCode(cusCode);

            Md5PasswordEncoder encoder = new Md5PasswordEncoder();
            customer.setPasswd(encoder.encodePassword(customer.getPasswd(), customer.getCusCode()));
            jdbcTemplate.update("INSERT INTO mall_customer (cusCode,cusName,passwd,sex,birthday,email,phone,wechat,upCode,status,rate, cusType) VALUE (?,?,?,?,?,?,?,?,?,0,0,?)",
                    ps -> {
                        ps.setString(1, customer.getCusCode());
                        ps.setString(2, customer.getPasswd());
                        ps.setString(3, customer.getSex());
                        ps.setDate(4, new Date(customer.getBirthday().getTime()));
                        ps.setString(5, customer.getEmail());
                        ps.setString(6, customer.getPhone());
                        ps.setString(7, customer.getWechat());
                        ps.setString(8, customer.getUpCode());
                        ps.setString(9, customer.getCusType());
                    });
        } catch (Exception e) {
            log.error("INSERT CUSTOMER : {}", customer);
            throw new Exception(e);
        }
        return get(customer.getCusCode());
    }

    @Transactional
    public Customer update(Customer customer) throws Exception {
        try {
            jdbcTemplate.update("UPDATE mall_customer SET sex=?,birthday=?,email=?,phone=?,wechat=?,upCode=?,cusType=? WHERE id=?",
                    ps -> {
                        ps.setString(1, customer.getSex());
                        ps.setDate(2, new Date(customer.getBirthday().getTime()));
                        ps.setString(3, customer.getEmail());
                        ps.setString(4, customer.getPhone());
                        ps.setString(5, customer.getWechat());
                        ps.setString(6, customer.getUpCode());
                        ps.setString(7, customer.getUpCode());
                        ps.setString(8, customer.getCusType());
                        ps.setLong(8, customer.getId());
                    });
        } catch (Exception e) {
            log.error("UPDATE CUSTOMER : {}", customer);
            throw new Exception(e.getCause());
        }
        return get(customer.getCusCode());
    }

    @Transactional
    public Customer changePassword(long id, String passwd) throws Exception {
        try {
            jdbcTemplate.update("UPDATE mall_customer SET password=? WHERE id=?", ps -> {
                ps.setLong(1, id);
                ps.setString(2, passwd);
            });
        } catch (Exception e) {
            log.error("CHANGE PASSWORD CUSTOMER : {}", id);
            throw new Exception(e.getCause());
        }
        return get(id);
    }
}
