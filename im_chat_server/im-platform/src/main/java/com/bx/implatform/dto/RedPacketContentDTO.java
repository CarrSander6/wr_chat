package com.bx.implatform.dto;

import lombok.Data;

import java.io.Serializable;

@Data
public class RedPacketContentDTO implements Serializable {

    private String id;

    private Boolean rob;

    private Long userId;
}
