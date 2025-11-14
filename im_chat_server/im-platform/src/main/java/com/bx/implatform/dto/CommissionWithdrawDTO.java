package com.bx.implatform.dto;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Size;
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
    @DecimalMin(value = "0.01", message = "提现金额需不少于0.01")
    private BigDecimal amount;

    /**
     * 交易密码
     */
    @NotNull(message = "交易密码不能为空")
    @Size(min = 6, max = 32, message = "交易密码长度需在6-32之间")
    private String tradePassword;
}
