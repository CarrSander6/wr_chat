package com.bx.implatform.service;

import com.bx.implatform.vo.DistributionStatisticsVO;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

/**
 * 分销统计服务
 * 
 * @author Blue
 * @date 2025-01-12
 */
public interface DistributionStatisticsService {

    /**
     * 获取分销商统计数据
     * 
     * @return 统计数据
     */
    DistributionStatisticsVO getStatistics();

    /**
     * 获取分销商团队列表
     * 
     * @param level 层级 1-直推 2-间推
     * @param pageNum 页码
     * @param pageSize 页大小
     * @return 团队成员列表
     */
    List<Map<String, Object>> getTeamList(Integer level, Integer pageNum, Integer pageSize);

    /**
     * 获取每日佣金统计
     * 
     * @param days 天数
     * @return 每日佣金数据
     */
    List<Map<String, Object>> getDailyCommissionStats(Integer days);

    /**
     * 获取佣金排行榜
     * 
     * @param type 类型 1-今日 2-本周 3-本月 4-总榜
     * @param limit 数量
     * @return 排行榜数据
     */
    List<Map<String, Object>> getCommissionRanking(Integer type, Integer limit);

    /**
     * 计算预估佣金
     * 
     * @param productId 商品ID
     * @param quantity 数量
     * @return 预估佣金金额
     */
    BigDecimal calculateEstimatedCommission(Long productId, Integer quantity);
}
