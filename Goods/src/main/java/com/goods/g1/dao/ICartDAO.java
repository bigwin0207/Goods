package com.goods.g1.dao;

import com.goods.g1.dto.CartVO;
import com.goods.g1.dto.GoodsVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ICartDAO {

    List<CartVO> getWishList(@Param("userid") String userid);

    int selectWish(@Param("userid") String userid, @Param("gseq") int gseq);

    void insertWish(@Param("userid") String userid, @Param("gvo") GoodsVO gvo);

    void deleteWish(@Param("gseq") int gseq, @Param("userid") String userid);
}
