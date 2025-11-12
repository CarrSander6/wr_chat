package com.bx.implatform.dto;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.math.BigDecimal;

/**
 * 佣金提现DTO
 */
@Data
public class CommissionWithdrawDTO {

    /**
     * 提现金额
     */
    @NotNull(message = "提现金额不能为空")
    private BigDecimal amount;

    /**
     * 交易密码
     */
    @NotNull(message = "交易密码不能为空")
    private String tradePassword;
}
