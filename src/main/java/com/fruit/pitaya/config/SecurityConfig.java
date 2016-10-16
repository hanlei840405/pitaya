package com.fruit.pitaya.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.authentication.dao.ReflectionSaltSource;
import org.springframework.security.authentication.encoding.Md5PasswordEncoder;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

import javax.sql.DataSource;

/**
 * Created by hanlei6 on 2016/7/14.
 */
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    private DataSource dataSource;

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
                .authorizeRequests()
                .antMatchers("/css/**", "/fonts/**", "/images/**", "/locales/**", "/js/**", "/favicon.ico", "/", "/register").permitAll()
                .anyRequest().authenticated()
                .and()
                .formLogin().loginPage("/login").permitAll().defaultSuccessUrl("/")
                .and().csrf().disable().logout().logoutUrl("/logout").logoutSuccessUrl("/index");
//        .invalidateHttpSession(true).deleteCookies();
    }
    // @formatter:on

    // @formatter:off
    @Autowired
    public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
        auth.jdbcAuthentication()
                .dataSource(dataSource)
//                .passwordEncoder(new Md5PasswordEncoder())
                .usersByUsernameQuery("SELECT cusCode as username, passwd as password, status as enable FROM mall_customer WHERE cusCode = ?")
                .authoritiesByUsernameQuery("SELECT cusCode as username, 'customer' as authority FROM mall_customer WHERE cusCode = ?");
        ReflectionSaltSource rss = new ReflectionSaltSource();
        rss.setUserPropertyToUse("username");
        DaoAuthenticationProvider provider = new DaoAuthenticationProvider();
        provider.setUserDetailsService(auth.getDefaultUserDetailsService());
        provider.setSaltSource(rss);
        provider.setPasswordEncoder(new Md5PasswordEncoder());
        auth.authenticationProvider(provider);

    }
}
