package com.bx.implatform.vo;

import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * 分销统计VO
 * 
 * @author Blue
 * @date 2025-01-12
 */
@Data
public class DistributionStatisticsVO implements Serializable {

    /**
     * 今日佣金
     */
    private BigDecimal todayCommission;

    /**
     * 昨日佣金
     */
    private BigDecimal yesterdayCommission;

    /**
     * 本月佣金
     */
    private BigDecimal monthCommission;

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
     * 直推人数
     */
    private Integer level1Count;

    /**
     * 间推人数
     */
    private Integer level2Count;

    /**
     * 今日订单数
     */
    private Integer todayOrderCount;

    /**
     * 本月订单数
     */
    private Integer monthOrderCount;

    /**
     * 累计订单数
     */
    private Integer totalOrderCount;

    /**
     * 团队总人数
     */
    private Integer teamTotalCount;
}
