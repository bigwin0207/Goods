package com.goods.g1.service;

import com.goods.g1.dao.INoticeDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;

@Service
public class NoticeService {

    @Autowired
    INoticeDAO ndao;


    public HashMap<String, Object> getNoticeList() {
        HashMap<String, Object> result = new HashMap<>();
        result.put("noticeList", ndao.getNoticeList());
        result.put("paging",ndao.getPaging());

        return result;
    }
}
