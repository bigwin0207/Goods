package com.goods.g1.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.goods.g1.dto.MemberDTO;
import com.goods.g1.dto.NoticeDTO;
import com.goods.g1.dto.QnaDTO;
import com.goods.g1.dto.ReviewDTO;

@Repository
@Mapper
public interface AdminDAO {
    List<MemberDTO> getMemberList(@Param("limit") int limit, @Param("offset") int offset);
    int getMemberTotal();
    List<QnaDTO> getQnaList(@Param("limit") int limit, @Param("offset") int offset);
    int getQnaTotal();
    List<ReviewDTO> getReviewList(@Param("limit") int limit, @Param("offset") int offset);
    int getReviewTotal();
    List<NoticeDTO> getNoticeList(@Param("limit") int limit, @Param("offset") int offset);
    int getNoticeTotal();
}
