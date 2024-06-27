package com.goods.g1.controller;

import com.goods.g1.dto.AdminVO;
import com.goods.g1.dto.GoodsVO;
import com.goods.g1.service.AdminGoodsService;
import com.goods.g1.util.MPaging;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class AdminGoodsController {

    private final AdminGoodsService as;

    @Autowired
    public AdminGoodsController(AdminGoodsService as) {
        this.as = as;
    }

    @RequestMapping("adminGoodsView")
    public String adminGoodsView(HttpServletRequest request) {

        HttpSession session = request.getSession();
        AdminVO loginAdmin = (AdminVO) session.getAttribute("loginAdmin");
        String url = "";

        if (loginAdmin == null) {
            url = "redirect:/adminLoginForm";
        } else {

            int page = 1;

            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
                session.setAttribute("page", page);
            } else if (session.getAttribute("page") != null) {
                page = (Integer) session.getAttribute("page");
            } else {
                session.removeAttribute("page");
            }

            MPaging paging = new MPaging();
            paging.setPage(page);
            paging.setDisplayRow(10);
            paging.setStartNum(paging.getStartNum() - 1);

            HashMap<String, Object> result = new HashMap<>();
            result = as.adminGoodsView(paging);


            System.out.println(paging);

            request.setAttribute("url", "adminGoodsView");
            request.setAttribute("adminGoodsList", result.get("adminGoodsList"));
            request.setAttribute("paging", result.get("paging"));

            url = "/admin/adminGoodsView";
        }

        return url;
    }


    @GetMapping("adminInsertGoodsForm")
    public String adminInsertGoodsForm(HttpServletRequest request) {
        HttpSession session = request.getSession();
        AdminVO loginAdmin = (AdminVO) session.getAttribute("loginAdmin");
        String url = "";

        if (loginAdmin == null) {
            url = "redirect:/adminLoginForm";
        } else {
            request.setAttribute("categoryList", as.adminGoodsInsertForm());
            url = "admin/adminGoodsWriteForm";
        }
        return url;
    }

    @PostMapping("adminInsertGoods")
    public String adminInsertGoods(@RequestParam("uploadedFiles") String[] files, @ModelAttribute("gvo") GoodsVO gvo) throws IOException {

        as.insertGoods(files, gvo);

        return "redirect:/adminGoodsView";
    }


    @PostMapping("adminGoodsUpdateForm")
    public ModelAndView adminUpdateGoodsForm(@RequestParam("gseq") int gseq) {
        ModelAndView mav = new ModelAndView();

        Map<String, Object> result = new HashMap<>();

        result = as.goodsUpdateForm(gseq);


        mav.addObject("categoryList", result.get("categoryList"));
        mav.addObject("updateGoods", result.get("updateGoods"));
        mav.setViewName("admin/adminGoodsWriteForm");

        return mav;
    }

    @PostMapping("adminGoodsUpdate")
    public String adminGoodsUpdate(@RequestParam(value = "uploadedFiles", required = false) String[] files,
                                   @RequestParam(value = "giseq", required = false) String[] giseqs,
                                   @RequestParam(value = "oldimgs", required = false) String[] oldimgs,
                                   @RequestParam("oldGname") String oldGname,
                                   @ModelAttribute("gvo") GoodsVO gvo){

        as.updateGoods(files, giseqs, oldimgs, oldGname, gvo);

        return "redirect:/adminGoodsView";
    }


}
