package com.goods.g1.dto;

import lombok.Data;

@Data
public class GoodsImageVO {
    private int giseq;
    private int gseq;
    private String oriname;
    private String realname;
    private Long filesize;

    public GoodsImageVO() {}

    public GoodsImageVO(String oriname, String realname, long fileSize, int gseq) {
    }
}
