package com.goods.g1.controller;

import com.goods.g1.dto.MemberVO;
import com.goods.g1.service.AdminService;
import com.goods.g1.service.AdminService_;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.io.IOException;
import java.util.List;

@Controller
public class AdminController_ {

    @Autowired
    AdminService_ as1;


    @GetMapping("/adminLogout")
    public String logout(HttpServletRequest request) throws IOException {
        HttpSession session = request.getSession();
        session.removeAttribute("loginAdmin");
        return "redirect:/adminIndex";
    }

    @RequestMapping("/admin/switchYN")
    public String adminSwitch(@RequestParam(value = "userid", required = false) String[] userids,
                               HttpSession session, Model model) {
        as1.adminSwitch(userids);
        return "redirect:/adminIndex";
    }

    @RequestMapping("/admin/discardMember")
    public String discardMember(@RequestParam(value = "userid", required = false) String[] userids,
                                HttpSession session, Model model) {
        as1.discardMember(userids);
        return "redirect:/adminIndex";
    }
}
