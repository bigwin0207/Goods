package com.goods.g1.dao;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface INoticeDAO {
    Object getNoticeList();
    Object getPaging();
}
