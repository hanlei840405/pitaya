package com.fruit.pitaya.service;

import com.fruit.pitaya.mapper.SkuSPriceMapper;
import com.fruit.pitaya.model.SkuSPrice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by hanlei6 on 2016/10/25.
 */
@Service
public class SkuSPriceService {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public SkuSPrice findByCusCodeAndSku(String cusCode, String sku) {
        List<SkuSPrice> skuSPrices = jdbcTemplate.query("SELECT * FROM mall_sku_sprice WHERE sku=? AND customer=?", ps -> {
            ps.setString(1, sku);
            ps.setString(2, cusCode);
        }, new SkuSPriceMapper());
        if (skuSPrices.isEmpty()) {
            return null;
        }
        return skuSPrices.get(0);
    }

    @Transactional
    public void insert(String cusCode, String sku, String firstbuy) {
        jdbcTemplate.update("INSERT mall_sku_sprice (sku, cusCode, firstbuy) VALUES (?,?,?)",
                ps -> {
                    ps.setString(1, sku);
                    ps.setString(2, cusCode);
                    ps.setString(3, firstbuy);
                });
    }

    @Transactional
    public void updateFirstbuy(String customer, String sku) {
        jdbcTemplate.update("UPDATE mall_sku_sprice SET firstbuy=1 WHERE sku=? AND customer=?",
                ps -> {
                    ps.setString(1, sku);
                    ps.setString(2, customer);
                });
    }
}
