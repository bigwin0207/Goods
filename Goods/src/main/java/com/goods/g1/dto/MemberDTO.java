package com.goods.g1.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

import java.sql.Timestamp;

@Data
@Builder
@AllArgsConstructor
public class MemberDTO {
	private String userid;
	private String pwd;
	private int gradeNum;
	private String gname;
	private float sale;
	private String name;
	private String email;
	private String phone;
	private String zip_code;
	private String address;
	private String d_address;
	private Timestamp indate;
	private Timestamp last_login_time;
	private int is_login;

    public MemberDTO() {}
}