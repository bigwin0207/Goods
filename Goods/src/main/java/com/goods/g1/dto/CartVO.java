package com.goods.g1.dto;


import lombok.Data;


@Data
public class CartVO {

	private int cseq;
	private int gseq;
	private String userid;
	private String username;
	private String goodsname;
	private int quantity;
	private int sprice;
	private int totalprice;	
	private String thum;
	private String realname;
}
