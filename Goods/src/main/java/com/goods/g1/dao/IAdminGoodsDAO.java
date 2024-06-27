package com.goods.g1.dao;

import com.goods.g1.dto.GoodsImageVO;
import com.goods.g1.dto.GoodsVO;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface IAdminGoodsDAO {

    void updateGoods(GoodsVO gvo);

    void deleteGoodsImagesWithGiseqs(@Param("giseqs") String[] giseqs, @Param("gseq") int gseq);

    void deleteGoodsImagesWithoutGiseqs(@Param("gseq") int gseq);

    void writeGoodsImages(GoodsImageVO goodsImageVO);
}
