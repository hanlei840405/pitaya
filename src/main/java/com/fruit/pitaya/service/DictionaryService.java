package com.fruit.pitaya.service;

import com.fruit.pitaya.mapper.DictionaryMapper;
import com.fruit.pitaya.model.Dictionary;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by JesseHan on 2017/1/6.
 */
@Service
public class DictionaryService {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<Dictionary> getByType(String name) {
        List<Dictionary> dictionaries = jdbcTemplate.query("SELECT * FROM ecss.dict_data t1 INNER JOIN dict_type t2 ON t1.dict_type_id=t2.id WHERE t2.name=?", preparedStatement -> {
            preparedStatement.setString(1, name);
        }, new DictionaryMapper());
        return dictionaries;
    }
}
