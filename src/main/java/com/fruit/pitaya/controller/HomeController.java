package com.fruit.pitaya.controller;

import com.fruit.pitaya.model.Cart;
import com.fruit.pitaya.model.Category;
import com.fruit.pitaya.model.Customer;
import com.fruit.pitaya.model.OrderVO;
import com.fruit.pitaya.service.*;
import com.fruit.pitaya.util.Constant;
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
    private CartService cartService;

    @Autowired
    private OrderService orderService;

    @RequestMapping("/")
    public String home(Model model) {
        boolean showExclusivePage = false;
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (!principal.equals("anonymousUser")) {
            User user = (User) principal;
            Cart cart = cartService.get(user.getUsername());
            model.addAttribute("cart", cart);
            Long count = skuService.countExclusiveSku(user.getUsername());
            long pages = (long) Math.ceil(count.doubleValue() / Constant.PAGE_SIZE);
            if (pages > 1) {
                showExclusivePage = true;
            }
        }
        List<Category> categories = categoryService.findAllCategories();
        model.addAttribute("categories", categories);
        List<Category> subCategories = new ArrayList<>();
        List<Category> rootCategories = categoryService.findAllRootCategories();
        for (Category root : rootCategories) {
            List<Category> subs = categoryService.findSubCategories(root.getCateCode());
            if (subs.isEmpty()) {
                subCategories.add(root);
            } else {
                for (Category sub : subs) {
                    Long count = skuService.count(sub.getCateCode());
                    long pages = (long) Math.ceil(count.doubleValue() / Constant.PAGE_SIZE);
                    if (pages > 1) {
                        sub.setShowPage(true);
                    } else {
                        sub.setShowPage(false);
                    }
                }
                subCategories.addAll(subs);
            }
        }
        model.addAttribute("showExclusivePage", showExclusivePage);
        model.addAttribute("subCategories", subCategories);
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
        List<OrderVO> orderVOs = orderService.findByCustomer(user.getUsername());
        ServletRequestAttributes servletRequestAttributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        servletRequestAttributes.getRequest().getSession().setAttribute("username", customer.getCusCode());
        servletRequestAttributes.getRequest().getSession().setAttribute("realName", customer.getCusName());
        model.addAttribute("me", customer);
        model.addAttribute("orders", orderVOs);
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
