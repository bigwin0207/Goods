package com.goods.g1.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface IAdmin2DAO {
    void adminSwitch(@Param("userid") String userid);
    void discardMember(@Param("userid") String userid);
}
