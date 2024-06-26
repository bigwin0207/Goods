package com.goods.g1.controller;

import com.goods.g1.dao.INoticeDAO;
import com.goods.g1.service.NoticeService;
import com.goods.g1.util.Paging;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;

@Controller
public class NoticeController {

    @Autowired
    private NoticeService ns;

    @GetMapping("/noticeList")
    public ModelAndView noticeList() {
        ModelAndView mav = new ModelAndView();
        HashMap<String, Object> result = ns.getNoticeList();
        mav.addObject("NoticeList",result.get("NoticeList"));
        mav.addObject("paging",result.get("paging"));
        mav.setViewName("notice/noticeList");
        return mav;
    }




}
