package com.goods.g1.service;

import com.goods.g1.dao.IQnaDAO;
import com.goods.g1.dto.QnaVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class QnaService {

    @Autowired
    private IQnaDAO qdao;

    public List<QnaVO> getAllQna() {
        return qdao.getAllQna();
    }

    public QnaVO getQna(int qseq) {
        return qdao.getQna(qseq);
    }
}
