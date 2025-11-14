package com.bx.implatform.dto;

import jakarta.validation.constraints.Pattern;
import lombok.Data;

/**
 * 激活分销商DTO
 */
@Data
public class ActivateDistributorDTO {

    /**
     * 推荐人的推广码（可选）
     */
    @Pattern(regexp = "^[A-Z0-9]{8}$", message = "推广码格式不正确")
    private String referralCode;
}
