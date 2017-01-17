package com.fruit.pitaya.mapper;

import com.fruit.pitaya.model.CustomerGift;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by hanlei6 on 2016/10/26.
 */
public class CustomerGiftMapper implements RowMapper<CustomerGift> {
    @Override
    public CustomerGift mapRow(ResultSet rs, int rowNum) throws SQLException {
        CustomerGift customerGift = new CustomerGift();
        customerGift.setId(rs.getLong("id"));
        customerGift.setRelationship(rs.getString("relationship"));
        customerGift.setCustomer(rs.getString("customer"));
        customerGift.setOrderID(rs.getString("orderID"));
        customerGift.setStatus(rs.getString("status"));
        return customerGift;
    }
}
