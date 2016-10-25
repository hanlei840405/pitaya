package com.fruit.pitaya.model;

import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by hanlei6 on 2016/10/25.
 */
@Setter
@Getter
public class CategoryVO {
    private Category category;
    private List<SkuVO> skus = new ArrayList<>();
}
