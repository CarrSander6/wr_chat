package org.dromara.im.controller;

import java.util.List;

import lombok.RequiredArgsConstructor;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.constraints.*;
import cn.dev33.satoken.annotation.SaCheckPermission;
import org.springframework.web.bind.annotation.*;
import org.springframework.validation.annotation.Validated;
import org.dromara.common.idempotent.annotation.RepeatSubmit;
import org.dromara.common.log.annotation.Log;
import org.dromara.common.web.core.BaseController;
import org.dromara.common.mybatis.core.page.PageQuery;
import org.dromara.common.core.domain.R;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import org.dromara.common.log.enums.BusinessType;
import org.dromara.common.excel.utils.ExcelUtil;
import org.dromara.im.domain.vo.ImUserFundDetailVo;
import org.dromara.im.domain.bo.ImUserFundDetailBo;
import org.dromara.im.service.IImUserFundDetailService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

/**
 * 用户资产明细
 *
 * @author Blue
 * @date 2025-08-26
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/im/userFundDetail")
public class ImUserFundDetailController extends BaseController {

    private final IImUserFundDetailService imUserFundDetailService;

    /**
     * 查询用户资产明细列表
     */
    @SaCheckPermission("im:userFundDetail:list")
    @GetMapping("/list")
    public TableDataInfo<ImUserFundDetailVo> list(ImUserFundDetailBo bo, PageQuery pageQuery) {
        return imUserFundDetailService.queryPageList(bo, pageQuery);
    }

    /**
     * 导出用户资产明细列表
     */
    @SaCheckPermission("im:userFundDetail:export")
    @Log(title = "用户资产明细", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(ImUserFundDetailBo bo, HttpServletResponse response) {
        List<ImUserFundDetailVo> list = imUserFundDetailService.queryList(bo);
        ExcelUtil.exportExcel(list, "用户资产明细", ImUserFundDetailVo.class, response);
    }

    /**
     * 获取用户资产明细详细信息
     *
     * @param id 主键
     */
    @SaCheckPermission("im:userFundDetail:query")
    @GetMapping("/{id}")
    public R<ImUserFundDetailVo> getInfo(@NotNull(message = "主键不能为空")
                                     @PathVariable Long id) {
        return R.ok(imUserFundDetailService.queryById(id));
    }

    /**
     * 新增用户资产明细
     */
    @SaCheckPermission("im:userFundDetail:add")
    @Log(title = "用户资产明细", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody ImUserFundDetailBo bo) {
        return toAjax(imUserFundDetailService.insertByBo(bo));
    }

    /**
     * 修改用户资产明细
     */
    @SaCheckPermission("im:userFundDetail:edit")
    @Log(title = "用户资产明细", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody ImUserFundDetailBo bo) {
        return toAjax(imUserFundDetailService.updateByBo(bo));
    }

    /**
     * 删除用户资产明细
     *
     * @param ids 主键串
     */
    @SaCheckPermission("im:userFundDetail:remove")
    @Log(title = "用户资产明细", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空")
                          @PathVariable Long[] ids) {
        return toAjax(imUserFundDetailService.deleteWithValidByIds(List.of(ids), true));
    }
}
