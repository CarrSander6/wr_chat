package com.bx.implatform.controller;

import com.bx.implatform.dto.MatchActionDTO;
import com.bx.implatform.result.Result;
import com.bx.implatform.result.ResultUtils;
import com.bx.implatform.service.MatchService;
import com.bx.implatform.vo.MatchHistoryVO;
import com.bx.implatform.vo.MatchedUserVO;
import com.bx.implatform.vo.UserVO;
import io.swagger.v3.oas.annotations.Operation;
import com.bx.implatform.annotation.RateLimit;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 社交匹配控制器
 */
@Tag(name = "社交匹配")
@RestController
@RequestMapping("/match")
@RequiredArgsConstructor
@Slf4j
public class MatchController {

    private final MatchService matchService;

    @GetMapping("/candidates")
    @Operation(summary = "获取待匹配用户", description = "获取推荐的待匹配用户列表")
    public Result<List<UserVO>> getMatchCandidates(
            @RequestParam(value = "limit", defaultValue = "10") Integer limit) {
        return ResultUtils.success(matchService.getMatchCandidates(limit));
    }

    @PostMapping("/action")
    @RateLimit(key = "match:action", limit = 20, windowSeconds = 60)
    @Operation(summary = "记录匹配操作", description = "记录喜欢或不喜欢操作，返回是否匹配成功")
    public Result<Boolean> recordMatchAction(@Valid @RequestBody MatchActionDTO dto) {
        Boolean matched = matchService.recordMatchAction(dto);
        return ResultUtils.success(matched);
    }

    @GetMapping("/history")
    @Operation(summary = "获取匹配历史", description = "获取用户的匹配操作历史记录")
    public Result<List<MatchHistoryVO>> getMatchHistory(
            @RequestParam(value = "actionType", required = false) Integer actionType,
            @RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum,
            @RequestParam(value = "pageSize", defaultValue = "20") Integer pageSize) {
        return ResultUtils.success(matchService.getMatchHistory(actionType, pageNum, pageSize));
    }

    @GetMapping("/matched")
    @Operation(summary = "获取已匹配用户", description = "获取双方互相喜欢的匹配用户列表")
    public Result<List<MatchedUserVO>> getMatchedUsers() {
        return ResultUtils.success(matchService.getMatchedUsers());
    }

    @GetMapping("/check")
    @Operation(summary = "检查匹配状态", description = "检查两个用户是否已匹配")
    public Result<Boolean> checkMatch(
            @RequestParam("user1Id") Long user1Id,
            @RequestParam("user2Id") Long user2Id) {
        return ResultUtils.success(matchService.checkMatch(user1Id, user2Id));
    }
}
