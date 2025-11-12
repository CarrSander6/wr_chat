package com.bx.implatform.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 商城订单表
 */
@Data
@TableName("im_mall_order")
public class MallOrder {

    /**
     * 主键ID
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 订单号
     */
    private String orderNo;

    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 商品ID
     */
    private Long productId;

    /**
     * 商品名称
     */
    private String productName;

    /**
     * 商品数量
     */
    private Integer quantity;

    /**
     * 单价
     */
    private BigDecimal unitPrice;

    /**
     * 订单总金额
     */
    private BigDecimal totalAmount;

    /**
     * 支付方式: 1-余额支付 2-iOS内购
     */
    private Integer paymentMethod;

    /**
     * iOS交易凭证
     */
    private String iosReceipt;

    /**
     * 订单状态: 0-待支付 1-已支付 2-已取消 3-已完成
     */
    private Integer status;

    /**
     * 推荐人用户ID
     */
    private Long referrerUserId;

    /**
     * 创建时间
     */
    private Date createdTime;

    /**
     * 支付时间
     */
    private Date paidTime;

    /**
     * 完成时间
     */
    private Date completedTime;

    /**
     * 更新时间
     */
    private Date updatedTime;
}
