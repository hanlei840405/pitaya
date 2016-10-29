package com.fruit.pitaya.mapper;

import com.fruit.pitaya.model.SkuSPrice;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by hanlei6 on 2016/10/25.
 */
public class SkuSPriceMapper implements RowMapper<SkuSPrice> {
    @Override
    public SkuSPrice mapRow(ResultSet rs, int rowNum) throws SQLException {
        SkuSPrice skuSPrice = new SkuSPrice();
        skuSPrice.setSku(rs.getString("sku"));
        skuSPrice.setCustomer(rs.getString("customer"));
        skuSPrice.setFirstbuy(rs.getString("firstbuy"));
        skuSPrice.setPrice(rs.getBigDecimal("price"));
        return skuSPrice;
    }
}
