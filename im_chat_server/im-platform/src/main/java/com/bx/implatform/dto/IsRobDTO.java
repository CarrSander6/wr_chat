package com.bx.implatform.dto;

import lombok.Data;

import java.io.Serializable;

@Data
public class IsRobDTO implements Serializable {

    /**
     * 用户id
     */
    private Long userId;

    /**
     * 红包id
     */
    private String redId;
}
