package com.fruit.pitaya.controller;

import com.fruit.pitaya.model.Customer;
import com.fruit.pitaya.model.CustomerAddr;
import com.fruit.pitaya.model.CustomerShop;
import com.fruit.pitaya.service.CustomerAddrService;
import com.fruit.pitaya.service.CustomerService;
import com.fruit.pitaya.service.CustomerShopService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
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
            redirectAttributes.addAttribute("errorCode", "500");
            redirectAttributes.addAttribute("errorMsg", "保存失败");
        }
        redirectAttributes.addAttribute("me", exist);
        return "redirect:/profile";
    }

    @RequestMapping(value = "/saveAddr", method = RequestMethod.POST)
    public String saveAddr(CustomerAddr customerAddr, RedirectAttributes redirectAttributes) {
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        try {
            if (customerAddr.getId() != null) {
                CustomerAddr exist = customerAddrService.get(customerAddr.getId(), user.getUsername());
                if (exist == null) {
                    redirectAttributes.addAttribute("errorCode", "500");
                    redirectAttributes.addAttribute("errorMsg", "未找到符合条件的地址");
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
            redirectAttributes.addAttribute("errorCode", "500");
            redirectAttributes.addAttribute("errorMsg", "保存失败");
        }
        return "redirect:/profile";
    }

    @RequestMapping(value = "/saveShop", method = RequestMethod.POST)
    public String saveShop(CustomerShop customerShop, @RequestParam("file") MultipartFile file, RedirectAttributes redirectAttributes) {
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        try {
            if (!file.isEmpty()) {
                final Path rootLocation = Paths.get(System.getProperties().getProperty("user.home"), "/upload/private/");
                File folder = new File(rootLocation.toUri());
                if (!folder.exists() && !folder.isDirectory()) {
                    folder.mkdir();
                }
                if (Files.exists(rootLocation.resolve(file.getOriginalFilename()))) {
                    Files.delete(rootLocation.resolve(file.getOriginalFilename()));
                }
                Files.copy(file.getInputStream(), rootLocation.resolve(file.getOriginalFilename()));
                customerShop.setShopPic(file.getOriginalFilename());
            }

            if (customerShop.getId() != null) {
                CustomerShop exist = customerShopService.get(customerShop.getId(), user.getUsername());
                if (exist == null) {
                    redirectAttributes.addAttribute("errorCode", "500");
                    redirectAttributes.addAttribute("errorMsg", "未找到符合条件的店铺");
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
            redirectAttributes.addAttribute("errorCode", "500");
            redirectAttributes.addAttribute("errorMsg", "保存失败");
        }
        return "redirect:/profile";
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
                result.put("errorCode", "500");
                result.put("errorMsg", "未找到符合条件的地址");
                return result;
            }
            customerAddrService.delete(id);
        } catch (Exception e) {
            log.error("DELETE CUSTOMER ADDR : {}", id);
            result.put("errorCode", "500");
            result.put("errorMsg", "删除失败");
            return result;
        }
        result.put("errorCode", "200");
        result.put("errorMsg", "操作成功");
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
                result.put("errorCode", "500");
                result.put("errorMsg", "未找到符合条件的店铺");
                return result;
            }
            customerShopService.delete(id);
        } catch (Exception e) {
            log.error("DELETE CUSTOMER SHOP : {}", id);
            result.put("errorCode", "500");
            result.put("errorMsg", "删除失败");
            return result;
        }
        result.put("errorCode", "200");
        result.put("errorMsg", "操作成功");
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

}
