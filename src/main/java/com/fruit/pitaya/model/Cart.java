package com.fruit.pitaya.model;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by hanlei6 on 2016/10/26.
 */
@Setter
@Getter
public class Cart implements Serializable {
    private String cusCode;
    private Integer totalCount;
    private BigDecimal amount;
    private List<CartDetailVO> cartDetailVOs = new ArrayList<>();
}
