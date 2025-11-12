package com.bx.implatform.dto;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.math.BigDecimal;

@Data
public class RedpacketDto {


    @NotNull(message = "红包个数不能为空")
    private Integer total;//红包个数

    @NotNull(message = "红包总金额不能为空")
    private BigDecimal amount;//总金额

    @NotNull(message = "交易密码不能为空")
    private String tradePassword;
}
