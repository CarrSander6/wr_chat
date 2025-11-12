package com.bx.implatform.dto;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

/**
 * 创建订单DTO
 */
@Data
public class CreateOrderDTO {

    /**
     * 商品ID
     */
    @NotNull(message = "商品ID不能为空")
    private Long productId;

    /**
     * 购买数量
     */
    @NotNull(message = "购买数量不能为空")
    private Integer quantity;

    /**
     * 支付方式: 1-余额支付 2-iOS内购
     */
    @NotNull(message = "支付方式不能为空")
    private Integer paymentMethod;

    /**
     * iOS交易凭证（iOS内购时必填）
     */
    private String iosReceipt;

    /**
     * 推荐人用户ID（可选）
     */
    private Long referrerUserId;
}
