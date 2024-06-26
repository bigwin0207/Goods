package com.goods.g1.service;

import com.goods.g1.dao.IAdminDAO_;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminService_ {

    @Autowired
    IAdminDAO_ adao1;

    public void adminSwitch(String[] userids) {
        for(String userid : userids)
            adao1.adminSwitch(userid);
    }

    public void discardMember(String[] userids) {
        for(String userid : userids)
            adao1.discardMember(userid);
    }
}
