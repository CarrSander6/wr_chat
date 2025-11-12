package com.bx.implatform.controller;

import com.bx.implatform.dto.CreateOrderDTO;
import com.bx.implatform.result.Result;
import com.bx.implatform.result.ResultUtils;
import com.bx.implatform.service.MallService;
import com.bx.implatform.vo.OrderVO;
import com.bx.implatform.vo.ProductVO;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 商城控制器
 */
@Tag(name = "商城系统")
@RestController
@RequestMapping("/mall")
@RequiredArgsConstructor
@Slf4j
public class MallController {

    private final MallService mallService;

    @GetMapping("/product/list")
    @Operation(summary = "获取商品列表", description = "获取在售商品列表")
    public Result<List<ProductVO>> getProductList(
            @RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum,
            @RequestParam(value = "pageSize", defaultValue = "20") Integer pageSize) {
        return ResultUtils.success(mallService.getProductList(pageNum, pageSize));
    }

    @GetMapping("/product/{id}")
    @Operation(summary = "获取商品详情", description = "根据商品ID获取详情")
    public Result<ProductVO> getProductDetail(@PathVariable("id") Long id) {
        return ResultUtils.success(mallService.getProductDetail(id));
    }

    @PostMapping("/order/create")
    @Operation(summary = "创建订单", description = "创建购买订单")
    public Result<OrderVO> createOrder(@Valid @RequestBody CreateOrderDTO dto) {
        return ResultUtils.success(mallService.createOrder(dto));
    }

    @GetMapping("/order/list")
    @Operation(summary = "获取订单列表", description = "获取用户的订单列表")
    public Result<List<OrderVO>> getOrderList(
            @RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum,
            @RequestParam(value = "pageSize", defaultValue = "20") Integer pageSize) {
        return ResultUtils.success(mallService.getOrderList(pageNum, pageSize));
    }

    @GetMapping("/order/{id}")
    @Operation(summary = "获取订单详情", description = "根据订单ID获取详情")
    public Result<OrderVO> getOrderDetail(@PathVariable("id") Long id) {
        return ResultUtils.success(mallService.getOrderDetail(id));
    }

    @PostMapping("/order/pay/{id}")
    @Operation(summary = "支付订单", description = "支付指定订单")
    public Result<Void> payOrder(
            @PathVariable("id") Long id,
            @RequestParam(value = "iosReceipt", required = false) String iosReceipt) {
        mallService.payOrder(id, iosReceipt);
        return ResultUtils.success();
    }

    @PostMapping("/order/cancel/{id}")
    @Operation(summary = "取消订单", description = "取消未支付的订单")
    public Result<Void> cancelOrder(@PathVariable("id") Long id) {
        mallService.cancelOrder(id);
        return ResultUtils.success();
    }
}
