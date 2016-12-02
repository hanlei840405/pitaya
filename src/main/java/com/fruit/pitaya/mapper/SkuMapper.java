package com.fruit.pitaya.mapper;

import com.fruit.pitaya.model.Sku;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by hanlei6 on 2016/10/25.
 */
public class SkuMapper implements RowMapper<Sku> {
    @Override
    public Sku mapRow(ResultSet rs, int rowNum) throws SQLException {
        Sku sku = new Sku();
        sku.setAttribute(rs.getString("attribute"));
        sku.setCategory(rs.getString("category"));
        sku.setId(rs.getLong("id"));
        sku.setImage(rs.getString("image"));
        sku.setRemark(rs.getString("remark"));
        sku.setSku(rs.getString("sku"));
        sku.setSkuName(rs.getString("skuName"));
        sku.setSpecName(rs.getString("specName"));
        sku.setStatus(rs.getInt("status"));
        sku.setExclusive(rs.getString("exclusive"));
        return sku;
    }
}
