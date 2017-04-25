package com.fruit.pitaya.controller;

import com.fruit.pitaya.model.Category;
import com.fruit.pitaya.model.Customer;
import com.fruit.pitaya.model.SkuVO;
import com.fruit.pitaya.service.CategoryService;
import com.fruit.pitaya.service.CustomerService;
import com.fruit.pitaya.service.SkuService;
import com.fruit.pitaya.util.Constant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by hanlei6 on 2016/11/15.
 */
@Controller
@RequestMapping("/sku")
public class SkuController {

    @Autowired
    private CustomerService customerService;
    @Autowired
    private CategoryService categoryService;
    @Autowired
    private SkuService skuService;

    @RequestMapping("/show/{page}/{cateCode}")
    public String show(@PathVariable("page") int page, @PathVariable("cateCode") String cateCode, Model model) {
        if (page <= 0) {
            page = 1;
        }
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        /*
         判断是否有登录
         1：未登录：显示sku的D类价格
         2：认证后：判断用户是否是S类用户
            2.1：是，显示S类价格
            2.2：否，显示对应A、B、C、D四类等级的价格
         */
        Category category = categoryService.get(cateCode);
        List<SkuVO> skuVOs;

        if (!principal.equals("anonymousUser")) { // 说明有登录认证
            User user = (User) principal;
            Customer customer = customerService.get(user.getUsername());
            if ("exclusive".equals(cateCode)) { // 专享价格
                skuVOs = skuService.findExclusiveSku(customer.getCusCode(), customer.getPriceType(), page);
            } else {
                skuVOs = skuService.findByCategory(category.getCateCode(), customer.getCusCode(), customer.getPriceType(), page);
            }
            // FIXME 取消用户首单95折显示
//            if (customer.getCoupon() == 1) {
//                for (SkuVO skuVO : skuVOs) {
//                    if (skuVO.getPrice() != null) {
//                        skuVO.setPrice(Utils.round(skuVO.getPrice().multiply(new BigDecimal(0.95)), 2));
//                    }
//                    if (skuVO.getPrice1() != null) {
//                        skuVO.setPrice1(Utils.round(skuVO.getPrice1().multiply(new BigDecimal(0.95)), 2));
//                    }
//                    if (skuVO.getPrice2() != null) {
//                        skuVO.setPrice2(Utils.round(skuVO.getPrice2().multiply(new BigDecimal(0.95)), 2));
//                    }
//                    if (skuVO.getPrice3() != null) {
//                        skuVO.setPrice3(Utils.round(skuVO.getPrice3().multiply(new BigDecimal(0.95)), 2));
//                    }
//                }
//            }
        } else {
            if ("exclusive".equals(cateCode)) {
                skuVOs = new ArrayList<>(0);
            } else {
                skuVOs = skuService.findByCategory(category.getCateCode(), "", "D", page);
            }
        }
        for (SkuVO vo : skuVOs) {
            if (vo.getPrice() == null) {
                Integer num1 = vo.getNum1();
                Integer num2 = vo.getNum2();
                Integer num3 = vo.getNum3();
                if (num1 != num2) {
                    vo.setNum12(vo.getNum2() - 1);
                }
                if (num2 != num3) {
                    vo.setNum22(vo.getNum3() - 1);
                }
            }
        }
        model.addAttribute("skus", skuVOs);
        return "sku";
    }

    @RequestMapping("/page/{page}/{cateCode}")
    public String page(@PathVariable("page") int page, @PathVariable("cateCode") String cateCode, Model model) {
        Long count = 0L;
        if ("exclusive".equals(cateCode)) {
            Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
            if (!principal.equals("anonymousUser")) { // 说明有登录认证
                User user = (User) principal;
                Customer customer = customerService.get(user.getUsername());
                count = skuService.countExclusiveSku(customer.getCusCode());
            }
        } else {
            count = skuService.count(cateCode);
        }
        if (page <= 0) {
            page = 1;
        }
        long pages = (long) Math.ceil(count.doubleValue() / Constant.PAGE_SIZE);
        if (pages - page > 0) {
            model.addAttribute("showNext", true);
        } else {
            model.addAttribute("showNext", false);
        }
        if (page == 1) {
            model.addAttribute("showPre", false);
        } else {
            model.addAttribute("showPre", true);
        }
        int pre = page - 1 == 0 ? page : page - 1;
        int next = page + 1 > pages ? page : page + 1;
        model.addAttribute("cateCode", cateCode);
        model.addAttribute("firstUrl", "sku/show/1/" + cateCode);
        model.addAttribute("preUrl", "sku/show/" + pre + "/" + cateCode);
        model.addAttribute("nextUrl", "sku/show/" + next + "/" + cateCode);
        model.addAttribute("lastUrl", "sku/show/" + pages + "/" + cateCode);
        return "page";
    }
}
