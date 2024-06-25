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
	private String zipcode;
	private String address;
	private String daddress;
	private String phone;
	private int gseq;
	private String gname;
	private int quantity;
	private int totalprice;
	private String status;
	private String thum;
	private int osseq;
	private float sale;
	private String realname;
}
