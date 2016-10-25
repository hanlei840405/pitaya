package com.fruit.pitaya.model;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

/**
 * Created by hanlei6 on 2016/10/25.
 */
@Setter
@Getter
public class SkuNPrice {
    private String sku;
    private String priceType;
    private int num1;
    private BigDecimal price1;
    private int num2;
    private BigDecimal price2;
    private int num3;
    private BigDecimal price3;
}
