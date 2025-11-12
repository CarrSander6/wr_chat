package com.bx.implatform.controller;

import com.bx.implatform.result.ResultUtils;
import com.bx.implatform.service.DistributionStatisticsService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

/**
 * 分销统计控制器
 * 
 * @author Blue
 * @date 2025-01-12
 */
@Tag(name = "分销统计")
@RestController
@RequestMapping("/distribution/statistics")
@RequiredArgsConstructor
public class DistributionStatisticsController {

    private final DistributionStatisticsService statisticsService;

    @GetMapping("/overview")
    @Operation(summary = "获取分销统计概览", description = "获取分销商的统计数据概览")
    public Object getStatistics() {
        return ResultUtils.success(statisticsService.getStatistics());
    }

    @GetMapping("/team")
    @Operation(summary = "获取团队列表", description = "获取分销商的团队成员列表")
    public Object getTeamList(@RequestParam(required = false) Integer level,
                              @RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "20") Integer pageSize) {
        return ResultUtils.success(statisticsService.getTeamList(level, pageNum, pageSize));
    }

    @GetMapping("/daily")
    @Operation(summary = "获取每日佣金统计", description = "获取最近N天的佣金统计数据")
    public Object getDailyCommissionStats(@RequestParam(defaultValue = "7") Integer days) {
        return ResultUtils.success(statisticsService.getDailyCommissionStats(days));
    }

    @GetMapping("/ranking")
    @Operation(summary = "获取佣金排行榜", description = "获取佣金排行榜")
    public Object getCommissionRanking(@RequestParam(defaultValue = "4") Integer type,
                                       @RequestParam(defaultValue = "10") Integer limit) {
        return ResultUtils.success(statisticsService.getCommissionRanking(type, limit));
    }

    @GetMapping("/estimate")
    @Operation(summary = "计算预估佣金", description = "计算购买指定商品的预估佣金")
    public Object calculateEstimatedCommission(@RequestParam Long productId,
                                               @RequestParam(defaultValue = "1") Integer quantity) {
        return ResultUtils.success(statisticsService.calculateEstimatedCommission(productId, quantity));
    }
}
