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
        afterSaleVO.setAddrID(rs.getLong("addrID"));
        afterSaleVO.setAsodID(rs.getString("asodID"));
        afterSaleVO.setBkcourier(rs.getString("bkcourier"));
        afterSaleVO.setExecuter(rs.getString("executer"));
        afterSaleVO.setStatus(rs.getInt("status"));
        afterSaleVO.setExecuter(rs.getString("express"));
        afterSaleVO.setCusName(rs.getString("cusName"));
        afterSaleVO.setAddr(rs.getString("addr"));
        return afterSaleVO;
    }
}
