package com.fruit.pitaya.service;

import com.fruit.pitaya.mapper.SkuSPriceMapper;
import com.fruit.pitaya.model.SkuSPrice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

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

    public boolean isFirstBuy(String cusCode) {
        Map<String, Object> resulit = jdbcTemplate.queryForMap("SELECT count(*) AS cnt FROM mall_sku_sprice WHERE firstbuy = '1' AND customer=?", cusCode);
        if ((Long) resulit.get("cnt") == 0L) {
            return true;
        }
        return false;
    }
}
