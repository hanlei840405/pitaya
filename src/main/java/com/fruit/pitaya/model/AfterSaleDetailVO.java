package com.fruit.pitaya.model;

import lombok.Getter;
import lombok.Setter;

/**
 * Created by hanlei6 on 2016/11/3.
 */
@Setter
@Getter
public class AfterSaleDetailVO {
    private Long id;
    private String asodID;
    private String sku;
    private Integer quantity;
    private Integer newqty;
    private String remark;
    private String skuName;
    private String specName;
    private String image;
}
