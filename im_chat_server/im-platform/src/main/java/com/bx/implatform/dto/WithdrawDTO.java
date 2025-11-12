package com.bx.implatform.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.DecimalMax;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Min;
import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;

@Data
public class WithdrawDTO implements Serializable {

    @Schema(description = "提现金额")
    @DecimalMin(value = "0.01")
    @DecimalMax(value = "99999")
    private BigDecimal amount;
}
