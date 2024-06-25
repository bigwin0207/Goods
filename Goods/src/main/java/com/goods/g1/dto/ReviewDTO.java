package com.goods.g1.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

import java.sql.Timestamp;

@Data
@Builder
@AllArgsConstructor
public class ReviewDTO {
    private int rseq;
    private String userid;
    private int grade;
    private int gseq;
    private String category;
    private String gname;
    private String subject;
    private String content;
    private Timestamp indate;
    private int giseq;
    private String realName;

    public ReviewDTO() {}
}
