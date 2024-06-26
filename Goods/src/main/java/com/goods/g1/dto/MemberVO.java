package com.goods.g1.dto;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

import java.sql.Timestamp;

@Data
@Builder
@AllArgsConstructor
public class MemberVO {
    private String userid;
    private String pwd;
    private int gseq;
    private String grade;
    private float sale;
    private String name;
    private String email;
    private String phone;
    private String zip_num;
    private String address1;
    private String address2;
    private String address3;
    private Timestamp indate;
    private Timestamp last_login_time;
    private int is_login;
    private String provider;

    public MemberVO() {}
}

