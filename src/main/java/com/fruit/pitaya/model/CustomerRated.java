package com.fruit.pitaya.model;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

/**
 * Created by hanlei6 on 2017/1/4.
 */
@Setter
@Getter
public class CustomerRated {
    private Long id;
    private String customer;
    private String orderID;
    private BigDecimal amount;
}
