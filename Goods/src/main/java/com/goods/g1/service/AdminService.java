package com.goods.g1.service;

import com.goods.g1.dao.IAdminDAO;
import com.goods.g1.dto.AdminVO;
import com.goods.g1.dto.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
public class AdminService {

    private final IAdminDAO adao;

    @Autowired
    public AdminService(IAdminDAO adao) {
        this.adao = adao;
    }

    public AdminVO adminLoginForm(String adminID) {
        return adao.getAdmin(adminID);
    }

    public int getTotalMember() {
        return  adao.getTotalMember();
    }

    public List<MemberVO> getMemberList(int amount, int currentPage) {
        int offset = (currentPage - 1) * amount;
        return adao.getMemberList(amount, offset);
    }
}
