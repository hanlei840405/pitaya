package com.fruit.pitaya.mapper;

import com.fruit.pitaya.model.Order;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by hanlei6 on 2016/10/31.
 */
public class OrderMapper implements RowMapper<Order> {
    @Override
    public Order mapRow(ResultSet rs, int rowNum) throws SQLException {
        Order order = new Order();
        order.setAddrID(rs.getLong("addrID"));
        order.setAmount(rs.getBigDecimal("amount"));
        order.setCourierNum(rs.getString("courierNum"));
        order.setCustomer(rs.getString("customer"));
        order.setExpress(rs.getString("express"));
        order.setOdtime(rs.getDate("odtime"));
        order.setReviewer(rs.getString("reviewer"));
        order.setStatus(rs.getInt("status"));
        return order;
    }
}
