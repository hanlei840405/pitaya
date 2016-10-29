package com.fruit.pitaya.mapper;

import com.fruit.pitaya.model.Cart;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by hanlei6 on 2016/10/26.
 */
public class CartMapper implements RowMapper<Cart> {
    @Override
    public Cart mapRow(ResultSet rs, int rowNum) throws SQLException {
        Cart cart = new Cart();
        cart.setAmount(rs.getBigDecimal("amount"));
        cart.setCusCode(rs.getString("cusCode"));
        cart.setTotalCount(rs.getInt("totalCount"));
        return cart;
    }
}
