package com.fruit.pitaya.model;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * Created by hanlei6 on 2016/10/26.
 */
@Setter
@Getter
public class CartDetail implements Serializable{
    private Long id;
    private String cusCode;
    private String sku;
    private String priceType;
    private Integer skuCount;
    private BigDecimal price;
    private BigDecimal skuAmount;
}
