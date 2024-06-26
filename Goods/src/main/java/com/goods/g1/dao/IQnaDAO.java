package com.goods.g1.dao;

import com.goods.g1.dto.QnaVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface IQnaDAO {
    List<QnaVO> getAllQna();
    QnaVO getQna(int qseq);
}
