package com.fruit.pitaya.mapper;

import com.fruit.pitaya.model.CustomerRatedVO;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by hanlei6 on 2016/10/26.
 */
public class CustomerRatedVOMapper implements RowMapper<CustomerRatedVO> {
    @Override
    public CustomerRatedVO mapRow(ResultSet rs, int rowNum) throws SQLException {
        CustomerRatedVO customerRatedVO = new CustomerRatedVO();
        customerRatedVO.setId(rs.getLong("id"));
        customerRatedVO.setAmount(rs.getBigDecimal("amount"));
        customerRatedVO.setCustomer(rs.getString("customer"));
        customerRatedVO.setOrderID(rs.getString("orderID"));
        customerRatedVO.setOrderAmount(rs.getBigDecimal("orderAmount"));
        customerRatedVO.setOrderDate(rs.getDate("odtime"));
        return customerRatedVO;
    }
}
