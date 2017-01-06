package com.fruit.pitaya.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fruit.pitaya.model.AfterSale;
import com.fruit.pitaya.model.AfterSaleDetail;
import com.fruit.pitaya.model.AfterSaleVO;
import com.fruit.pitaya.service.AfterSaleService;
import com.fruit.pitaya.service.CustomerService;
import com.fruit.pitaya.service.OrderService;
import com.fruit.pitaya.service.SequenceService;
import com.fruit.pitaya.util.Constant;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by hanlei6 on 2016/10/12.
 */
@Controller
@RequestMapping("/aftersale")
public class AfterSaleController {
    private static final Logger log = LoggerFactory.getLogger(CustomerService.class);
    @Autowired
    private AfterSaleService afterSaleService;
    @Autowired
    private OrderService orderService;
    @Autowired
    private SequenceService sequenceService;

    private ObjectMapper objectMapper = new ObjectMapper();

    @RequestMapping(value = "/saveAfterSale", method = RequestMethod.POST)
    public String saveAfterSale(AfterSale afterSale, String skus, RedirectAttributes redirectAttributes) {
        if (afterSale == null || StringUtils.isEmpty(StringUtils.trimTrailingWhitespace(afterSale.getAddr())) ||
                StringUtils.isEmpty(StringUtils.trimTrailingWhitespace(afterSale.getExecuter())) ||
                StringUtils.isEmpty(StringUtils.trimTrailingWhitespace(afterSale.getCourierNum()))) {
            log.error("收件人、快递单号、地址不能为空 : {}", afterSale);
            redirectAttributes.addAttribute("error", "收件人、快递单号、地址不能为空");
            return "redirect:/error";
        }
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String asodId = "AS" + sequenceService.generateCode("订单");
        afterSale.setAsodID(asodId);
        afterSale.setCustomer(user.getUsername());
        try {
            List<AfterSaleDetail> afterSaleDetails = new ArrayList<>();
            List<Map<String, String>> list = objectMapper.readValue(skus, List.class);
            for (Map<String, String> map : list) {
                String sku = map.get("sku");
                long inputCnt = Long.parseLong(map.get("count"));
                long cnt = orderService.receivedSkuCount(user.getUsername(), sku);
                if (inputCnt > cnt) {
                    log.error("返修数量超出购买数量 : {}", sku);
                    redirectAttributes.addAttribute("error", sku + "返修数量超出购买数量");
                    return "redirect:/error";
                }
                AfterSaleDetail detail = new AfterSaleDetail();
                detail.setAsodID(asodId);
                detail.setQuantity((int) inputCnt);
                detail.setSku(sku);
                afterSaleDetails.add(detail);
            }
            afterSaleService.createAfterSale(afterSale, afterSaleDetails);
        } catch (Exception e) {
            log.error("CREATE AFTERSALE : {}", afterSale);
            redirectAttributes.addAttribute("error", afterSale + "保存失败");
            return "redirect:/error";
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
        List<AfterSaleVO> afterSaleVOs = afterSaleService.findByCustomer(user.getUsername(), page);
        model.addAttribute("aftersales", afterSaleVOs);
        return "after-sale";
    }

    @RequestMapping("/page/{page}")
    public String page(@PathVariable("page") int page, Model model) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        User user = (User) principal;
        Long count = afterSaleService.count(user.getUsername());
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
        model.addAttribute("firstUrl", "aftersale/show/1/");
        model.addAttribute("preUrl", "aftersale/show/" + pre);
        model.addAttribute("nextUrl", "aftersale/show/" + next);
        model.addAttribute("lastUrl", "aftersale/show/" + pages);
        return "page";
    }
}
