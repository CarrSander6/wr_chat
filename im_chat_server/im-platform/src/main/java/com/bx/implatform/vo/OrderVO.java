package com.bx.implatform.vo;

import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 订单VO
 */
@Data
public class OrderVO {

    /**
     * 订单ID
     */
    private Long id;

    /**
     * 订单号
     */
    private String orderNo;

    /**
     * 商品名称
     */
    private String productName;

    /**
     * 商品数量
     */
    private Integer quantity;

    /**
     * 订单总金额
     */
    private BigDecimal totalAmount;

    /**
     * 支付方式
     */
    private Integer paymentMethod;

    /**
     * 订单状态
     */
    private Integer status;

    /**
     * 创建时间
     */
    private Date createdTime;

    /**
     * 支付时间
     */
    private Date paidTime;
}
