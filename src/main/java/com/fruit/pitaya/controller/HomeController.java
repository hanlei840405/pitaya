package com.fruit.pitaya.controller;

import com.fruit.pitaya.model.Customer;
import com.fruit.pitaya.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

/**
 * Created by hanlei6 on 2016/10/12.
 */
@Controller
public class HomeController {
    @Autowired
    private CustomerService customerService;

    @RequestMapping("/")
    public String home() {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (!principal.equals("anonymousUser")) {
            User user = (User) principal;
            Customer customer = customerService.get(user.getUsername());
            ServletRequestAttributes servletRequestAttributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
            servletRequestAttributes.getRequest().getSession().setAttribute("username", customer.getCusCode());
            servletRequestAttributes.getRequest().getSession().setAttribute("realName", customer.getCusName());
        }
        return "index";
    }

    @RequestMapping("/login")
    public String login() {
        return "login";
    }

    @RequestMapping("/profile")
    public String profile(Model model) {
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Customer customer = customerService.get(user.getUsername());
        model.addAttribute("me", customer);
        return "profile";
    }
}
