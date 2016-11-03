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
        afterSale.setAddrID(rs.getLong("addrID"));
        afterSale.setAsodID(rs.getString("asodID"));
        afterSale.setBkcourier(rs.getString("bkcourier"));
        afterSale.setExecuter(rs.getString("executer"));
        afterSale.setStatus(rs.getInt("status"));
        afterSale.setExecuter(rs.getString("express"));
        return afterSale;
    }
}
