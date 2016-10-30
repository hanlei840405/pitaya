package com.fruit.pitaya.mapper;

import com.fruit.pitaya.model.CustomerAddr;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by hanlei6 on 2016/10/18.
 */
public class CustomerAddrMapper implements RowMapper<CustomerAddr> {
    @Override
    public CustomerAddr mapRow(ResultSet rs, int rowNum) throws SQLException {
        CustomerAddr customerAddr = new CustomerAddr();
        customerAddr.setId(rs.getLong("id"));
        customerAddr.setAddr(rs.getString("addr"));
        customerAddr.setCustomer(rs.getString("customer"));
        customerAddr.setPhone(rs.getString("phone"));
        customerAddr.setRecipient(rs.getString("recipient"));
        customerAddr.setUsed(rs.getString("used"));
        return customerAddr;
    }
}
