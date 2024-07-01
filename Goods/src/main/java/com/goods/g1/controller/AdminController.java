package com.goods.g1.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.goods.g1.dto.MemberDTO;
import com.goods.g1.service.AdminService;
import com.goods.g1.util.Paging;

@Controller
@RequestMapping("/admin")
public class AdminController {
    @Autowired
    AdminService adminService;

    @GetMapping("/memberList")
    public String getMemberList(Model model) {
    	int currentPage = 1;
    	int amount = 10;
    	
    	int total = adminService.getMemberTotal();
    	
    	Paging paging = new Paging(currentPage, amount, total);
    	int offset = (currentPage - 1) * 10;
    	
        List<MemberDTO> memberList = adminService.getMemberList(amount, offset);
        model.addAttribute("memberList", memberList);
        model.addAttribute("paging", paging);

        return "admin/index";
    }
    
    @PostMapping("/pageInfo")
    public @ResponseBody Paging getPageInfo(@RequestBody Map<String, String> paramMap) {
    	int total = 0;
    	
    	switch (paramMap.get("table")) {
    		case "member_view" -> total = adminService.getMemberTotal();
    		case "qna" -> total = adminService.getQnaTotal();
    		case "review" -> total = adminService.getReviewTotal();
    		case "notice" -> total = adminService.getNoticeTotal();
    	}
    	
    	Paging paging = new Paging(1, 10, total);
    	
    	return paging;
    }
    
    @PostMapping("/getContent")
    public @ResponseBody Map<String, Object> getContent(@RequestBody Map<String, Object> paramMap) {
    	Map<String, Object> resultMap = new HashMap<>();
    	int total = adminService.getMemberTotal();
    	Paging paging = new Paging((Integer)paramMap.get("currentPage"), (Integer)paramMap.get("amount"), total);
    	int offset = (paging.getCurrentPage() - 1) * 10;
    	
    	switch ((String)paramMap.get("table")) {
			case "member_view" -> resultMap.put("memberList", adminService.getMemberList(paging.getAmount(), offset));
			case "qna" -> resultMap.put("qnaList", adminService.getQnaList(paging.getAmount(), offset));
			case "review" -> resultMap.put("reviewList", adminService.getReviewList(paging.getAmount(), offset));
			case "notice" -> resultMap.put("noticeList", adminService.getNoticeList(paging.getAmount(), offset));
		}
    	
    	resultMap.put("paging", paging);
    	
    	return resultMap;
    }
}
