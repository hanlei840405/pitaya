package com.fruit.pitaya.mapper;

import com.fruit.pitaya.model.OrderDetailVO;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by hanlei6 on 2016/10/31.
 */
public class OrderDetailVOMapper implements RowMapper<OrderDetailVO> {
    @Override
    public OrderDetailVO mapRow(ResultSet rs, int rowNum) throws SQLException {
        OrderDetailVO orderDetailVO = new OrderDetailVO();
        orderDetailVO.setId(rs.getLong("id"));
        orderDetailVO.setSku(rs.getString("sku"));
        orderDetailVO.setSkuName(rs.getString("skuName"));
        orderDetailVO.setSpecName(rs.getString("specName"));
        orderDetailVO.setAllcost(rs.getBigDecimal("allcost"));
        orderDetailVO.setOrderID(rs.getString("orderID"));
        orderDetailVO.setPrice(rs.getBigDecimal("price"));
        orderDetailVO.setQuantity(rs.getInt("quantity"));
        return orderDetailVO;
    }
}
