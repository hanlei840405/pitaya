package com.fruit.pitaya.service;

import com.fruit.pitaya.mapper.SkuVOMapper;
import com.fruit.pitaya.model.Sku;
import com.fruit.pitaya.model.SkuVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by hanlei6 on 2016/10/25.
 */
@Service
public class SkuService {
    private static final Logger log = LoggerFactory.getLogger(SkuService.class);
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<Sku> findByCategory(String category) {
        String sql = "SELECT * FROM mall_sku WHERE t1.category is null AND t1.status=1 AND t1.category = ?";
        return jdbcTemplate.queryForList(sql, Sku.class, category);
    }

    public List<SkuVO> findByCategory(String category, String customer, String priceType) {
        StringBuilder builder = new StringBuilder("SELECT t1.skuName,t1.sku,t1.image,t1.category,t1.attribute,t1.status,t1.specName,t1.remark,t1.image,t2.price,t3.num1,t3.price1,t3.num2, t3.price2, t3.num3,t3.price3,t4.quantity");
        builder.append(" FROM mall_sku t1").append(" LEFT JOIN mall_sku_sprice t2 ON t1.sku = t2.sku AND t2.customer=?").append(" LEFT JOIN mall_sku_nprice t3 ON t1.sku = t3.sku AND t3.priceType=?")
                .append(" INNER JOIN sk_stock t4 ON t4.sku = t1.sku").append(" WHERE t1.category=?");
        return jdbcTemplate.query(builder.toString(), new Object[]{customer, priceType, category}, new SkuVOMapper());
    }
}
