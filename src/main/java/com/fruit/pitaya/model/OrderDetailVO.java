package com.fruit.pitaya.model;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

/**
 * Created by hanlei6 on 2016/10/31.
 */
@Setter
@Getter
public class OrderDetailVO {
    private Long id;
    private String orderID;
    private String sku;
    private String skuName;
    private String specName;
    private int quantity;
    private BigDecimal price;
    private BigDecimal allcost;
    private String image;
}
