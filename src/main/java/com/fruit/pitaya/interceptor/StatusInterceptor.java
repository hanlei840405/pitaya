package com.fruit.pitaya.interceptor;

import com.fruit.pitaya.model.Customer;
import com.fruit.pitaya.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by JesseHan on 2016/12/18.
 */
@Component
public class StatusInterceptor implements HandlerInterceptor {

    @Autowired
    private CustomerService customerService;

    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {

        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (!principal.equals("anonymousUser")) {
            User user = (User) principal;
            Customer customer = customerService.get(user.getUsername());
            if (customer.getStatus() != 1) {
                httpServletResponse.sendRedirect("/unAudit");
                return false;
            }
        }
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
