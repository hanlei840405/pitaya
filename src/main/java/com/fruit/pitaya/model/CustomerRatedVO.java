package com.fruit.pitaya.model;

import lombok.Getter;
import lombok.Setter;
import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by hanlei6 on 2017/1/4.
 */
@Setter
@Getter
public class CustomerRatedVO {
    private Long id;
    private String customer;
    private String orderID;
    private BigDecimal amount;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date orderDate;
    private BigDecimal orderAmount;
    private List<CustomerRatedDeVO> customerRatedDeVOs = new ArrayList<>();
}
