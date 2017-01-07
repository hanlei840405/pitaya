package com.fruit.pitaya.mapper;

import com.fruit.pitaya.model.CustomerUpRated;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by hanlei6 on 2016/11/3.
 */
public class CustomerUpRatedMapper implements RowMapper<CustomerUpRated> {
    @Override
    public CustomerUpRated mapRow(ResultSet rs, int rowNum) throws SQLException {
        CustomerUpRated customerUpRated = new CustomerUpRated();
        customerUpRated.setId(rs.getLong("id"));
        customerUpRated.setCustomer(rs.getString("customer"));
        customerUpRated.setUp(rs.getString("up"));
        customerUpRated.setSku(rs.getString("sku"));
        customerUpRated.setRated(rs.getBigDecimal("rated"));
        return customerUpRated;
    }
}
