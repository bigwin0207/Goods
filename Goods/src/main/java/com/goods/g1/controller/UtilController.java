package com.goods.g1.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.util.HashMap;
import java.util.Map;

@RestController
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

    @Value("${file.upload-dir}")
    private String uploadDir;


    @PostMapping("uploadTemps")
    @ResponseBody
    public Map<String, Object> uploadTemps(@RequestParam("image") MultipartFile[] files, HttpServletRequest request) {

        System.out.println("uploadTemps 메소드 실행됨...");
        String uploadDirectory = uploadDir + "\\temps";

        Map<String, Object> response = new HashMap<>();


        File uploadDirFile = new File(uploadDirectory);
        if (!uploadDirFile.exists()) {
            if (!uploadDirFile.mkdirs()) {
                response.put("STATUS", 0);
                response.put("ERROR", "Failed to create upload directory");
                return response;
            }
        }

        String[] savefilenames = new String[files.length];
        String[] images = new String[files.length];

        for (int i = 0; i < files.length; i++) {
            MultipartFile file = files[i];
            if (file.isEmpty()) {
                response.put("STATUS", 0);
                response.put("ERROR", "No file selected");
                return response;
            }

            String oriname = file.getOriginalFilename();
            if (!oriname.equals("")) {
                String uploadPath = uploadDirectory + File.separator + oriname;

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

    @PostMapping("/deleteFiles")
    public ResponseEntity<Map<String, Object>> deleteFiles(@RequestBody Map<String, Object> request) {
        Map<String, Object> response = new HashMap<>();

        try {
            String gseq = (String)request.get("gseq");
            String gname = (String)request.get("gname");
            String realname = (String)request.get("realname");

            File deletePath = new File(uploadDir + File.separator + gseq + gname + File.separator + realname);
            System.out.println(uploadDir + File.separator + gseq + gname + File.separator + realname);


            if (!deletePath.exists()) {
                response.put("STATUS", 0);
                response.put("ERROR", "Could not find selected files in directory");
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
            } else {
                boolean deleteResult = deletePath.delete();
                if (deleteResult) {
                    response.put("STATUS", 1);
                    response.put("MESSAGE", "File deleted successfully");
                    return ResponseEntity.ok(response);
                } else {
                    response.put("STATUS", 0);
                    response.put("ERROR", "Failed to delete file");
                    return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
                }
            }
        } catch (NumberFormatException e) {
            response.put("STATUS", 0);
            response.put("ERROR", "Invalid gseq format");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
        } catch (Exception e) {
            response.put("STATUS", 0);
            response.put("ERROR", "Exception occurred: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }


}
