package com.goods.g1.controller;

import com.goods.g1.dto.QnaVO;
import com.goods.g1.service.QnaService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class QnaController {

    @Autowired
    private QnaService qs;

    @GetMapping("/qnaList")
    public ModelAndView qnaList(HttpServletRequest request, Model model) {
        ModelAndView mav = new ModelAndView();
        mav.addObject("qnaList", qs.getAllQna());
        mav.setViewName("qna/qnaList");
        return mav;
    }

    @GetMapping("/qnaView")
    public ModelAndView qnaView(@RequestParam("qseq") int qseq) {
        ModelAndView mav = new ModelAndView();
        mav.addObject("qnaVO", qs.getQna(qseq));
        mav.setViewName("qna/qnaView");
        return mav;
    }
}
