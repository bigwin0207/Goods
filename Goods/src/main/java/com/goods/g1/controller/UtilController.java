package com.goods.g1.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.util.HashMap;
import java.util.Map;

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

    @Value("${file.upload-dir}/temps")
    private String uploadDir;


    @PostMapping("uploadTemps")
    @ResponseBody
    public Map<String, Object> uploadTemps(@RequestParam("image") MultipartFile[] files, HttpServletRequest request) {

        System.out.println("uploadTemps 메소드 실행됨...");

        Map<String, Object> response = new HashMap<>();


        File uploadDirFile = new File(uploadDir);
        if (!uploadDirFile.exists()) {
            if (!uploadDirFile.mkdirs()) {
                response.put("STATUS", 0);
                response.put("ERROR", "Failed to create upload directory");
                return response;
            }
        }

        String[] savefilenames = new String[files.length];
        String[] images = new String[files.length];

        for (int i=0; i<files.length; i++) {
            MultipartFile file = files[i];
            if (file.isEmpty()) {
                response.put("STATUS", 0);
                response.put("ERROR", "No file selected");
                return response;
            }

            String oriname = file.getOriginalFilename();
            if (!oriname.equals("")) {
                String uploadPath = uploadDir + File.separator + oriname;

                try {
                    file.transferTo(new File(uploadPath));
                    response.put("STATUS", 1);
                    savefilenames[i] = oriname;
                    images[i] = oriname;

                } catch (IOException e) {
                    response.put("STATUS", 0);
                    response.put("ERROR", e.getMessage());
                    return response;
                }
            }

        }

        response.put("savefilenames", savefilenames);
        response.put("images", images);

        return response;

    }



}
