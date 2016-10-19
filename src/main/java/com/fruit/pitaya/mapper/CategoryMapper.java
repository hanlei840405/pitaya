package com.fruit.pitaya.mapper;

import com.fruit.pitaya.model.Category;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by hanlei6 on 2016/10/18.
 */
public class CategoryMapper implements RowMapper<Category> {
    @Override
    public Category mapRow(ResultSet rs, int rowNum) throws SQLException {
        Category category = new Category();
        category.setId(rs.getLong("id"));
        category.setCateCode(rs.getString("cateCode"));
        category.setCateName(rs.getString("cateName"));
        category.setParentCode(rs.getString("parentCode"));
        return category;
    }
}
