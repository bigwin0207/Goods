package com.goods.g1.service;

import com.goods.g1.dao.AdminDAO;
import com.goods.g1.dto.MemberDTO;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdminService {
    private final AdminDAO adminDAO;

    public AdminService(AdminDAO adminDAO) {
        this.adminDAO = adminDAO;
    }

    public List<MemberDTO> getMemberList() {
        return adminDAO.getMemberList();
    }
}
