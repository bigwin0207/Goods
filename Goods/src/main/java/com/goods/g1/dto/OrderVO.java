package com.goods.g1.dto;

import lombok.Data;

import java.sql.Date;

@Data
public class OrderVO {
	private int odseq;
	private int oseq;
	private Date indate;
	private String userid;
	private String name;
	private String zip_code;
	private String address;
	private String d_address;
	private String phone;
	private int gseq;
	private String gname;
	private int quantity;
	private int totalprice;
	private int osseq;
	private String status;
	private int gradenum;
	private float sale;
	private String realname;
}
