package com.goods.g1.controller;

import com.goods.g1.dto.MemberVO;
import com.goods.g1.service.GoodsService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;

@Controller
public class GoodsController {

    private final GoodsService gs;

    @Autowired
    public GoodsController(GoodsService gs) {
        this.gs = gs;
    }

    @GetMapping("/viewCategory")
    public ModelAndView viewCategory(@RequestParam("cgseq") String cgseq, HttpServletRequest request) {

        ModelAndView mav = new ModelAndView();

        HashMap<String, Object> result = gs.viewCategory(cgseq, request);


        mav.addObject("categoryList", result.get("categoryList"));
        mav.addObject("cgseq", cgseq);
        mav.addObject("paging", result.get("paging"));
        mav.setViewName("/goods/categoryView");

        return mav;
    }

    @GetMapping("/goodsDetailView")
    public ModelAndView viewGoodsDetail(@RequestParam("gseq") int gseq, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        HttpSession session = request.getSession();
        MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");

        HashMap<String, Object> result = gs.viewGoodsDetail(gseq, request);

        mav.addObject("goodsDetail", result.get("goods"));
        mav.setViewName("goods/goodsDetail");
        //mav.addObject("reviewList", result.get("reviewList"));
        //mav.addObject("paging", result.get("paging"));
        return mav;
    }





}
