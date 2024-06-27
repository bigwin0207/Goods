package com.goods.g1.service;

import com.goods.g1.dao.IAdmin2DAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class Admin2Service {

    @Autowired
    IAdmin2DAO adao1;

    public void adminSwitch(String[] userids) {
        for(String userid : userids)
            adao1.adminSwitch(userid);
    }

    public void discardMember(String[] userids) {
        for(String userid : userids)
            adao1.discardMember(userid);
    }
}
