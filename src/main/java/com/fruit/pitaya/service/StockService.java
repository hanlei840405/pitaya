package com.fruit.pitaya.service;

import com.fruit.pitaya.mapper.StockMapper;
import com.fruit.pitaya.model.Stock;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by hanlei6 on 2016/10/28.
 */
@Service
public class StockService {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public Stock get(String sku) {
        List<Stock> stocks = jdbcTemplate.query("SELECT * FROM sk_stock WHERE sku=?",new Object[]{sku}, new StockMapper());
        if (stocks.isEmpty()) {
            return null;
        }
        return stocks.get(0);
    }

    @Transactional
    public void update(String sku, Long count) {
        jdbcTemplate.update("UPDATE sk_stock SET quantity=quantity-? WHERE sku=?", new Object[]{count, sku});
    }
}
