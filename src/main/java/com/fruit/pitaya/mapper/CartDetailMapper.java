package com.fruit.pitaya.mapper;

import com.fruit.pitaya.model.CartDetail;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by hanlei6 on 2016/10/26.
 */
public class CartDetailMapper implements RowMapper<CartDetail> {
    @Override
    public CartDetail mapRow(ResultSet rs, int rowNum) throws SQLException {
        CartDetail cartDetail = new CartDetail();
        cartDetail.setCusCode(rs.getString("cusCode"));
        cartDetail.setId(rs.getLong("id"));
        cartDetail.setPrice(rs.getBigDecimal("price"));
        cartDetail.setPriceType(rs.getString("priceType"));
        cartDetail.setSku(rs.getString("sku"));
        cartDetail.setSkuAmount(rs.getBigDecimal("skuAmount"));
        cartDetail.setSkuCount(rs.getInt("skuCount"));
        return cartDetail;
    }
}
