package com.goods.g1.controller;

import com.goods.g1.dto.AdminVO;
import com.goods.g1.service.AdminService;
import com.goods.g1.util.Paging;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.HashMap;

@Controller
public class AdminController {

    private final AdminService as;

    @Autowired
    public AdminController(AdminService as) {
        this.as = as;
    }

    @GetMapping("adminLoginForm")
    public String adminLoginForm() {
        return "admin/adminLoginForm";
    }

    @PostMapping("adminLogin")
    public String adminLoginForm(HttpServletRequest request, @RequestParam("adminID") String adminID, Model model) {
        AdminVO vo = as.adminLoginForm(adminID);

        if (vo == null)
            request.setAttribute("message", "실패");
        else if (!vo.getPwd().equals(request.getParameter("pwd")))
            request.setAttribute("message", "실패");
        else if (vo.getPwd().equals(request.getParameter("pwd"))) {
            HttpSession session = request.getSession();
            session.setAttribute("loginAdmin", vo);
            model.addAttribute("message", "성공");
            session.removeAttribute("loginUser");
        }

        return "redirect:/adminIndex";
    }

    @GetMapping("adminIndex")
    public String adminIndex(HttpServletRequest request, Model model) {

        HttpSession session = request.getSession();
        AdminVO loginAdmin = (AdminVO)session.getAttribute("loginAdmin");

        if (loginAdmin != null) {

            int total = as.getTotalMember();
            int currentPage = 1;
            int amount = 10;

            if(session.getAttribute("currentPage") != null) {
                currentPage = (Integer)session.getAttribute("currentPage");
            }
            if(session.getAttribute("amount") != null) {
                amount = (Integer)session.getAttribute("amount");
            }

            Paging paging = new Paging(currentPage, amount, total);
            System.out.println(paging.toString());

            model.addAttribute("memberList", as.getMemberList(paging.getAmount(), paging.getCurrentPage()));
            model.addAttribute("paging", paging);

            return "/admin/index";
        } else {
            return "/admin/adminLoginForm";
        }
    }
}
