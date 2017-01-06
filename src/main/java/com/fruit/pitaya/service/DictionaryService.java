package com.fruit.pitaya.service;

import com.fruit.pitaya.mapper.DictionaryMapper;
import com.fruit.pitaya.model.Dictionary;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.stereotype.Service;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

/**
 * Created by JesseHan on 2017/1/6.
 */
@Service
public class DictionaryService {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public Dictionary get(String name) {
        List<Dictionary> dictionaries = jdbcTemplate.query("SELECT * FROM ecss.dict_data WHERE name=?", new PreparedStatementSetter() {
            @Override
            public void setValues(PreparedStatement preparedStatement) throws SQLException {
                preparedStatement.setString(1, name);
            }
        }, new DictionaryMapper());
        if (!dictionaries.isEmpty()) {
            return dictionaries.get(0);
        }
        return null;
    }
}
