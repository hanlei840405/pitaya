package com.fruit.pitaya.util;

import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

/**
 * Created by hanlei6 on 2016/11/1.
 */
public class Utils {
    public static String upload(MultipartFile file) throws IOException {
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
        }
        return file.getOriginalFilename();
    }
}
