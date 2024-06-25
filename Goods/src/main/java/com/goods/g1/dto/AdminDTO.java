package com.goods.g1.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
@AllArgsConstructor
public class AdminDTO {
    private String adminId;
    private String pwd;
    private String name;
    private String phone;
    private String email;

    public AdminDTO() {}
}
