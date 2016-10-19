package com.fruit.pitaya.mapper;

import com.fruit.pitaya.model.CustomerShop;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by hanlei6 on 2016/10/18.
 */
public class CustomerShopMapper implements RowMapper<CustomerShop> {
    @Override
    public CustomerShop mapRow(ResultSet rs, int rowNum) throws SQLException {
        CustomerShop customerShop = new CustomerShop();
        customerShop.setId(rs.getLong("id"));
        customerShop.setCustomer(rs.getString("customer"));
        customerShop.setCategory(rs.getString("category"));
        customerShop.setShopAddt(rs.getString("shopAddr"));
        customerShop.setShopName(rs.getString("shopName"));
        customerShop.setShopPic(rs.getString("shopPic"));
        return customerShop;
    }
}
