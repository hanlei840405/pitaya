package com.fruit.pitaya.controller;

import com.fruit.pitaya.model.*;
import com.fruit.pitaya.service.*;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by hanlei6 on 2016/10/25.
 */
@Controller
@RequestMapping("/cart")
public class CartController {
    private static final Logger log = LoggerFactory.getLogger(CartController.class);
    @Autowired
    private CustomerService customerService;
    @Autowired
    private CartService cartService;
    @Autowired
    private SkuSPriceService skuSPriceService;
    @Autowired
    private SkuNPriceService skuNPriceService;
    @Autowired
    private StockService stockService;
    @Autowired
    private CustomerAddrService customerAddrService;
    @Autowired
    private OrderService orderService;

    @RequestMapping("/fresh")
    public String fresh(Model model) {
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Cart cart = cartService.get(user.getUsername());
        model.addAttribute("cart", cart);
        return "cart-widget";
    }

    @RequestMapping("/addSku/{sku}")
    public
    @ResponseBody
    Map<String, Object> addSku(@PathVariable("sku") String sku, @RequestParam(required = true) Integer count) {
        Map<String, Object> result = new HashMap<>();

        if (count <= 0) {
            result.put("code", "500");
            result.put("msg", "请填写购买数量");
            return result;
        }

        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Customer customer = customerService.get(user.getUsername());
        Stock stock = stockService.get(sku);
        CartDetail cartDetail = cartService.get(customer.getCusCode(), sku);
        if ((cartDetail != null && stock.getQuantity() < (cartDetail.getSkuCount() + count)) || stock.getQuantity() < count) {
            result.put("code", "500");
            result.put("msg", "库存不足");
            return result;
        }


        String priceType = customer.getPriceType();
        SkuSPrice skuSPrice = skuSPriceService.findByCusCodeAndSku(user.getUsername(), sku);
        BigDecimal price;
        // 校验是否是新用户,如果新用户,不限制购买数量
        if (skuSPrice != null) { // skuSPrice不为空，说明是已购买过某sku的用户或者是后台设置的享有优惠的老客户
            price = skuSPrice.getPrice();
            priceType = price != null ? "S" : "";
            String firsetBuy = skuSPrice.getFirstbuy();
            // 老客户通过后台设置后，也可享用首次购买优惠，且可以使用最优惠的价格。
            boolean validateCount = price != null && StringUtils.isEmpty(firsetBuy) ? false : true;// 校验首次购买
            if (validateCount) {
                Integer allowCount = skuNPriceService.findMinCountBySkuAndCount(sku, priceType);
                if (allowCount == null) {
                    result.put("code", "500");
                    result.put("msg", "没找到商品数量");
                    return result;
                }
                if (allowCount < count) {
                    result.put("code", "500");
                    result.put("msg", "购买数量没有达到最低要求");
                    return result;
                }
            }
        } else { // 说明买家针对某款sku从未购买过，不需校验购买数量
            // 如果是首次购买不限制购买数量，价格执行买家价格类型中的最高标准
            price = skuNPriceService.findPriceBySkuAndCount(sku, priceType, count);
            if (price == null) {
                result.put("code", "500");
                result.put("msg", "没找到商品价格");
                return result;
            }
        }

        try {
            cartService.process(customer.getCusCode(), sku, priceType, price, count);
            result.put("code", "200");
            result.put("msg", "操作成功");
        } catch (Exception e) {
            result.put("code", "500");
            result.put("msg", "保存失败");
        }

        return result;
    }

    /**
     * 前往结算页面
     *
     * @param model
     * @return
     */
    @RequestMapping("")
    public String settle(Model model) {
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Cart cart = cartService.get(user.getUsername());
        CustomerAddr customerAddr = customerAddrService.getDefault(user.getUsername());
        List<CustomerAddr> customerAddrs = customerAddrService.findByCustomer(user.getUsername());
        model.addAttribute("cart", cart);
        model.addAttribute("address", customerAddr);
        model.addAttribute("addresses", customerAddrs);
        return "cart";
    }

    /**
     * 删除明细
     *
     * @param sku
     * @return
     */
    @RequestMapping("/delete/{sku}")
    public String delete(@PathVariable("sku") String sku) {
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        cartService.clearCartDetail(user.getUsername(), sku);
        return "redirect:/";
    }

    /**
     * 购物车转为订单
     *
     * @param addressId
     * @return
     */
    @RequestMapping("/settle")
    public String delete(Long addressId) {
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        CustomerAddr customerAddr = customerAddrService.getDefault(user.getUsername());
        if (addressId == null) {
            addressId = customerAddr.getId();
        }
        orderService.create(user.getUsername(), addressId);
        return "redirect:/";
    }
}
