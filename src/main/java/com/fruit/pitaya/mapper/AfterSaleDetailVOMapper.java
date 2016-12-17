package com.fruit.pitaya.mapper;

import com.fruit.pitaya.model.AfterSaleDetailVO;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by hanlei6 on 2016/11/3.
 */
public class AfterSaleDetailVOMapper implements RowMapper<AfterSaleDetailVO> {
    @Override
    public AfterSaleDetailVO mapRow(ResultSet rs, int rowNum) throws SQLException {
        AfterSaleDetailVO afterSaleDetailVO = new AfterSaleDetailVO();
        afterSaleDetailVO.setSku(rs.getString("sku"));
        afterSaleDetailVO.setAsodID(rs.getString("asodID"));
        afterSaleDetailVO.setId(rs.getLong("id"));
        afterSaleDetailVO.setNewqty(rs.getInt("newqty"));
        afterSaleDetailVO.setQuantity(rs.getInt("quantity"));
        afterSaleDetailVO.setRemark(rs.getString("remark"));
        afterSaleDetailVO.setSkuName(rs.getString("skuName"));
        afterSaleDetailVO.setSpecName(rs.getString("specName"));
        afterSaleDetailVO.setImage(rs.getString("image"));
        return afterSaleDetailVO;
    }
}
