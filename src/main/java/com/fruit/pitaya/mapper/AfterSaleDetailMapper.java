package com.fruit.pitaya.mapper;

import com.fruit.pitaya.model.AfterSaleDetail;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by hanlei6 on 2016/11/3.
 */
public class AfterSaleDetailMapper implements RowMapper<AfterSaleDetail> {
    @Override
    public AfterSaleDetail mapRow(ResultSet rs, int rowNum) throws SQLException {
        AfterSaleDetail afterSaleDetail = new AfterSaleDetail();
        afterSaleDetail.setSku(rs.getString("sku"));
        afterSaleDetail.setAsodID(rs.getString("asodID"));
        afterSaleDetail.setId(rs.getLong("id"));
        afterSaleDetail.setNewqty(rs.getInt("newqty"));
        afterSaleDetail.setQuantity(rs.getInt("quantity"));
        afterSaleDetail.setRemark(rs.getString("remark"));
        return afterSaleDetail;
    }
}
