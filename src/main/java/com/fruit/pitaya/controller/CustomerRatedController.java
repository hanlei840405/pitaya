package com.fruit.pitaya.controller;

import com.fruit.pitaya.model.CustomerRatedVO;
import com.fruit.pitaya.service.CustomerRatedService;
import com.fruit.pitaya.service.CustomerService;
import com.fruit.pitaya.util.Constant;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

/**
 * Created by hanlei6 on 2016/10/12.
 */
@Controller
@RequestMapping("/customerRated")
public class CustomerRatedController {
    private static final Logger log = LoggerFactory.getLogger(CustomerService.class);
    @Autowired
    private CustomerRatedService customerRatedService;

    @RequestMapping("/show/{page}")
    public String show(@PathVariable("page") int page, Model model) {
        if (page <= 0) {
            page = 1;
        }
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        User user = (User) principal;
        List<CustomerRatedVO> customerRatedVOs = customerRatedService.findByCustomer(user.getUsername(), page);
        model.addAttribute("customerRatedVOs", customerRatedVOs);
        return "rate";
    }

    @RequestMapping("/page/{page}")
    public String page(@PathVariable("page") int page, Model model) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        User user = (User) principal;
        Long count = customerRatedService.count(user.getUsername());
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
        model.addAttribute("firstUrl", "customerRated/show/1/");
        model.addAttribute("preUrl", "customerRated/show/" + pre);
        model.addAttribute("nextUrl", "customerRated/show/" + next);
        model.addAttribute("lastUrl", "customerRated/show/" + pages);
        return "page";
    }
}
