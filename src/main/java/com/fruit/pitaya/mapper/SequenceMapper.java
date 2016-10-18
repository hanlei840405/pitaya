package com.fruit.pitaya.mapper;

import com.fruit.pitaya.model.Sequence;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by hanlei6 on 2016/10/18.
 */
public class SequenceMapper implements RowMapper<Sequence> {
    @Override
    public Sequence mapRow(ResultSet rs, int rowNum) throws SQLException {
        Sequence sequence = new Sequence();
        sequence.setId(rs.getLong("id"));
        sequence.setCategory(rs.getString("category"));
        sequence.setCode(rs.getInt("code"));
        return sequence;
    }
}
