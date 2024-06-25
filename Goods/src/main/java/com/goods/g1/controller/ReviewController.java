package com.goods.g1.controller;

import com.goods.g1.service.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/review")
public class ReviewController {
    @Autowired
    ReviewService reviewService;


}
