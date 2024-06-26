package com.goods.g1.dao;

import com.goods.g1.dto.GoodsImageVO;
import com.goods.g1.dto.GoodsVO;
import com.goods.g1.util.MPaging;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface IGoodsDAO {
    int getAllCount(@Param("fieldName") String fieldName, @Param("fieldValue") String fieldValue);

    List<GoodsVO> getBestList();

    List<GoodsVO> getCategoryList(@Param("cgseq") String cgseq, @Param("paging") MPaging paging);

    List<GoodsImageVO> getImageList(@Param("gseq") int gseq);

    GoodsVO getGoods(@Param("gseq") int gseq);

    List<GoodsVO> getAllGoods(@Param("gname") String gname, MPaging paging);

    List<GoodsVO> getAllCategories();

    void insertGoods(GoodsVO gvo);

    int lookupMaxGseq();

    void writeGoodsImages(int gseq, String oriname, String realname, Long fileSize);

}
