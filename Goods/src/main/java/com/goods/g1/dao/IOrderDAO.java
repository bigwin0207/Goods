package com.goods.g1.dao;

import com.goods.g1.dto.OrderVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface IOrderDAO {
    void insertOrder(@Param("userid") String userid);

    int lookupMaxOseq(@Param("userid") String userid);

    void insertOrderDetail(@Param("ovo") OrderVO ovo, @Param("oseq") int oseq);
}
