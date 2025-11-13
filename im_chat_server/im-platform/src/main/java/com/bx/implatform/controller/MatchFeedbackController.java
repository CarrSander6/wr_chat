package com.bx.implatform.controller;

import com.bx.implatform.entity.MatchFeedback;
import com.bx.implatform.result.Result;
import com.bx.implatform.result.ResultUtils;
import com.bx.implatform.service.MatchFeedbackService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Tag(name = "匹配反馈")
@RestController
@RequestMapping("/match/feedback")
@RequiredArgsConstructor
public class MatchFeedbackController {

    private final MatchFeedbackService feedbackService;

    @PostMapping("/submit")
    @Operation(summary = "提交匹配反馈", description = "提交对匹配对象的评分与评价")
    public Result<Void> submit(@NotNull @RequestParam("targetUserId") Long targetUserId,
                               @Min(1) @Max(5) @RequestParam("score") Integer score,
                               @RequestParam(value = "comment", required = false) String comment) {
        feedbackService.submitFeedback(targetUserId, score, comment);
        return ResultUtils.success();
    }

    @GetMapping("/list")
    @Operation(summary = "我的反馈列表", description = "分页查询我提交的匹配反馈")
    public Result<List<MatchFeedback>> list(@RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum,
                                            @RequestParam(value = "pageSize", defaultValue = "20") Integer pageSize) {
        return ResultUtils.success(feedbackService.listMyFeedback(pageNum, pageSize));
    }
}
