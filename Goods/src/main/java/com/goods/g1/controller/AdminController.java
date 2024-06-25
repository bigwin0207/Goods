package com.goods.g1.controller;

import com.goods.g1.dto.MemberDTO;
import com.goods.g1.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {
    @Autowired
    AdminService adminService;

    @GetMapping("/memberList")
    public String getMemberList(Model model) {
        List<MemberDTO> memberList = adminService.getMemberList();
        model.addAttribute("memberList", memberList);

        return "admin/index";
    }
}
