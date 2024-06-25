package com.goods.g1.dto;


import lombok.Data;


@Data
public class CartVO {

	private int cseq;
	private int gseq;
	private String userid;
	private String name;
	private String gname;
	private int quantity;
	private int s_price;
	private int totalprice;	
	private String thum;
	private String realname;
}
