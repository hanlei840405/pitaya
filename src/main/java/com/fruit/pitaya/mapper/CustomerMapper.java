package com.fruit.pitaya.mapper;

import com.fruit.pitaya.model.Customer;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by hanlei6 on 2016/10/12.
 */
public class CustomerMapper implements RowMapper<Customer> {
    @Override
    public Customer mapRow(ResultSet rs, int rowNum) throws SQLException {
        Customer customer = new Customer();
        customer.setAmount(rs.getBigDecimal("amount"));
        customer.setCusCode(rs.getString("cusCode"));
        customer.setCusName(rs.getString("cusName"));
        customer.setEmail(rs.getString("email"));
        customer.setId(rs.getLong("id"));
        customer.setPasswd(rs.getString("passwd"));
        customer.setPhone(rs.getString("phone"));
        customer.setRate(rs.getInt("rate"));
        customer.setSaler(rs.getString("saler"));
        customer.setSex(rs.getString("sex"));
        customer.setBirthday(rs.getDate("birthday"));
        customer.setStatus(rs.getInt("status"));
        customer.setUpCode(rs.getString("upCode"));
        customer.setWechat(rs.getString("wechat"));
        customer.setPriceType(rs.getString("priceType"));
        customer.setCusType(rs.getString("cusType"));
        return customer;
    }
}
