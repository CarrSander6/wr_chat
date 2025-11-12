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
import org.dromara.im.domain.vo.ImUserWithdrawalVo;
import org.dromara.im.domain.bo.ImUserWithdrawalBo;
import org.dromara.im.service.IImUserWithdrawalService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

/**
 * 用户提现记录
 *
 * @author Blue
 * @date 2025-08-27
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/im/userWithdrawal")
public class ImUserWithdrawalController extends BaseController {

    private final IImUserWithdrawalService imUserWithdrawalService;

    /**
     * 查询用户提现记录列表
     */
    @SaCheckPermission("im:userWithdrawal:list")
    @GetMapping("/list")
    public TableDataInfo<ImUserWithdrawalVo> list(ImUserWithdrawalBo bo, PageQuery pageQuery) {
        return imUserWithdrawalService.queryPageList(bo, pageQuery);
    }

    /**
     * 导出用户提现记录列表
     */
    @SaCheckPermission("im:userWithdrawal:export")
    @Log(title = "用户提现记录", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(ImUserWithdrawalBo bo, HttpServletResponse response) {
        List<ImUserWithdrawalVo> list = imUserWithdrawalService.queryList(bo);
        ExcelUtil.exportExcel(list, "用户提现记录", ImUserWithdrawalVo.class, response);
    }

    /**
     * 获取用户提现记录详细信息
     *
     * @param id 主键
     */
    @SaCheckPermission("im:userWithdrawal:query")
    @GetMapping("/{id}")
    public R<ImUserWithdrawalVo> getInfo(@NotNull(message = "主键不能为空")
                                     @PathVariable Long id) {
        return R.ok(imUserWithdrawalService.queryById(id));
    }

    /**
     * 新增用户提现记录
     */
    @SaCheckPermission("im:userWithdrawal:add")
    @Log(title = "用户提现记录", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody ImUserWithdrawalBo bo) {
        return toAjax(imUserWithdrawalService.insertByBo(bo));
    }

    /**
     * 修改用户提现记录
     */
    @SaCheckPermission("im:userWithdrawal:edit")
    @Log(title = "用户提现记录", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody ImUserWithdrawalBo bo) {
        return toAjax(imUserWithdrawalService.updateByBo(bo));
    }

    /**
     * 删除用户提现记录
     *
     * @param ids 主键串
     */
    @SaCheckPermission("im:userWithdrawal:remove")
    @Log(title = "用户提现记录", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空")
                          @PathVariable Long[] ids) {
        return toAjax(imUserWithdrawalService.deleteWithValidByIds(List.of(ids), true));
    }
}
