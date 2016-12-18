package com.fruit.pitaya.config;

import com.fruit.pitaya.interceptor.StatusInterceptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

/**
 * Created by hanlei6 on 2016/10/19.
 */
@Configuration
public class ResourceConfig extends WebMvcConfigurerAdapter {

    @Autowired
    private StatusInterceptor statusInterceptor;

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/ext/**").addResourceLocations("file:///" + System.getProperties().getProperty("user.home") + "/upload/");
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(statusInterceptor).addPathPatterns("/**").excludePathPatterns("/ext/public/**", "/css/**", "/fonts/**", "/images/**", "/locales/**", "/js/**", "/favicon.ico", "/", "/login", "/logout", "/register", "/unAudit", "/error", "/sku/show/**", "/sku/page/**");
    }
}
