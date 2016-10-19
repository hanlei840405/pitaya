package com.fruit.pitaya.model;

import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by hanlei6 on 2016/10/19.
 */
@Setter
@Getter
public class Category {
    private Long id;
    private String cateName;
    private String cateCode;
    private String parentCode;
    private List<Category> categories = new ArrayList<>();
}
