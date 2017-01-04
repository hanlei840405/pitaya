package com.fruit.pitaya.mapper;

import com.fruit.pitaya.model.CustomerRatedDeVO;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by hanlei6 on 2016/10/26.
 */
public class CustomerRatedDeVOMapper implements RowMapper<CustomerRatedDeVO> {
    @Override
    public CustomerRatedDeVO mapRow(ResultSet rs, int rowNum) throws SQLException {
        CustomerRatedDeVO customerRatedDeVO = new CustomerRatedDeVO();
        customerRatedDeVO.setId(rs.getLong("id"));
        customerRatedDeVO.setAmount(rs.getBigDecimal("amount"));
        customerRatedDeVO.setSku(rs.getString("sku"));
        customerRatedDeVO.setOrderDeID(rs.getLong("orderDeID"));
        customerRatedDeVO.setRateID(rs.getLong("rateID"));
        customerRatedDeVO.setSkuName(rs.getString("skuName"));
        customerRatedDeVO.setOrderDeAmount(rs.getBigDecimal("orderDeAmount"));
        return customerRatedDeVO;
    }
}
