package com.fruit.pitaya.service;

import com.fruit.pitaya.mapper.CustomerShopMapper;
import com.fruit.pitaya.model.CustomerShop;
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
public class CustomerShopService {
    private static final Logger log = LoggerFactory.getLogger(CustomerShopService.class);
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public CustomerShop get(long id, String cusCode) {
        List<CustomerShop> result = jdbcTemplate.query("SELECT * FROM mall_customer_shop WHERE id=? AND customer=?", new Object[]{id, cusCode}, new CustomerShopMapper());
        if (!result.isEmpty()) {
            return result.get(0);
        }
        return null;
    }

    public List<CustomerShop> findByCustomer(String cusCode) {
        return jdbcTemplate.query("SELECT * FROM mall_customer_shop WHERE customer=?", new Object[]{cusCode}, new CustomerShopMapper());
    }

    @Transactional
    public void insert(CustomerShop customerShop) {
        jdbcTemplate.update("INSERT INTO mall_customer_shop (customer,category,shopName,shopAddt,shopPic) VALUE (?,?,?,?,?)",
                new Object[]{customerShop.getCustomer(), customerShop.getCategory(), customerShop.getShopName(), customerShop.getShopAddt()}, customerShop.getShopPic());
    }

    @Transactional
    public void update(CustomerShop customerShop) {
        jdbcTemplate.update("UPDATE mall_customer_shop SET category=?,shopName=?,shopAddt=?,shopPic=? WHERE id=?",
                new Object[]{customerShop.getCategory(), customerShop.getShopName(), customerShop.getShopAddt(), customerShop.getShopPic(), customerShop.getId()});
    }

    @Transactional
    public void delete(long id) {
        jdbcTemplate.update("DELETE FROM mall_customer_shop WHERE id=?",
                new Object[]{id});
    }
}
