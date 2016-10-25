package com.fruit.pitaya.service;

import com.fruit.pitaya.mapper.CategoryMapper;
import com.fruit.pitaya.model.Category;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by hanlei6 on 2016/10/18.
 */
@Service
public class CategoryService {
    private static final Logger log = LoggerFactory.getLogger(CategoryService.class);
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<Category> findAllCategories() {
        List<Category> categories = jdbcTemplate.query("SELECT * FROM mall_category WHERE parentCode is NULL ", new CategoryMapper());
        for (Category category : categories) {
            List<Category> subList = jdbcTemplate.query("SELECT * FROM mall_category WHERE parentCode =? ", new Object[]{category.getCateCode()}, new CategoryMapper());
            category.getCategories().addAll(subList);
        }
        return categories;
    }

    public List<Category> findAllSubCategories() {
        List<Category> categories = jdbcTemplate.query("SELECT * FROM mall_category WHERE parentCode is NOT NULL ", new CategoryMapper());
        return categories;
    }
}
