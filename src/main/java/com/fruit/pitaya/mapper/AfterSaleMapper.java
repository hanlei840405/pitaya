package com.fruit.pitaya.mapper;

import com.fruit.pitaya.model.AfterSale;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by hanlei6 on 2016/11/3.
 */
public class AfterSaleMapper implements RowMapper<AfterSale> {
    @Override
    public AfterSale mapRow(ResultSet rs, int rowNum) throws SQLException {
        AfterSale afterSale = new AfterSale();
        afterSale.setCustomer(rs.getString("customer"));
        afterSale.setAddr(rs.getString("addr"));
        afterSale.setAsodID(rs.getString("asodID"));
        afterSale.setCourierNum(rs.getString("courierNum"));
        afterSale.setStatus(rs.getInt("status"));
        afterSale.setExecuter(rs.getString("express"));
        afterSale.setExpress(rs.getString("express"));
        afterSale.setBkexpress(rs.getString("bkexpress"));
        afterSale.setBkcourierNum(rs.getString("bkcourierNum"));
        afterSale.setAmount(rs.getBigDecimal("amount"));
        return afterSale;
    }
}
