package com.bx.implatform.controller;

import com.bx.implatform.result.ResultUtils;
import com.bx.implatform.service.MatchRecommendService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

/**
 * 匹配推荐控制器
 * 
 * @author Blue
 * @date 2025-01-12
 */
@Tag(name = "匹配推荐")
@RestController
@RequestMapping("/match/recommend")
@RequiredArgsConstructor
public class MatchRecommendController {

    private final MatchRecommendService recommendService;

    @GetMapping("/smart")
    @Operation(summary = "获取智能推荐", description = "基于用户画像的智能推荐")
    public Object getSmartRecommendations(@RequestParam(defaultValue = "10") Integer limit) {
        return ResultUtils.success(recommendService.getSmartRecommendations(limit));
    }

    @GetMapping("/by-interest")
    @Operation(summary = "基于兴趣推荐", description = "根据兴趣标签推荐相似用户")
    public Object getRecommendationsByInterest(@RequestParam(defaultValue = "10") Integer limit) {
        return ResultUtils.success(recommendService.getRecommendationsByInterest(limit));
    }

    @GetMapping("/nearby")
    @Operation(summary = "附近的人", description = "根据地理位置推荐附近的用户")
    public Object getRecommendationsByLocation(@RequestParam Double longitude,
                                               @RequestParam Double latitude,
                                               @RequestParam(defaultValue = "10") Integer radius,
                                               @RequestParam(defaultValue = "10") Integer limit) {
        return ResultUtils.success(recommendService.getRecommendationsByLocation(
                longitude, latitude, radius, limit));
    }

    @GetMapping("/match-score")
    @Operation(summary = "计算匹配度", description = "计算与指定用户的匹配度分数")
    public Object calculateMatchScore(@RequestParam Long targetUserId) {
        return ResultUtils.success(recommendService.calculateMatchScore(null, targetUserId));
    }
}
