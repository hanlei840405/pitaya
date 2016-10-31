package com.fruit.pitaya.mapper;

import com.fruit.pitaya.model.OrderAddr;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by hanlei6 on 2016/10/31.
 */
public class OrderAddrMapper implements RowMapper<OrderAddr> {
    @Override
    public OrderAddr mapRow(ResultSet rs, int rowNum) throws SQLException {
        OrderAddr orderAddr = new OrderAddr();
        orderAddr.setAddr(rs.getString("addr"));
        orderAddr.setOrderID(rs.getString("orderID"));
        return orderAddr;
    }
}
