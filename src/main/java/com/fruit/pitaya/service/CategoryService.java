package com.fruit.pitaya.service;

import com.fruit.pitaya.mapper.CategoryMapper;
import com.fruit.pitaya.model.Category;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.stereotype.Service;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

/**
 * Created by hanlei6 on 2016/10/18.
 */
@Service
public class CategoryService {
    private static final Logger log = LoggerFactory.getLogger(CategoryService.class);
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public Category get(String cateCode) {
        List<Category> categories = jdbcTemplate.query("SELECT * FROM mall_category WHERE cateCode=?", ps -> {
            ps.setString(1, cateCode);
        }, new CategoryMapper());
        if (categories.isEmpty()) {
            return null;
        }
        return categories.get(0);
    }

    public List<Category> findAllCategories() {
        List<Category> categories = jdbcTemplate.query("SELECT * FROM mall_category WHERE parentCode IS NULL ", new CategoryMapper());
        for (Category category : categories) {
            List<Category> subList = jdbcTemplate.query("SELECT * FROM mall_category WHERE parentCode =? ", ps -> {
                ps.setString(1, category.getCateCode());
            }, new CategoryMapper());
            category.getCategories().addAll(subList);
        }
        return categories;
    }

    public List<Category> findSubCategories(String cateCode) {
        List<Category> categories = jdbcTemplate.query("SELECT * FROM mall_category WHERE parentCode=? ", ps -> {
            ps.setString(1, cateCode);
        }, new CategoryMapper());
        return categories;
    }

    public List<Category> findAllRootCategories() {
        List<Category> categories = jdbcTemplate.query("SELECT * FROM mall_category WHERE parentCode IS NULL ", new CategoryMapper());
        return categories;
    }
}
