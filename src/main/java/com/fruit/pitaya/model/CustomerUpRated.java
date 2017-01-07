package com.fruit.pitaya.model;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

/**
 * Created by JesseHan on 2017/1/7.
 */
@Setter
@Getter
public class CustomerUpRated {
    private Long id;
    private String customer;
    private String up;
    private String sku;
    private BigDecimal rated;
}
