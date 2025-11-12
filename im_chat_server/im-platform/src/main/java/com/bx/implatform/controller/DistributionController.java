package com.bx.implatform.controller;

import com.bx.implatform.dto.ActivateDistributorDTO;
import com.bx.implatform.dto.CommissionWithdrawDTO;
import com.bx.implatform.entity.DistributionCommission;
import com.bx.implatform.result.Result;
import com.bx.implatform.result.ResultUtils;
import com.bx.implatform.service.DistributionService;
import com.bx.implatform.vo.DistributorVO;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 分销控制器
 */
@Tag(name = "分销系统")
@RestController
@RequestMapping("/distribution")
@RequiredArgsConstructor
@Slf4j
public class DistributionController {

    private final DistributionService distributionService;

    @PostMapping("/activate")
    @Operation(summary = "激活分销商", description = "激活用户为分销商，返回推广码")
    public Result<String> activateDistributor(@Valid @RequestBody ActivateDistributorDTO dto) {
        String referralCode = distributionService.activateDistributor(dto);
        return ResultUtils.success(referralCode);
    }

    @GetMapping("/info")
    @Operation(summary = "获取分销商信息", description = "获取当前用户的分销商信息")
    public Result<DistributorVO> getDistributorInfo() {
        return ResultUtils.success(distributionService.getDistributorInfo());
    }

    @GetMapping("/commission/list")
    @Operation(summary = "获取佣金明细", description = "获取佣金明细列表")
    public Result<List<DistributionCommission>> getCommissionList(
            @RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum,
            @RequestParam(value = "pageSize", defaultValue = "20") Integer pageSize) {
        return ResultUtils.success(distributionService.getCommissionList(pageNum, pageSize));
    }

    @PostMapping("/commission/withdraw")
    @Operation(summary = "佣金提现", description = "将佣金提现到余额")
    public Result<Void> withdrawCommission(@Valid @RequestBody CommissionWithdrawDTO dto) {
        distributionService.withdrawCommission(dto);
        return ResultUtils.success();
    }

    @GetMapping("/referrer")
    @Operation(summary = "根据推广码查询推荐人", description = "根据推广码获取推荐人用户ID")
    public Result<Long> getUserByReferralCode(@RequestParam("code") String code) {
        return ResultUtils.success(distributionService.getUserIdByReferralCode(code));
    }
}
