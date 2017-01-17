package com.fruit.pitaya.model;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

/**
 * Created by hanlei6 on 2017/1/4.
 */
@Setter
@Getter
public class CustomerGift {
    private Long id;
    private String customer;
    private String relationship;
    private String orderID;
    private String status;
}
