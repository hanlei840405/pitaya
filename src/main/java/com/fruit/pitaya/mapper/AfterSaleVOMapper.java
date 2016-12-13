package com.fruit.pitaya.mapper;

import com.fruit.pitaya.model.AfterSaleVO;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by hanlei6 on 2016/11/3.
 */
public class AfterSaleVOMapper implements RowMapper<AfterSaleVO> {
    @Override
    public AfterSaleVO mapRow(ResultSet rs, int rowNum) throws SQLException {
        AfterSaleVO afterSaleVO = new AfterSaleVO();
        afterSaleVO.setCustomer(rs.getString("customer"));
        afterSaleVO.setAddr(rs.getString("addr"));
        afterSaleVO.setAsodID(rs.getString("asodID"));
        afterSaleVO.setCourierNum(rs.getString("courierNum"));
        afterSaleVO.setStatus(rs.getInt("status"));
        afterSaleVO.setExecuter(rs.getString("express"));
        afterSaleVO.setExpress(rs.getString("express"));
        afterSaleVO.setBkexpress(rs.getString("bkexpress"));
        afterSaleVO.setBkcourierNum(rs.getString("bkcourierNum"));
        afterSaleVO.setAmount(rs.getBigDecimal("amount"));
        return afterSaleVO;
    }
}
