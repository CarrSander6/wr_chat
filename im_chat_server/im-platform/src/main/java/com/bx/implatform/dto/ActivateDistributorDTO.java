package com.bx.implatform.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

/**
 * 激活分销商DTO
 */
@Data
public class ActivateDistributorDTO {

    /**
     * 推荐人的推广码（可选）
     */
    private String referralCode;
}
