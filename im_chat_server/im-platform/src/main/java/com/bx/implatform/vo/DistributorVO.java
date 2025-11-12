package com.bx.implatform.vo;

import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 分销用户信息VO
 */
@Data
public class DistributorVO {

    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 推广码
     */
    private String referralCode;

    /**
     * 分销商状态
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
     * 激活时间
     */
    private Date activatedTime;

    /**
     * 直推人数
     */
    private Integer level1Count;

    /**
     * 间推人数
     */
    private Integer level2Count;
}
