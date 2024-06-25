package com.goods.g1.service;

import com.goods.g1.dao.QnaDAO;
import org.springframework.stereotype.Service;

@Service
public class QnaService {
    private final QnaDAO qnaDAO;

    public QnaService(QnaDAO qnaDAO) {
        this.qnaDAO = qnaDAO;
    }
}
