package com.fruit.pitaya.model;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * Created by hanlei6 on 2016/10/12.
 */
@Setter
@Getter
public class Customer implements Serializable {
    private long id;
    private String cusCode;
    private String cusName;
    private String passwd;
    private int status;
    private String sex;
    private Date birthday;
    private String email;
    private String phone;
    private String wechat;
    private String upCode;
    private String upCustomer;
    private String saler;
    private int rate;
    private BigDecimal amount;
}
