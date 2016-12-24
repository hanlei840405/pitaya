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
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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

    @Autowired
    private AfterSaleService afterSaleService;

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
        Category exclusiveCategory = new Category();
        exclusiveCategory.setCateCode("exclusive");
        exclusiveCategory.setCateName("专属商品");
        exclusiveCategory.setShowPage(showExclusivePage);
        subCategories.add(exclusiveCategory);

        model.addAttribute("subCategories", subCategories);
        return "index";
    }

    @RequestMapping("/login")
    public String login() {
        return "login";
    }

    @RequestMapping("/logout")
    public String logout(HttpServletRequest request, HttpServletResponse response) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        new SecurityContextLogoutHandler().logout(request, response, auth);
        return "redirect:/";
    }

    @RequestMapping("/unAudit")
    public String unAudit(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        new SecurityContextLogoutHandler().logout(request, response, auth);
        redirectAttributes.addAttribute("error", "商户未审核，请联系卖家尽快审核");
        return "redirect:/error";
    }

    @RequestMapping("/profile")
    public String profile(Model model) {
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Customer customer = customerService.get(user.getUsername());
        Long orderCount = orderService.count(user.getUsername());
        Long afterSaleCount = afterSaleService.count(user.getUsername());
        model.addAttribute("me", customer);
        model.addAttribute("showOrderPage", orderCount > 1 ? true : false);
        model.addAttribute("showAfterSalePage", afterSaleCount > 1 ? true : false);
        List<OrderVO> orders = orderService.findSentByCustomer(customer.getCusCode());
        model.addAttribute("sentOrders", orders);
        ServletRequestAttributes servletRequestAttributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        servletRequestAttributes.getRequest().getSession().setAttribute("username", customer.getCusCode());
        servletRequestAttributes.getRequest().getSession().setAttribute("realName", customer.getCusName());
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
