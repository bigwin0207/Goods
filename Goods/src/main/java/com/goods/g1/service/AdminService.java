package com.goods.g1.service;

import com.goods.g1.dao.AdminDAO;
import org.springframework.stereotype.Service;

@Service
public class AdminService {
    private final AdminDAO adminDAO;

    public AdminService(AdminDAO adminDAO) {
        this.adminDAO = adminDAO;
    }
}
