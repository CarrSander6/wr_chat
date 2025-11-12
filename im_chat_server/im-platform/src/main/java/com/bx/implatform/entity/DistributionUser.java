package com.bx.implatform.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 分销用户表
 * 记录分销商信息
 */
@Data
@TableName("im_distribution_user")
public class DistributionUser {

    /**
     * 主键ID
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 推广码
     */
    private String referralCode;

    /**
     * 上级分销商用户ID（一级）
     */
    private Long parentUserId;

    /**
     * 二级上级分销商用户ID
     */
    private Long grandParentUserId;

    /**
     * 分销商状态: 0-未激活 1-已激活 2-已禁用
     */
    private Integer status;

    /**
     * 累计佣金
     */
    private BigDecimal totalCommission;

    /**
     * 可提现佣金
     */
    private BigDecimal availableCommission;

    /**
     * 已提现佣金
     */
    private BigDecimal withdrawnCommission;

    /**
     * 激活条件: 消费金额
     */
    private BigDecimal activationAmount;

    /**
     * 激活时间
     */
    private Date activatedTime;

    /**
     * 创建时间
     */
    private Date createdTime;

    /**
     * 更新时间
     */
    private Date updatedTime;
}
