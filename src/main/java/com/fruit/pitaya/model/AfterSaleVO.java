package com.fruit.pitaya.model;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.List;

/**
 * Created by hanlei6 on 2016/11/3.
 */
@Setter
@Getter
public class AfterSaleVO {
    private String asodID;
    private String customer;
    private String executer;
    private String express;
    private String courierNum;
    private String bkexpress;
    private String bkcourierNum;
    private BigDecimal amount;
    private String addr;
    private int status;
    private List<AfterSaleDetailVO> afterSaleDetailVOs;
}
