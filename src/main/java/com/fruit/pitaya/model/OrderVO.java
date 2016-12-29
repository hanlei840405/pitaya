package com.fruit.pitaya.model;

import lombok.Getter;
import lombok.Setter;
import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * Created by hanlei6 on 2016/10/31.
 */
@Setter
@Getter
public class OrderVO {
    private String orderID;
    private String customerName;
    private String reviewerName;
    private String addr;
    private BigDecimal cost;
    private BigDecimal amount;
    private String courierNum;
    private int status;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date odtime;
    private String express;
    private String certificate;
    private List<OrderDetailVO> orderDetailVOs;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date rated;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date rebated;
}
