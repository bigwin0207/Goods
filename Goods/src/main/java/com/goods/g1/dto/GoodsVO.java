package com.goods.g1.dto;

import lombok.Data;

import java.util.Date;
import java.util.List;

@Data
public class GoodsVO {
    private int gseq;
    private String gname;
    private int cgseq;
    private int oprice;
    private int sprice;
    private int mprice;
    private String content;
    private int bestyn;
    private int useyn;
    private Date indate;
    private String thum;
    private List<GoodsImageVO> imageList;
    private String category;
    private int giseq;
    private String realname;
}
