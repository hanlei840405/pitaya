package com.fruit.pitaya.mapper;

import com.fruit.pitaya.model.SkuVO;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by hanlei6 on 2016/10/25.
 */
public class SkuVOMapper implements RowMapper<SkuVO> {
    @Override
    public SkuVO mapRow(ResultSet rs, int rowNum) throws SQLException {
        SkuVO skuVO = new SkuVO();
        skuVO.setAttribute(rs.getString("attribute"));
        skuVO.setCategory(rs.getString("category"));
        skuVO.setImage(rs.getString("image"));
        skuVO.setRemark(rs.getString("remark"));
        skuVO.setSku(rs.getString("sku"));
        skuVO.setSkuName(rs.getString("skuName"));
        skuVO.setSpecName(rs.getString("specName"));
        skuVO.setStatus(rs.getInt("status"));
        skuVO.setPrice(rs.getBigDecimal("price"));
        skuVO.setNum1(rs.getInt("num1"));
        skuVO.setPrice1(rs.getBigDecimal("price1"));
        skuVO.setNum2(rs.getInt("num2"));
        skuVO.setPrice2(rs.getBigDecimal("price2"));
        skuVO.setNum3(rs.getInt("num3"));
        skuVO.setPrice3(rs.getBigDecimal("price3"));
        skuVO.setQuantity(rs.getLong("quantity"));
        skuVO.setExclusive(rs.getString("exclusive"));
        return skuVO;
    }
}
