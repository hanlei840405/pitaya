package com.fruit.pitaya.controller;

import com.fruit.pitaya.model.*;
import com.fruit.pitaya.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by hanlei6 on 2016/10/12.
 */
@Controller
public class HomeController {

    @Autowired
    private CustomerService customerService;

    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private UserDetailsService userDetailsService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private SkuService skuService;

    @Autowired
    private SkuNPriceService skuNPriceService;

    @Autowired
    private SkuSPriceService skuSPriceService;

    @Autowired
    private CartService cartService;

    @RequestMapping("/")
    public String home(Model model) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (!principal.equals("anonymousUser")) {
            User user = (User) principal;
            Customer customer = customerService.get(user.getUsername());
            ServletRequestAttributes servletRequestAttributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
            servletRequestAttributes.getRequest().getSession().setAttribute("username", customer.getCusCode());
            servletRequestAttributes.getRequest().getSession().setAttribute("realName", customer.getCusName());
            Cart cart = cartService.get(user.getUsername());
            model.addAttribute("cart", cart);
        }
        List<Category> categories = categoryService.findAllCategories();
        model.addAttribute("categories", categories);

        /*
         判断是否有登录
         1：未登录：显示sku的D类价格
         2：认证后：判断用户是否是S类用户
            2.1：是，显示S类价格
            2.2：否，显示对应A、B、C、D四类等级的价格
         */
        List<CategoryVO> categoryVOs = new ArrayList<>();
        List<Category> subCategories = categoryService.findAllSubCategories();
        for (Category category : subCategories) {
            List<SkuVO> skuVOs;
            if (!principal.equals("anonymousUser")) { // 说明有登录认证
                User user = (User) principal;
                Customer customer = customerService.get(user.getUsername());
                skuVOs = skuService.findByCategory(category.getCateCode(), customer.getCusCode(), customer.getPriceType());
            } else {
                skuVOs = skuService.findByCategory(category.getCateCode(), "", "D");
            }
            CategoryVO categoryVO = new CategoryVO();
            categoryVO.setCategory(category);
            categoryVO.setSkus(skuVOs);
            categoryVOs.add(categoryVO);
        }
        model.addAttribute("subCategories", categoryVOs);
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
        ServletRequestAttributes servletRequestAttributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        servletRequestAttributes.getRequest().getSession().setAttribute("username", customer.getCusCode());
        servletRequestAttributes.getRequest().getSession().setAttribute("realName", customer.getCusName());
        model.addAttribute("me", customer);
//        model.addAttribute("addresses", new String[0]);
        return "profile";
    }

    @RequestMapping("/register")
    public String register(Customer customer) throws Exception {
        String password = customer.getPasswd();
        customer = customerService.insert(customer);
        String username = customer.getCusCode();
        UserDetails userDetails = userDetailsService.loadUserByUsername(username);
        UsernamePasswordAuthenticationToken usernamePasswordAuthenticationToken = new UsernamePasswordAuthenticationToken(userDetails, password, userDetails.getAuthorities());

        authenticationManager.authenticate(usernamePasswordAuthenticationToken);

        if (usernamePasswordAuthenticationToken.isAuthenticated()) {
            SecurityContextHolder.getContext().setAuthentication(usernamePasswordAuthenticationToken);
        }
        return "redirect:profile";
    }
}
