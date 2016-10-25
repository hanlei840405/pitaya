package com.fruit.pitaya.service;

import com.fruit.pitaya.mapper.SkuSPriceMapper;
import com.fruit.pitaya.model.SkuSPrice;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

/**
 * Created by hanlei6 on 2016/10/25.
 */
@Service
public class SkuSPriceService {
    private static final Logger log = LoggerFactory.getLogger(SkuSPriceService.class);
    @Autowired
    private JdbcTemplate jdbcTemplate;


    public SkuSPrice findBySkuAndType(String sku, String customer) {
        return jdbcTemplate.queryForObject("SELECT * FROM mall_sku_sprice WHERE sku=? AND customer=?", new Object[]{sku, customer}, new SkuSPriceMapper());
    }
}
