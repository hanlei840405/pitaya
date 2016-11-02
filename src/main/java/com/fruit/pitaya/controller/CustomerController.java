package com.fruit.pitaya.controller;

import com.fruit.pitaya.model.Customer;
import com.fruit.pitaya.model.CustomerAddr;
import com.fruit.pitaya.model.CustomerShop;
import com.fruit.pitaya.service.CustomerAddrService;
import com.fruit.pitaya.service.CustomerService;
import com.fruit.pitaya.service.CustomerShopService;
import com.fruit.pitaya.util.Utils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by hanlei6 on 2016/10/12.
 */
@Controller
@RequestMapping("/customer")
public class CustomerController {
    private static final Logger log = LoggerFactory.getLogger(CustomerService.class);
    @Autowired
    private CustomerService customerService;
    @Autowired
    private CustomerAddrService customerAddrService;
    @Autowired
    private CustomerShopService customerShopService;

    @RequestMapping(value = "/updateMe", method = RequestMethod.POST)
    public String updateMe(Customer customer, RedirectAttributes redirectAttributes) {
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
            redirectAttributes.addAttribute("code", "500");
            redirectAttributes.addAttribute("msg", "保存失败");
        }
        return "redirect:/profile";
    }

    @RequestMapping(value = "/saveAddr", method = RequestMethod.POST)
    public String saveAddr(CustomerAddr customerAddr, RedirectAttributes redirectAttributes) {
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        try {
            if (customerAddr.getId() != null) {
                CustomerAddr exist = customerAddrService.get(customerAddr.getId(), user.getUsername());
                if (exist == null) {
                    redirectAttributes.addAttribute("code", "500");
                    redirectAttributes.addAttribute("msg", "未找到符合条件的地址");
                    return "redirect:profile";
                }
                exist.setPhone(customerAddr.getPhone());
                exist.setRecipient(customerAddr.getRecipient());
                exist.setAddr(customerAddr.getAddr());
                customerAddrService.update(exist);
            } else {
                customerAddr.setCustomer(user.getUsername());
                customerAddrService.insert(customerAddr);
            }
        } catch (Exception e) {
            log.error("SAVE CUSTOMER ADDR : {}", customerAddr);
            redirectAttributes.addAttribute("code", "500");
            redirectAttributes.addAttribute("msg", "保存失败");
        }
        return "redirect:/profile";
    }

    @RequestMapping(value = "/saveShop", method = RequestMethod.POST)
    public String saveShop(CustomerShop customerShop, @RequestParam("file") MultipartFile file, RedirectAttributes redirectAttributes) {
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        try {

            customerShop.setShopPic(user.getUsername() + Utils.upload(file));

            if (customerShop.getId() != null) {
                CustomerShop exist = customerShopService.get(customerShop.getId(), user.getUsername());
                if (exist == null) {
                    redirectAttributes.addAttribute("code", "500");
                    redirectAttributes.addAttribute("msg", "未找到符合条件的店铺");
                    return "redirect:profile";
                }
                exist.setShopPic(customerShop.getShopPic());
                exist.setShopName(customerShop.getShopName());
                exist.setShopAddr(customerShop.getShopAddr());
                exist.setCategory(customerShop.getCategory());
                exist.setShopPic(customerShop.getShopPic());
                customerShopService.update(exist);
            } else {
                customerShop.setCustomer(user.getUsername());
                customerShopService.insert(customerShop);
            }
        } catch (Exception e) {
            log.error("SAVE CUSTOMER SHOP : {}", customerShop);
            redirectAttributes.addAttribute("code", "500");
            redirectAttributes.addAttribute("msg", "保存失败");
        }
        return "redirect:/profile";
    }

    /**
     * 设置常用收货信息
     *
     * @param id
     * @return
     */
    @RequestMapping(value = "/usedAddr", method = RequestMethod.POST)
    public
    @ResponseBody
    Map<String, Object> usedAddr(Long id) {
        Map<String, Object> result = new HashMap<>();
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        try {
            CustomerAddr exist = customerAddrService.get(id, user.getUsername());
            if (exist == null) {
                result.put("code", "500");
                result.put("msg", "未找到符合条件的地址");
                return result;
            }
            customerAddrService.updateUsed(user.getUsername(), id);
        } catch (Exception e) {
            log.error("DELETE CUSTOMER ADDR : {}", id);
            result.put("code", "500");
            result.put("msg", "设置常用地址失败");
            return result;
        }
        result.put("code", "200");
        result.put("msg", "操作成功");
        return result;
    }

    @RequestMapping(value = "/deleteAddr", method = RequestMethod.POST)
    public
    @ResponseBody
    Map<String, Object> deleteAddr(Long id) {
        Map<String, Object> result = new HashMap<>();
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        try {
            CustomerAddr exist = customerAddrService.get(id, user.getUsername());
            if (exist == null) {
                result.put("code", "500");
                result.put("msg", "未找到符合条件的地址");
                return result;
            }
            customerAddrService.delete(id);
        } catch (Exception e) {
            log.error("DELETE CUSTOMER ADDR : {}", id);
            result.put("code", "500");
            result.put("msg", "删除失败");
            return result;
        }
        result.put("code", "200");
        result.put("msg", "操作成功");
        return result;
    }

    @RequestMapping(value = "/deleteShop", method = RequestMethod.POST)
    public
    @ResponseBody
    Map<String, Object> deleteShop(Long id) {
        Map<String, Object> result = new HashMap<>();
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        try {
            CustomerShop exist = customerShopService.get(id, user.getUsername());
            if (exist == null) {
                result.put("code", "500");
                result.put("msg", "未找到符合条件的店铺");
                return result;
            }
            customerShopService.delete(id);
        } catch (Exception e) {
            log.error("DELETE CUSTOMER SHOP : {}", id);
            result.put("code", "500");
            result.put("msg", "删除失败");
            return result;
        }
        result.put("code", "200");
        result.put("msg", "操作成功");
        return result;
    }

    @RequestMapping(value = "/listAddr", method = RequestMethod.POST)
    public
    @ResponseBody
    List<CustomerAddr> listAddr() {
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        List<CustomerAddr> addrs = customerAddrService.findByCustomer(user.getUsername());
        return addrs;
    }

    @RequestMapping(value = "/listShop", method = RequestMethod.POST)
    public
    @ResponseBody
    List<CustomerShop> listShop() {
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        List<CustomerShop> shops = customerShopService.findByCustomer(user.getUsername());
        return shops;
    }

    @RequestMapping(value = "/address/{id}")
    public
    @ResponseBody
    Map<String, Object> address(@PathVariable("id") Long id) {
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        CustomerAddr customerAddr = customerAddrService.get(id, user.getUsername());
        Map<String, Object> result = new HashMap<>();
        if (customerAddr != null) {
            result.put("code", "200");
            result.put("address", customerAddr);
        } else {
            result.put("code", "500");
            result.put("msg", "未找到地址");
        }
        return result;
    }

}
