package com.fruit.pitaya.mapper;

import com.fruit.pitaya.model.SkuNPrice;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by hanlei6 on 2016/10/25.
 */
public class SkuNPriceMapper implements RowMapper<SkuNPrice> {
    @Override
    public SkuNPrice mapRow(ResultSet rs, int rowNum) throws SQLException {
        SkuNPrice skuNPrice = new SkuNPrice();
        skuNPrice.setSku(rs.getString("sku"));
        skuNPrice.setNum1(rs.getInt("num1"));
        skuNPrice.setNum2(rs.getInt("num2"));
        skuNPrice.setNum3(rs.getInt("num3"));
        skuNPrice.setPrice1(rs.getBigDecimal("price1"));
        skuNPrice.setPrice2(rs.getBigDecimal("price2"));
        skuNPrice.setPrice3(rs.getBigDecimal("price3"));
        skuNPrice.setPriceType(rs.getString("priceType"));
        return skuNPrice;
    }
}
