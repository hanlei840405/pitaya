package com.fruit.pitaya.mapper;

import com.fruit.pitaya.model.CustomerRatedDe;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by hanlei6 on 2016/10/26.
 */
public class CustomerRatedDeMapper implements RowMapper<CustomerRatedDe> {
    @Override
    public CustomerRatedDe mapRow(ResultSet rs, int rowNum) throws SQLException {
        CustomerRatedDe customerRatedDe = new CustomerRatedDe();
        customerRatedDe.setId(rs.getLong("id"));
        customerRatedDe.setAmount(rs.getBigDecimal("amount"));
        customerRatedDe.setSku(rs.getString("sku"));
        customerRatedDe.setRateID(rs.getLong("ratedID"));
        return customerRatedDe;
    }
}
