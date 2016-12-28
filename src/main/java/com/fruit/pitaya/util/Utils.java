package com.fruit.pitaya.util;

import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

/**
 * Created by hanlei6 on 2016/11/1.
 */
public class Utils {
    public static String upload(MultipartFile file, String username) throws IOException {
        String fileName = username + System.currentTimeMillis();
        if (!file.isEmpty()) {
            final Path rootLocation = Paths.get(System.getProperties().getProperty("user.home"), "/upload/private/");
            File folder = new File(rootLocation.toUri());
            if (!folder.exists() && !folder.isDirectory()) {
                folder.mkdir();
            }

//            if (Files.exists(rootLocation.resolve(file.getOriginalFilename()))) {
//                Files.delete(rootLocation.resolve(file.getOriginalFilename()));
//            }
            int index = file.getOriginalFilename().lastIndexOf(".");
            Files.copy(file.getInputStream(), rootLocation.resolve(fileName + file.getOriginalFilename().substring(index)));
        }
        return fileName;
    }

    public static BigDecimal round(BigDecimal v, int scale) {
        if (scale < 0) {
            throw new IllegalArgumentException(
                    "The scale must be a positive integer or zero");
        }
        BigDecimal one = new BigDecimal("1");
        return v.divide(one, scale, BigDecimal.ROUND_HALF_UP);
    }
}
