package com.fruit.pitaya.model;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

/**
 * Created by hanlei6 on 2016/10/25.
 */
@Setter
@Getter
public class Sku implements Serializable {
    private Long id;
    private String skuName;
    private String sku;
    private String category;
    private String attribute;
    private Integer status;
    private String specName;
    private String image;
    private String remark;
    private String exclusive;
}
