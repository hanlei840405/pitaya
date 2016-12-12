package com.fruit.pitaya.controller;

import com.fruit.pitaya.model.Customer;
import com.fruit.pitaya.model.OrderVO;
import com.fruit.pitaya.service.CustomerService;
import com.fruit.pitaya.service.OrderService;
import com.fruit.pitaya.util.Constant;
import com.fruit.pitaya.util.Utils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

/**
 * Created by hanlei6 on 2016/11/1.
 */
@Controller
@RequestMapping("/order")
public class OrderController {
    private static final Logger log = LoggerFactory.getLogger(OrderController.class);
    @Autowired
    private OrderService orderService;
    @Autowired
    private CustomerService customerService;

    @RequestMapping(value = "/upload", method = RequestMethod.POST)
    public String upload(@RequestParam("orderId") String orderId, @RequestParam("file") MultipartFile file, RedirectAttributes redirectAttributes) {
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        try {
            String certificate = Utils.upload(file);
            orderService.uploadCertificate(user.getUsername(), orderId, certificate);
        } catch (Exception e) {
            log.error("SAVE CERTIFICATE : {}", orderId);
            redirectAttributes.addAttribute("code", "500");
            redirectAttributes.addAttribute("msg", "保存失败");
        }
        return "redirect:/profile";
    }

    @RequestMapping("/show/{page}")
    public String show(@PathVariable("page") int page, Model model) {
        if (page <= 0) {
            page = 1;
        }
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        User user = (User) principal;
        Customer customer = customerService.get(user.getUsername());
        List<OrderVO> orderVOs = orderService.findByCustomer(customer.getCusCode(), page);
        model.addAttribute("orders", orderVOs);
        return "order";
    }

    @RequestMapping("/page/{page}")
    public String page(@PathVariable("page") int page, Model model) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        User user = (User) principal;
        Long count = orderService.count(user.getUsername());
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
        model.addAttribute("firstUrl", "order/show/1/");
        model.addAttribute("preUrl", "order/show/" + pre);
        model.addAttribute("nextUrl", "order/show/" + next);
        model.addAttribute("lastUrl", "order/show/0/");
        return "page";
    }
}
