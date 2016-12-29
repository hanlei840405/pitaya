package com.fruit.pitaya.model;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.Date;

/**
 * Created by hanlei6 on 2016/10/31.
 */
@Setter
@Getter
public class Order {
    private String orderID;
    private String customer;
    private String reviewer;
    private Long addrID;
    private BigDecimal cost;
    private BigDecimal amount;
    private String courierNum;
    private int status;
    private Date odtime;
    private String express;
    private String certificate;
    private Date rated;
    private Date rebated;
}
