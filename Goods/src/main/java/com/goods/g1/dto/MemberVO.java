package com.goods.g1.dto;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class MemberVO {
    private String userid;
    private String pwd;
    private int gseq;
    private String grade;
    private float sale;
    private String name;
    private String email;
    private String phone;
    private String zip_code;
    private String address1;
    private String address2;
    private String address3;
    private Timestamp indate;
    private Timestamp last_login_time;
    private int is_login;

    public MemberVO() {}
}
