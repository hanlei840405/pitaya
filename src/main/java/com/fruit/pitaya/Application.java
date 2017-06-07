package com.fruit.pitaya;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.MultipartConfigFactory;
import org.springframework.context.annotation.Bean;

import javax.servlet.MultipartConfigElement;
import java.io.File;

@SpringBootApplication
public class Application {
    /**
     * 文件上传临时路径
     */
    @Bean
    public MultipartConfigElement multipartConfigElement() {
        String tmpPath = System.getProperties().getProperty("user.home") + "/tmp/";
        File file = new File(tmpPath);
        if (!file.exists()) {
            file.mkdir();
        }
        MultipartConfigFactory factory = new MultipartConfigFactory();
        factory.setLocation(System.getProperties().getProperty("user.home") + "/tmp/");
        return factory.createMultipartConfig();
    }

    public static void main(String[] args) {
//		Md5PasswordEncoder encoder = new Md5PasswordEncoder();
//		String pwd = encoder.encodePassword("123456","hanlei");
//		System.out.println(pwd);
        SpringApplication.run(Application.class, args);
    }
}
