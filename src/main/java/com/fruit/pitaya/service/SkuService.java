package com.fruit.pitaya.service;

import com.fruit.pitaya.mapper.SkuVOMapper;
import com.fruit.pitaya.model.SkuVO;
import com.fruit.pitaya.util.Constant;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created by hanlei6 on 2016/10/25.
 */
@Service
public class SkuService {
    private static final Logger log = LoggerFactory.getLogger(SkuService.class);
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<SkuVO> findByCategory(String category, String customer, String priceType, int page) {
        StringBuilder builder = new StringBuilder("SELECT t1.skuName,t1.sku,t1.image,t1.category,t1.attribute,t1.status,t1.specName," +
                "t1.remark,t1.image,t1.exclusive,t2.price,t3.num1,t3.price1,t3.num2, t3.price2, t3.num3,t3.price3," +
                "(CASE WHEN t4.quantity - (SELECT IFNULL(t1.value,9999999) FROM dict_data t1 INNER JOIN dict_type t2 ON t1.dict_type_id=t2.id " +
                "WHERE t2.name='库存' AND t1.name='充足') >= 0 THEN -999 ELSE t4.quantity END) AS quantity");
        builder.append(" FROM mall_sku t1").append(" LEFT JOIN mall_sku_sprice t2 ON t1.sku = t2.sku AND t2.customer=?")
                .append(" LEFT JOIN mall_sku_nprice t3 ON t1.sku = t3.sku AND t3.priceType=?")
                .append(" INNER JOIN sk_stock t4 ON t4.sku = t1.sku").append(" WHERE t1.status='1' AND t1.category=? AND (exclusive=0 or exclusive is NULL ) LIMIT ?,?");
        return jdbcTemplate.query(builder.toString(), ps -> {
            ps.setString(1, customer);
            ps.setString(2, priceType);
            ps.setString(3, category);
            ps.setInt(4, (page - 1) * Constant.PAGE_SIZE);
            ps.setInt(5, Constant.PAGE_SIZE);
        }, new SkuVOMapper());
    }

    public Long count(String category) {
        Map<String, Object> result = jdbcTemplate.queryForMap("SELECT COUNT(*) AS cnt FROM mall_sku t1 INNER JOIN sk_stock t2 ON t1.sku = t2.sku WHERE t1.status='1' AND t1.category=? AND (exclusive=0 or exclusive is NULL )", category);
        return (Long) result.get("cnt");
    }

    public Long countExclusiveSku(String customer) {
        Map<String, Object> result = jdbcTemplate.queryForMap("SELECT COUNT(*) AS cnt FROM mall_sku t1 INNER JOIN sk_stock t2 ON t1.sku = t2.sku INNER JOIN mall_customer_sku t3 on t1.sku = t3.sku WHERE t1.status='1' AND t3.customer=? AND exclusive=1", customer);
        return (Long) result.get("cnt");
    }

    public List<SkuVO> findExclusiveSku(String customer, String priceType, int page) {
        StringBuilder builder = new StringBuilder("SELECT t1.skuName,t1.sku,t1.image,t1.category,t1.attribute,t1.status,t1.specName," +
                "t1.remark,t1.image,t1.exclusive,t2.price,t3.num1,t3.price1,t3.num2, t3.price2, t3.num3,t3.price3," +
                "(CASE WHEN t4.quantity - (SELECT IFNULL(t1.value,9999999) FROM dict_data t1 INNER JOIN dict_type t2 ON t1.dict_type_id=t2.id " +
                "WHERE t2.name='库存' AND t1.name='充足') >= 0 THEN -999 ELSE t4.quantity END) AS quantity");
        builder.append(" FROM mall_sku t1").append(" LEFT JOIN mall_sku_sprice t2 ON t1.sku = t2.sku AND t2.customer=?").append(" LEFT JOIN mall_sku_nprice t3 ON t1.sku = t3.sku AND t3.priceType=?")
                .append(" INNER JOIN sk_stock t4 ON t4.sku = t1.sku INNER JOIN mall_customer_sku t5 ON t1.sku=t5.sku").append(" WHERE t1.status='1' AND t5.customer=? AND exclusive=1 LIMIT ?,?");
        return jdbcTemplate.query(builder.toString(), ps -> {
            ps.setString(1, customer);
            ps.setString(2, priceType);
            ps.setString(3, customer);
            ps.setInt(4, (page - 1) * Constant.PAGE_SIZE);
            ps.setInt(5, Constant.PAGE_SIZE);
        }, new SkuVOMapper());
    }
}
