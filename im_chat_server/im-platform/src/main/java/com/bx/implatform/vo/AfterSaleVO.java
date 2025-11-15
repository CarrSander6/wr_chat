package com.bx.implatform.vo;

import lombok.Data;

import java.util.Date;

@Data
public class AfterSaleVO {
    private Long id;
    private Long orderId;
    private Long userId;
    private String reason;
    private Integer status;
    private Date createdTime;
    private Date updatedTime;
    private java.math.BigDecimal refundAmount;
    private Integer paymentMethod;
}