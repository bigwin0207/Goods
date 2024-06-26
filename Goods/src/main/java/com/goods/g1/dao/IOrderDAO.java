package com.goods.g1.dao;

import com.goods.g1.dto.OrderVO;
import com.goods.g1.util.MPaging;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface IOrderDAO {
    void insertOrder(@Param("userid") String userid);

    int lookupMaxOseq(@Param("userid") String userid);

    void insertOrderDetail(@Param("ovo") OrderVO ovo, @Param("oseq") int oseq);

    int getAllCount(@Param("userid") String userid, @Param("fieldName") String fieldName);

    List<OrderVO> selectOrderList(@Param("userid") String userid, @Param("paging") MPaging paging);

    List<OrderVO> selectOrderDetail(@Param("oseq") int oseq);
}
