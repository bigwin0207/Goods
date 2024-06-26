package com.goods.g1.dao;

import com.goods.g1.dto.AdminVO;
import com.goods.g1.dto.MemberVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface IAdminDAO {


    AdminVO getAdmin(@Param("adminID") String adminID);

    int getTotalMember();

    List<MemberVO> getMemberList(@Param("amount") int amount, @Param("offset") int offset);
}
