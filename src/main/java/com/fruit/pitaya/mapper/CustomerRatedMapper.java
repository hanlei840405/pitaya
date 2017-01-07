package com.fruit.pitaya.mapper;

import com.fruit.pitaya.model.Cart;
import com.fruit.pitaya.model.CustomerRated;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by hanlei6 on 2016/10/26.
 */
public class CustomerRatedMapper implements RowMapper<CustomerRated> {
    @Override
    public CustomerRated mapRow(ResultSet rs, int rowNum) throws SQLException {
        CustomerRated customerRated = new CustomerRated();
        customerRated.setId(rs.getLong("id"));
        customerRated.setAmount(rs.getBigDecimal("amount"));
        customerRated.setCustomer(rs.getString("customer"));
        customerRated.setOrderID(rs.getString("orderID"));
        customerRated.setStatus(rs.getString("status"));
        return customerRated;
    }
}
