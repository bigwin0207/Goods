package com.goods.g1.service;

import com.goods.g1.dao.IMemberDao;
import com.goods.g1.dto.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberService {
    @Autowired
    IMemberDao mdao;

    public MemberVO getMember(String userid) {
        MemberVO mvo = mdao.getMember(userid);
        return mvo;
    }
}
