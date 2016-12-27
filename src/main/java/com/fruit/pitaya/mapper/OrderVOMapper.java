package com.fruit.pitaya.mapper;

import com.fruit.pitaya.model.OrderVO;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by hanlei6 on 2016/10/31.
 */
public class OrderVOMapper implements RowMapper<OrderVO> {
    @Override
    public OrderVO mapRow(ResultSet rs, int rowNum) throws SQLException {
        OrderVO orderVO = new OrderVO();
        orderVO.setOrderID(rs.getString("orderID"));
        orderVO.setAddr(rs.getString("addr"));
        orderVO.setCost(rs.getBigDecimal("cost"));
        orderVO.setAmount(rs.getBigDecimal("amount"));
        orderVO.setCourierNum(rs.getString("courierNum"));
        orderVO.setCustomerName(rs.getString("customerName"));
        orderVO.setExpress(rs.getString("express"));
        orderVO.setOdtime(rs.getDate("odtime"));
        orderVO.setReviewerName(rs.getString("reviewerName"));
        orderVO.setStatus(rs.getInt("status"));
        orderVO.setCertificate(rs.getString("certificate"));
        return orderVO;
    }
}
