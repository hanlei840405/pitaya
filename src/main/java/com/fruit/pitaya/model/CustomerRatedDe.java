package com.fruit.pitaya.model;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

/**
 * Created by hanlei6 on 2017/1/4.
 */
@Setter
@Getter
public class CustomerRatedDe {
    private Long id;
    private Long rateID;
    private Long orderDeID;
    private String sku;
    private BigDecimal amount;
}
