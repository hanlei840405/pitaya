package com.fruit.pitaya.service;

import com.fruit.pitaya.mapper.AfterSaleDetailVOMapper;
import com.fruit.pitaya.mapper.AfterSaleVOMapper;
import com.fruit.pitaya.model.AfterSale;
import com.fruit.pitaya.model.AfterSaleDetail;
import com.fruit.pitaya.model.AfterSaleVO;
import com.fruit.pitaya.util.Constant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

/**
 * Created by hanlei6 on 2016/11/3.
 */
@Service
public class AfterSaleService {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<AfterSaleVO> findByCustomer(String customer, int page) {
        List<AfterSaleVO> afterSaleVOs = jdbcTemplate.query("SELECT t1.*,t2.cusName FROM as_aftersaleod t1 INNER JOIN mall_customer t2 ON t1.customer = t2.cusCode WHERE t1.customer=? LIMIT ?,?", ps -> {
            ps.setString(1, customer);
            ps.setInt(2, (page - 1) * Constant.PAGE_SIZE);
            ps.setInt(3, Constant.PAGE_SIZE);
        }, new AfterSaleVOMapper());
        afterSaleVOs.forEach(afterSaleVO -> afterSaleVO.setAfterSaleDetailVOs(jdbcTemplate.query("SELECT t1.*,t2.skuName,t2.specName,t2.image  FROM as_aftersaleod_de t1 INNER JOIN mall_sku t2 ON t1.sku = t2.sku AND t1.asodID = ?", ps -> {
            ps.setString(1, afterSaleVO.getAsodID());
        }, new AfterSaleDetailVOMapper())));
        return afterSaleVOs;
    }

    public Long count(String customer) {
        Map<String, Object> result = jdbcTemplate.queryForMap("SELECT COUNT(*) AS cnt FROM as_aftersaleod WHERE customer=?", customer);
        return (Long) result.get("cnt");
    }

    @Transactional
    public void createAfterSale(AfterSale afterSale, List<AfterSaleDetail> afterSaleDetails) {
        afterSale.setStatus(0);
        jdbcTemplate.update("INSERT INTO as_aftersaleod (asodID, customer, executer, status, express, courierNum, bkexpress, bkcourierNum, amount, addr) VALUES (?,?,?,?,?,?,?,?,?,?)", new PreparedStatementSetter() {
            @Override
            public void setValues(PreparedStatement ps) throws SQLException {
                ps.setString(1, afterSale.getAsodID());
                ps.setString(2, afterSale.getCustomer());
                ps.setString(3, afterSale.getExecuter());
                ps.setInt(4, afterSale.getStatus());
                ps.setString(5, afterSale.getExpress());
                ps.setString(6, afterSale.getCourierNum());
                ps.setString(7, afterSale.getBkexpress());
                ps.setString(8, afterSale.getBkcourierNum());
                ps.setBigDecimal(9, afterSale.getAmount());
                ps.setString(10, afterSale.getAddr());
            }
        });
        jdbcTemplate.batchUpdate("INSERT INTO as_aftersaleod_de (asodID, sku, quantity) VALUES (?,?,?)",
                new BatchPreparedStatementSetter() {
                    @Override
                    public void setValues(PreparedStatement ps, int i) throws SQLException {
                        ps.setString(1, afterSaleDetails.get(i).getAsodID());
                        ps.setString(2, afterSaleDetails.get(i).getSku());
                        ps.setInt(3, afterSaleDetails.get(i).getQuantity());
                    }

                    @Override
                    public int getBatchSize() {
                        return afterSaleDetails.size();
                    }
                });
    }
}
