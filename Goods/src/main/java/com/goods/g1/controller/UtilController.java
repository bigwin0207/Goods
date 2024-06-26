package com.goods.g1.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import java.io.*;

@Controller
public class UtilController {
    @GetMapping("imageWrite")
    public void imageWrite(HttpServletRequest request, HttpServletResponse response) {
        String folder = request.getParameter("folder");
        String realName = request.getParameter("realName");

        try {
            String imagePath = "c:\\upload\\";
            File imageFile = new File(imagePath + folder + "\\" + realName);

            if (imageFile.exists()) {
                response.setContentType("image/jpeg");
                FileInputStream fis = new FileInputStream(imageFile);
                OutputStream os = response.getOutputStream();

                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = fis.read(buffer)) != -1) {
                    os.write(buffer, 0, bytesRead);
                }
                os.close();
                fis.close();
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


}
