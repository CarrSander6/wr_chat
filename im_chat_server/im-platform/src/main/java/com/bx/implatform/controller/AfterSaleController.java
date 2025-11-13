package com.bx.implatform.controller;

import com.bx.implatform.entity.AfterSaleRequest;
import com.bx.implatform.result.Result;
import com.bx.implatform.result.ResultUtils;
import com.bx.implatform.service.AfterSaleService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Tag(name = "售后服务")
@RestController
@RequestMapping("/mall/aftersale")
@RequiredArgsConstructor
public class AfterSaleController {

    private final AfterSaleService afterSaleService;

    @PostMapping("/request")
    @Operation(summary = "申请售后/退货")
    public Result<Long> request(@NotNull @RequestParam Long orderId,
                                @RequestParam(required = false) String reason){
        return ResultUtils.success(afterSaleService.requestReturn(orderId, reason));
    }

    @GetMapping("/my")
    @Operation(summary = "我的售后申请")
    public Result<List<AfterSaleRequest>> my(@RequestParam(defaultValue = "1") Integer pageNum,
                                             @RequestParam(defaultValue = "20") Integer pageSize){
        return ResultUtils.success(afterSaleService.listMyRequests(pageNum, pageSize));
    }
}
