package com.fruit.pitaya.config;

import com.fruit.pitaya.model.Customer;
import com.fruit.pitaya.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.authentication.dao.ReflectionSaltSource;
import org.springframework.security.authentication.encoding.Md5PasswordEncoder;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.util.StringUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.*;
import javax.sql.DataSource;
import java.io.IOException;

/**
 * Created by hanlei6 on 2016/7/14.
 */
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    private DataSource dataSource;

    @Autowired
    private CustomerService customerService;

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
                .authorizeRequests()
                .antMatchers("/ext/public/**", "/css/**", "/fonts/**", "/images/**", "/locales/**", "/js/**", "/favicon.ico", "/", "/register", "/sku/show/**", "/sku/page/**").permitAll()
                .anyRequest().authenticated()
                .and()
                .formLogin().loginPage("/login").permitAll().defaultSuccessUrl("/")
                .and().logout().logoutUrl("/logout").logoutSuccessUrl("/");
//        .invalidateHttpSession(true).deleteCookies();
    }
    // @formatter:on

    // @formatter:off
    @Autowired
    public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
        auth.jdbcAuthentication()
                .dataSource(dataSource)
//                .passwordEncoder(new Md5PasswordEncoder())
                .usersByUsernameQuery("SELECT cusCode as username, passwd as password, 1 as enable FROM mall_customer WHERE cusCode = ?")
                .authoritiesByUsernameQuery("SELECT cusCode as username, 'customer' as authority FROM mall_customer WHERE cusCode = ?");
        ReflectionSaltSource rss = new ReflectionSaltSource();
        rss.setUserPropertyToUse("username");
        DaoAuthenticationProvider provider = new DaoAuthenticationProvider();
        provider.setUserDetailsService(auth.getDefaultUserDetailsService());
        provider.setSaltSource(rss);
        provider.setPasswordEncoder(new Md5PasswordEncoder());
        auth.authenticationProvider(provider);

    }

    @Bean
    public Filter sessionFilter() {
        return new Filter() {
            @Override
            public void init(FilterConfig filterConfig) throws ServletException {

            }

            @Override
            public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
                Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
                ServletRequestAttributes servletRequestAttributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
                if (!principal.equals("anonymousUser") && StringUtils.isEmpty(servletRequestAttributes.getRequest().getSession().getAttribute("username"))) {
                    User user = (User) principal;
                    Customer customer = customerService.get(user.getUsername());
                    servletRequestAttributes.getRequest().getSession().setAttribute("username", customer.getCusCode());
                    servletRequestAttributes.getRequest().getSession().setAttribute("realName", customer.getCusName());
                }
                filterChain.doFilter(servletRequest, servletResponse);
            }

            @Override
            public void destroy() {

            }
        };
    }

}
