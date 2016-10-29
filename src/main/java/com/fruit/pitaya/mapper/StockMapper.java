package com.fruit.pitaya.mapper;

import com.fruit.pitaya.model.Stock;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by hanlei6 on 2016/10/28.
 */
public class StockMapper implements RowMapper<Stock> {
    @Override
    public Stock mapRow(ResultSet rs, int rowNum) throws SQLException {
        Stock stock = new Stock();
        stock.setSku(rs.getString("sku"));
        stock.setQuantity(rs.getLong("quantity"));
        return stock;
    }
}
