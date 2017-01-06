package com.fruit.pitaya.mapper;

import com.fruit.pitaya.model.Dictionary;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by JesseHan on 2017/1/6.
 */
public class DictionaryMapper implements RowMapper<Dictionary> {
    @Override
    public Dictionary mapRow(ResultSet resultSet, int i) throws SQLException {
        Dictionary dictionary = new Dictionary();
        dictionary.setId(resultSet.getLong("id"));
        dictionary.setName(resultSet.getString("name"));
        dictionary.setValue(resultSet.getString("value"));
        return dictionary;
    }
}
