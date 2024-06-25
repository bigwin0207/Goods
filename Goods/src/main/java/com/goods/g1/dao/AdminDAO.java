package com.goods.g1.dao;

import com.goods.g1.dto.MemberDTO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface AdminDAO {
    List<MemberDTO> getMemberList();
}
