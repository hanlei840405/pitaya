package com.fruit.pitaya.mapper;

import com.fruit.pitaya.model.OrderDetail;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by hanlei6 on 2016/10/31.
 */
public class OrderDetailMapper implements RowMapper<OrderDetail> {
    @Override
    public OrderDetail mapRow(ResultSet rs, int rowNum) throws SQLException {
        OrderDetail orderDetail = new OrderDetail();
        orderDetail.setId(rs.getLong("id"));
        orderDetail.setSku(rs.getString("sku"));
        orderDetail.setAllcost(rs.getBigDecimal("allcost"));
        orderDetail.setOrderID(rs.getString("orderID"));
        orderDetail.setPrice(rs.getBigDecimal("price"));
        orderDetail.setQuantity(rs.getInt("quantity"));
        return orderDetail;
    }
}
