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
        List<Customer> result = jdbcTemplate.query("SELECT * FROM mall_customer WHERE id=?", new Object[]{id}, new CustomerMapper());
        if (!result.isEmpty()) {
            return result.get(0);
        }
        return null;
    }

    public Customer get(String cusCode) {
        List<Customer> result = jdbcTemplate.query("SELECT * FROM mall_customer WHERE cusCode=?", new Object[]{cusCode}, new CustomerMapper());
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

            jdbcTemplate.update("INSERT INTO mall_customer (cusCode,cusName,passwd,sex,birthday,email,phone,wechat,upCode,status,rate) VALUE (?,?,?,?,?,?,?,?,?,0,0)",
                    new Object[]{customer.getCusCode(), customer.getCusName(), customer.getPasswd(), customer.getSex(), customer.getBirthday(), customer.getEmail(), customer.getPhone(), customer.getWechat(), customer.getUpCode()});
        } catch (Exception e) {
            log.error("INSERT CUSTOMER : {}", customer);
            throw new Exception(e);
        }
        return get(customer.getCusCode());
    }

    @Transactional
    public Customer update(Customer customer) throws Exception {
        try {
            jdbcTemplate.update("UPDATE mall_customer SET sex=?,birthday=?,email=?,phone=?,wechat=?,upCode=?,saler=? WHERE id=?",
                    new Object[]{customer.getSex(), customer.getBirthday(), customer.getEmail(), customer.getPhone(),
                            customer.getWechat(), customer.getUpCode(), customer.getSaler(), customer.getId()});
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
