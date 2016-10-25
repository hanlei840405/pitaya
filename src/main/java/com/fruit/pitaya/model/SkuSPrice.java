package com.fruit.pitaya.model;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

/**
 * Created by hanlei6 on 2016/10/25.
 */
@Setter
@Getter
public class SkuSPrice {
    private String sku;
    private String customer;
    private Integer fristbuy;
    private BigDecimal price;
}
