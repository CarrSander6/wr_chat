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
import org.dromara.im.domain.vo.ImUserRechargeVo;
import org.dromara.im.domain.bo.ImUserRechargeBo;
import org.dromara.im.service.IImUserRechargeService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

/**
 * 用户充值记录
 *
 * @author Blue
 * @date 2025-08-27
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/im/userRecharge")
public class ImUserRechargeController extends BaseController {

    private final IImUserRechargeService imUserRechargeService;

    /**
     * 查询用户充值记录列表
     */
    @SaCheckPermission("im:userRecharge:list")
    @GetMapping("/list")
    public TableDataInfo<ImUserRechargeVo> list(ImUserRechargeBo bo, PageQuery pageQuery) {
        return imUserRechargeService.queryPageList(bo, pageQuery);
    }

    /**
     * 导出用户充值记录列表
     */
    @SaCheckPermission("im:userRecharge:export")
    @Log(title = "用户充值记录", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(ImUserRechargeBo bo, HttpServletResponse response) {
        List<ImUserRechargeVo> list = imUserRechargeService.queryList(bo);
        ExcelUtil.exportExcel(list, "用户充值记录", ImUserRechargeVo.class, response);
    }

    /**
     * 获取用户充值记录详细信息
     *
     * @param id 主键
     */
    @SaCheckPermission("im:userRecharge:query")
    @GetMapping("/{id}")
    public R<ImUserRechargeVo> getInfo(@NotNull(message = "主键不能为空")
                                     @PathVariable Long id) {
        return R.ok(imUserRechargeService.queryById(id));
    }

    /**
     * 新增用户充值记录
     */
    @SaCheckPermission("im:userRecharge:add")
    @Log(title = "用户充值记录", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody ImUserRechargeBo bo) {
        return toAjax(imUserRechargeService.insertByBo(bo));
    }

    /**
     * 修改用户充值记录
     */
    @SaCheckPermission("im:userRecharge:edit")
    @Log(title = "用户充值记录", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody ImUserRechargeBo bo) {
        return toAjax(imUserRechargeService.updateByBo(bo));
    }

    /**
     * 删除用户充值记录
     *
     * @param ids 主键串
     */
    @SaCheckPermission("im:userRecharge:remove")
    @Log(title = "用户充值记录", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空")
                          @PathVariable Long[] ids) {
        return toAjax(imUserRechargeService.deleteWithValidByIds(List.of(ids), true));
    }
}
