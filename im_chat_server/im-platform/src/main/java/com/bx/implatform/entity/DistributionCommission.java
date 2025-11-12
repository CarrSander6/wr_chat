package com.bx.implatform.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 分销佣金记录表
 */
@Data
@TableName("im_distribution_commission")
public class DistributionCommission {

    /**
     * 主键ID
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 分销商用户ID
     */
    private Long distributorUserId;

    /**
     * 订单ID
     */
    private Long orderId;

    /**
     * 购买用户ID
     */
    private Long buyerUserId;

    /**
     * 佣金类型: 1-直推佣金 2-间推佣金
     */
    private Integer commissionType;

    /**
     * 订单金额
     */
    private BigDecimal orderAmount;

    /**
     * 佣金金额
     */
    private BigDecimal commissionAmount;

    /**
     * 佣金比例
     */
    private BigDecimal commissionRate;

    /**
     * 状态: 0-待结算 1-已结算 2-已取消
     */
    private Integer status;

    /**
     * 创建时间
     */
    private Date createdTime;

    /**
     * 结算时间
     */
    private Date settledTime;
}
