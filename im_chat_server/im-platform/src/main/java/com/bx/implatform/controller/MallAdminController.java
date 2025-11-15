package com.bx.implatform.controller;

import com.bx.implatform.entity.MallCategory;
import com.bx.implatform.entity.MallSku;
import com.bx.implatform.result.Result;
import com.bx.implatform.result.ResultUtils;
import com.bx.implatform.service.MallAdminService;
import com.bx.implatform.service.AfterSaleService;
import com.bx.implatform.mapper.MallOrderMapper;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;

@Tag(name = "商城管理")
@RestController
@RequestMapping("/mall/admin")
@RequiredArgsConstructor
public class MallAdminController {

    private final MallAdminService adminService;
    private final AfterSaleService afterSaleService;
    private final MallOrderMapper orderMapper;

    @PostMapping("/category/create")
    @Operation(summary = "创建分类")
    public Result<Long> createCategory(@NotNull @RequestParam String name,
                                       @RequestParam(required = false) Long parentId,
                                       @RequestParam(required = false, defaultValue = "0") Integer sortOrder){
        return ResultUtils.success(adminService.createCategory(name, parentId, sortOrder));
    }

    @PutMapping("/category/update/{id}")
    @Operation(summary = "更新分类")
    public Result<Void> updateCategory(@PathVariable Long id,
                                       @NotNull @RequestParam String name,
                                       @RequestParam(required = false) Long parentId,
                                       @RequestParam(required = false) Integer sortOrder,
                                       @RequestParam(required = false, defaultValue = "1") Integer status){
        adminService.updateCategory(id, name, parentId, sortOrder, status);
        return ResultUtils.success();
    }

    @DeleteMapping("/category/delete/{id}")
    @Operation(summary = "删除分类")
    public Result<Void> deleteCategory(@PathVariable Long id){
        adminService.deleteCategory(id);
        return ResultUtils.success();
    }

    @GetMapping("/category/list")
    @Operation(summary = "分类列表")
    public Result<List<MallCategory>> listCategories(@RequestParam(required = false) Long parentId){
        return ResultUtils.success(adminService.listCategories(parentId));
    }

    @PostMapping("/sku/add")
    @Operation(summary = "新增SKU")
    public Result<Long> addSku(@NotNull @RequestParam Long productId,
                               @NotNull @RequestParam String skuCode,
                               @RequestParam(required = false) String attributes,
                               @NotNull @RequestParam BigDecimal price,
                               @NotNull @RequestParam Integer stock){
        return ResultUtils.success(adminService.addSku(productId, skuCode, attributes, price, stock));
    }

    @PutMapping("/sku/update/{id}")
    @Operation(summary = "更新SKU")
    public Result<Void> updateSku(@PathVariable Long id,
                                  @RequestParam(required = false) String attributes,
                                  @RequestParam(required = false) BigDecimal price,
                                  @RequestParam(required = false) Integer stock,
                                  @RequestParam(required = false, defaultValue = "1") Integer status){
        adminService.updateSku(id, attributes, price, stock, status);
        return ResultUtils.success();
    }

    @DeleteMapping("/sku/delete/{id}")
    @Operation(summary = "删除SKU")
    public Result<Void> deleteSku(@PathVariable Long id){
        adminService.deleteSku(id);
        return ResultUtils.success();
    }

    @GetMapping("/sku/list")
    @Operation(summary = "SKU列表")
    public Result<List<MallSku>> listSkus(@NotNull @RequestParam Long productId){
        return ResultUtils.success(adminService.listSkus(productId));
    }

    @PostMapping("/order/ship")
    @Operation(summary = "订单发货")
    public Result<Void> shipOrder(@NotNull @RequestParam Long orderId,
                                  @NotNull @RequestParam String carrier,
                                  @NotNull @RequestParam String shippingNo){
        adminService.shipOrder(orderId, carrier, shippingNo);
        return ResultUtils.success();
    }

    @PostMapping("/aftersale/approve")
    @Operation(summary = "审批售后-通过")
    public Result<Void> approveAfterSale(@NotNull @RequestParam Long id){
        afterSaleService.approve(id);
        return ResultUtils.success();
    }

    @PostMapping("/aftersale/reject")
    @Operation(summary = "审批售后-拒绝")
    public Result<Void> rejectAfterSale(@NotNull @RequestParam Long id,
                                        @RequestParam(required = false) String reason){
        afterSaleService.reject(id, reason);
        return ResultUtils.success();
    }

    @GetMapping("/aftersale/list")
    @Operation(summary = "售后申请列表")
    public Result<java.util.List<com.bx.implatform.vo.AfterSaleVO>> listAfterSales(@RequestParam(defaultValue = "1") Integer pageNum,
                                                                                   @RequestParam(defaultValue = "20") Integer pageSize,
                                                                                   @RequestParam(required = false) Integer status){
        java.util.List<com.bx.implatform.entity.AfterSaleRequest> list = adminService.listAfterSales(pageNum, pageSize, status);
        java.util.List<com.bx.implatform.vo.AfterSaleVO> vos = new java.util.ArrayList<>();
        for (com.bx.implatform.entity.AfterSaleRequest r : list) {
            com.bx.implatform.vo.AfterSaleVO vo = new com.bx.implatform.vo.AfterSaleVO();
            vo.setId(r.getId());
            vo.setOrderId(r.getOrderId());
            vo.setUserId(r.getUserId());
            vo.setReason(r.getReason());
            vo.setStatus(r.getStatus());
            vo.setCreatedTime(r.getCreatedTime());
            vo.setUpdatedTime(r.getUpdatedTime());
            com.bx.implatform.entity.MallOrder order = orderMapper.selectById(r.getOrderId());
            if (order != null) {
                vo.setRefundAmount(order.getTotalAmount());
                vo.setPaymentMethod(order.getPaymentMethod());
            }
            vos.add(vo);
        }
        return ResultUtils.success(vos);
    }
}
