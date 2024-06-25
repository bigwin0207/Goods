package com.goods.g1.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

import java.sql.Timestamp;

@Data
@Builder
@AllArgsConstructor
public class QnaDTO {
    private int qseq;
    private String userid;
    private String subject;
    private String content;
    private Timestamp indate;
    private String reply;
    private Timestamp replyDate;

    public QnaDTO() {}
}
