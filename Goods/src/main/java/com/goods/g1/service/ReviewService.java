package com.goods.g1.service;

import com.goods.g1.dao.ReviewDAO;
import org.springframework.stereotype.Service;

@Service
public class ReviewService {
    private final ReviewDAO reviewDAO;

    public ReviewService(ReviewDAO reviewDAO) {
        this.reviewDAO = reviewDAO;
    }
}
