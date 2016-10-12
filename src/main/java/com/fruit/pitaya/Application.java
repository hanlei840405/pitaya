package com.fruit.pitaya;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class Application {

    public static void main(String[] args) {
//		Md5PasswordEncoder encoder = new Md5PasswordEncoder();
//		String pwd = encoder.encodePassword("123456","hanlei");
//		System.out.println(pwd);
        SpringApplication.run(Application.class, args);
    }
}
