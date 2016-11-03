package com.fruit.pitaya.model;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

/**
 * Created by hanlei6 on 2016/11/3.
 */
@Setter
@Getter
public class AfterSaleVO {
    private String asodID;
    private String customer;
    private Integer status;
    private String bkcourier;
    private Long addrID;
    private String executer;
    private String express;
    private String cusName;
    private String addr;
    private List<AfterSaleDetailVO> afterSaleDetailVOs;
}
