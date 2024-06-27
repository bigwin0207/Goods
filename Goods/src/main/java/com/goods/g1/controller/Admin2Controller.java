package com.goods.g1.controller;

import com.goods.g1.service.Admin2Service;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;

@RestController
public class Admin2Controller {

    @Autowired
    Admin2Service as1;


    @GetMapping("/adminLogout")
    public String logout(HttpServletRequest request) throws IOException {
        HttpSession session = request.getSession();
        session.removeAttribute("loginAdmin");
        return "redirect:/adminIndex";
    }

    @RequestMapping("/admin/switchYN")
    @ResponseBody
    public String adminSwitch(@RequestBody String[] checkList) {
        as1.adminSwitch(checkList);
        return "{\"status\": false, \"message\": \"완료\"}";
    }

    @RequestMapping("/admin/discardMember")
    @ResponseBody
    public String discardMember(@RequestBody String[] checkList) {
        as1.discardMember(checkList);
        return "{\"status\": false, \"message\": \"완료\"}";
    }
}
