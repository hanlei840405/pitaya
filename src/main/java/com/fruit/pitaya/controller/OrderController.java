package com.fruit.pitaya.controller;

import com.fruit.pitaya.service.OrderService;
import com.fruit.pitaya.util.Utils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * Created by hanlei6 on 2016/11/1.
 */
@Controller
@RequestMapping("/order")
public class OrderController {
    private static final Logger log = LoggerFactory.getLogger(OrderController.class);
    @Autowired
    private OrderService orderService;

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

    @RequestMapping(value = "/test")
    public String test(RedirectAttributes redirectAttributes) throws Exception {
        try {
            orderService.test();
        } catch (Exception e) {
            log.error("error");
            redirectAttributes.addAttribute("code", "500");
            redirectAttributes.addAttribute("msg", "保存失败");
            throw e;
        }
        return "redirect:/profile";
    }
}
