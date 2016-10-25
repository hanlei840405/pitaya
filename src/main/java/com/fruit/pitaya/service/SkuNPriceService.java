package com.fruit.pitaya.service;

import com.fruit.pitaya.mapper.SkuNPriceMapper;
import com.fruit.pitaya.model.SkuNPrice;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by hanlei6 on 2016/10/25.
 */
@Service
public class SkuNPriceService {
    private static final Logger log = LoggerFactory.getLogger(SkuNPriceService.class);
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<SkuNPrice> findBySku(String sku) {
        return jdbcTemplate.queryForList("SELECT * FROM mall_sku_nprice WHERE sku=?", SkuNPrice.class, sku);
    }

    public SkuNPrice findBySkuAndType(String sku, String priceType) {
        return jdbcTemplate.queryForObject("SELECT * FROM mall_sku_nprice WHERE sku=? AND priceType=?", new Object[]{sku, priceType}, new SkuNPriceMapper());
    }
}
