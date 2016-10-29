package com.fruit.pitaya.service;

import com.fruit.pitaya.mapper.SkuNPriceMapper;
import com.fruit.pitaya.model.SkuNPrice;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
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
        List<SkuNPrice> skuNPrices = jdbcTemplate.query("SELECT * FROM mall_sku_nprice WHERE sku=? AND priceType=?", new Object[]{sku, priceType}, new SkuNPriceMapper());
        if (skuNPrices.isEmpty()) {
            return null;
        }
        return skuNPrices.get(0);
    }

    public BigDecimal findPriceBySkuAndCount(String sku, String priceType, int count) {
        SkuNPrice skuNPrice = findBySkuAndType(sku, priceType);
        if (skuNPrice != null) {
            if (skuNPrice.getNum1() <= count && skuNPrice.getNum2() > count) {
                return skuNPrice.getPrice1();
            } else if (skuNPrice.getNum2() <= count && skuNPrice.getNum3() > count) {
                return skuNPrice.getPrice2();
            } else if (skuNPrice.getNum3() <= count) {
                return skuNPrice.getPrice3();
            }else {
                return skuNPrice.getPrice1();
            }
        }
        return null;
    }

    public Integer findMinCountBySkuAndCount(String sku, String priceType) {
        SkuNPrice skuNPrice = findBySkuAndType(sku, priceType);
        if (skuNPrice != null) {
            return skuNPrice.getNum1();
        }
        return null;
    }
}
