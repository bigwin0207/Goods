package com.goods.g1.dto;


import jakarta.validation.constraints.NotEmpty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

import java.sql.Timestamp;

@Data
@Builder
@AllArgsConstructor
public class MemberVO {
    @NotEmpty(message="id를 입력하세요")
    private String userid;
    @NotEmpty(message="비밀번호를 입력하세요")
    private String pwd;
    @NotEmpty(message="이름을 입력하세요")
    private String name;
    @NotEmpty(message="이메일을 입력하세요")
    private String email;
    @NotEmpty(message="전화번호를 입력하세요")
    private String phone;
    private int gseq;
    private String grade;
    private float sale;
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

