package com.goods.g1.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

import java.sql.Timestamp;

@Data
@Builder
@AllArgsConstructor
public class NoticeDTO {
    private int nseq;
    private String adminId;
    private String subject;
    private String content;
    private Timestamp indate;

    public NoticeDTO() {}
}
