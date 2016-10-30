package com.fruit.pitaya.mapper;

import com.fruit.pitaya.model.CartDetailVO;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by hanlei6 on 2016/10/27.
 */
public class CartDetailVOMapper implements RowMapper<CartDetailVO> {
    @Override
    public CartDetailVO mapRow(ResultSet rs, int rowNum) throws SQLException {
        CartDetailVO cartDetailVO = new CartDetailVO();
        cartDetailVO.setSku(rs.getString("sku"));
        cartDetailVO.setSkuCount(rs.getInt("skuCount"));
        cartDetailVO.setCusCode(rs.getString("cusCode"));
        cartDetailVO.setId(rs.getLong("id"));
        cartDetailVO.setPrice(rs.getBigDecimal("price"));
        cartDetailVO.setPriceType(rs.getString("priceType"));
        cartDetailVO.setSkuAmount(rs.getBigDecimal("skuAmount"));
        cartDetailVO.setSkuName(rs.getString("skuName"));
        cartDetailVO.setSpecName(rs.getString("specName"));
        cartDetailVO.setImage(rs.getString("image"));
        return cartDetailVO;
    }
}
