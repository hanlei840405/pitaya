package com.fruit.pitaya.service;

import com.fruit.pitaya.mapper.SequenceMapper;
import com.fruit.pitaya.model.Sequence;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by hanlei6 on 2016/10/18.
 */
@Service
public class SequenceService {
    private static final Logger log = LoggerFactory.getLogger(SequenceService.class);
    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Transactional(propagation = Propagation.REQUIRES_NEW)
    public String generateCode(String category) {
        int code = 10000;
        List<Sequence> sequences = jdbcTemplate.query("SELECT * FROM console_sequence WHERE category=?", new Object[]{category}, new SequenceMapper());
        if (!sequences.isEmpty()) {
            Sequence sequence = sequences.get(0);
            code = sequence.getCode();
        }

        boolean loop = true;
        while (loop) {
            try {
                if (++code == 10001) {
                    jdbcTemplate.update("INSERT INTO console_sequence (category,code) VALUE (?,?)", new Object[]{category, code});
                } else {
                    jdbcTemplate.update("UPDATE console_sequence SET code=? WHERE category=?", new Object[]{code, category});
                }
                loop = false;
            } catch (Exception e) {
                log.error("category {} code {} is old...", category, code);
            }
        }
        return String.valueOf(code);
    }
}
