package com.fruit.pitaya.controller;

import com.fruit.pitaya.model.Customer;
import com.fruit.pitaya.service.CustomerService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Created by hanlei6 on 2016/10/12.
 */
@Controller
public class CustomerController {
    private static final Logger log = LoggerFactory.getLogger(CustomerService.class);
    @Autowired
    private CustomerService customerService;

    @RequestMapping(value = "/updateMe", method = RequestMethod.POST)
    public String updateMe(Customer customer, Model model) {
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Customer exist = customerService.get(user.getUsername());
        exist.setUpCode(customer.getUpCode());
        exist.setSex(customer.getSex());
        exist.setPhone(customer.getPhone());
        exist.setWechat(customer.getWechat());
        exist.setEmail(customer.getEmail());
        exist.setSaler(customer.getSaler());
        try {
            customerService.update(exist);
        } catch (Exception e) {
            log.error("UPDATE CUSTOMER : {}", exist);
            model.addAttribute("errorCode", "500");
            model.addAttribute("errorMsg", "保存失败");
        }
        return "profile";
    }
}
