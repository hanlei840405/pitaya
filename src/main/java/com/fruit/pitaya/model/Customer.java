package com.fruit.pitaya.model;

import lombok.Getter;
import lombok.Setter;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * Created by hanlei6 on 2016/10/12.
 */
@Setter
@Getter
public class Customer implements Serializable {
    private Long id;
    private String cusCode;
    private String cusName;
    private String passwd;
    private int status;
    private String sex;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date birthday;
    private String email;
    private String phone;
    private String wechat;
    private String upCode;
    private String saler;
    private BigDecimal rate;
    private BigDecimal amount;
    private String priceType;
    private String cusType;
    private int coupon;
}
