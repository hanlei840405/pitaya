package com.fruit.pitaya.service;

import com.fruit.pitaya.mapper.AfterSaleDetailVOMapper;
import com.fruit.pitaya.mapper.AfterSaleVOMapper;
import com.fruit.pitaya.model.AfterSale;
import com.fruit.pitaya.model.AfterSaleDetail;
import com.fruit.pitaya.model.AfterSaleVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

/**
 * Created by hanlei6 on 2016/11/3.
 */
@Service
public class AfterSaleService {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<AfterSaleVO> find(String cusCode) {
        List<AfterSaleVO> afterSaleVOs = jdbcTemplate.query("SELECT t1.*,t2.cusName,t3.addr FROM as_aftersaleod t1 INNER JOIN mall_customer t2 ON t1.customer = t2.cusCode INNER JOIN mall_customer_addr t3 ON t1.addrID = t3.id WHERE t1.customer=?", new Object[]{cusCode}, new AfterSaleVOMapper());
        for (AfterSaleVO afterSaleVO : afterSaleVOs) {
            afterSaleVO.setAfterSaleDetailVOs(jdbcTemplate.query("SELECT t1.*,t2.skuName,t2.specName FROM as_aftersaleod_de t1 INNER JOIN mall_sku t2 ON t1.asodID = t2.asodID AND t1.asodID = ?", new Object[]{afterSaleVO.getAsodID()}, new AfterSaleDetailVOMapper()));
        }
        return afterSaleVOs;
    }

    @Transactional
    public void createAfterSale(AfterSale afterSale, List<AfterSaleDetail> afterSaleDetails) {
        jdbcTemplate.update("as_aftersaleod (asodID, customer, status, bkcourier, addrID, executer, express) VALUE (?,?,?,?,?,?,?)", new PreparedStatementSetter() {
            @Override
            public void setValues(PreparedStatement ps) throws SQLException {
                ps.setString(1, afterSale.getAsodID());
                ps.setString(2, afterSale.getCustomer());
                ps.setInt(3, afterSale.getStatus());
                ps.setString(4, afterSale.getBkcourier());
                ps.setLong(5, afterSale.getAddrID());
                ps.setString(6, afterSale.getExecuter());
                ps.setString(7, afterSale.getExpress());
            }
        });
        jdbcTemplate.batchUpdate("INNER INTO as_aftersaleod_de (asodID, sku, quantity, newqty, remark) VALUE (?,?,?,?,?)",
                new BatchPreparedStatementSetter() {
                    @Override
                    public void setValues(PreparedStatement ps, int i) throws SQLException {
                        ps.setString(1,afterSaleDetails.get(i).getAsodID());
                        ps.setString(2,afterSaleDetails.get(i).getSku());
                        ps.setInt(3,afterSaleDetails.get(i).getQuantity());
                        ps.setInt(4,afterSaleDetails.get(i).getNewqty());
                        ps.setString(5,afterSaleDetails.get(i).getRemark());
                    }

                    @Override
                    public int getBatchSize() {
                        return afterSaleDetails.size();
                    }
                });
    }
}
