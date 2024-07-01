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

    public List<MemberDTO> getMemberList(int limit, int offset) {
        return adminDAO.getMemberList(limit, offset);
    }
    
    public int getMemberTotal() {
    	return adminDAO.getMemberTotal();
    }
    
    public Object getQnaList(int limit, int offset) {
		return adminDAO.getQnaList(limit, offset);
	}
    
    public int getQnaTotal() {
    	return adminDAO.getQnaTotal();
    }
    
    public Object getReviewList(int limit, int offset) {
		return adminDAO.getReviewList(limit, offset);
	}

    public int getReviewTotal() {
    	return adminDAO.getReviewTotal();
    }

    public Object getNoticeList(int limit, int offset) {
		return adminDAO.getNoticeList(limit, offset);
	}
    
    public int getNoticeTotal() {
    	return adminDAO.getNoticeTotal();
    }
}
