package com.fruit.pitaya.model;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

/**
 * Created by hanlei6 on 2016/10/25.
 */
@Setter
@Getter
public class SkuVO {
    private String sku;
    private String skuName;
    private String category;
    private String attribute;
    private Integer status;
    private String specName;
    private String remark;
    private String image;
    private BigDecimal price;
    private Integer num1;
    private BigDecimal price1;
    private Integer num2;
    private BigDecimal price2;
    private Integer num3;
    private BigDecimal price3;
    private Long quantity;
}
