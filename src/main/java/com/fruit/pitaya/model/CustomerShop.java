package com.fruit.pitaya.model;

import lombok.Getter;
import lombok.Setter;

/**
 * Created by hanlei6 on 2016/10/18.
 */
@Setter
@Getter
public class CustomerShop {
    private Long id;
    private String customer;
    private String category;
    private String shopName;
    private String shopAddr;
    private String shopPic;
}
