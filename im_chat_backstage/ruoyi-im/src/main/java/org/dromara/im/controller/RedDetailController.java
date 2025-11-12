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
import org.dromara.im.domain.vo.RedDetailVo;
import org.dromara.im.domain.bo.RedDetailBo;
import org.dromara.im.service.IRedDetailService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

/**
 * 红包明细金额
 *
 * @author Blue
 * @date 2025-08-26
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/im/detail")
public class RedDetailController extends BaseController {

    private final IRedDetailService redDetailService;

    /**
     * 查询红包明细金额列表
     */
    @SaCheckPermission("im:detail:list")
    @GetMapping("/list")
    public TableDataInfo<RedDetailVo> list(RedDetailBo bo, PageQuery pageQuery) {
        return redDetailService.queryPageList(bo, pageQuery);
    }

    /**
     * 导出红包明细金额列表
     */
    @SaCheckPermission("im:detail:export")
    @Log(title = "红包明细金额", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(RedDetailBo bo, HttpServletResponse response) {
        List<RedDetailVo> list = redDetailService.queryList(bo);
        ExcelUtil.exportExcel(list, "红包明细金额", RedDetailVo.class, response);
    }

    /**
     * 获取红包明细金额详细信息
     *
     * @param id 主键
     */
    @SaCheckPermission("im:detail:query")
    @GetMapping("/{id}")
    public R<RedDetailVo> getInfo(@NotNull(message = "主键不能为空")
                                     @PathVariable Long id) {
        return R.ok(redDetailService.queryById(id));
    }

    /**
     * 新增红包明细金额
     */
    @SaCheckPermission("im:detail:add")
    @Log(title = "红包明细金额", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody RedDetailBo bo) {
        return toAjax(redDetailService.insertByBo(bo));
    }

    /**
     * 修改红包明细金额
     */
    @SaCheckPermission("im:detail:edit")
    @Log(title = "红包明细金额", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody RedDetailBo bo) {
        return toAjax(redDetailService.updateByBo(bo));
    }

    /**
     * 删除红包明细金额
     *
     * @param ids 主键串
     */
    @SaCheckPermission("im:detail:remove")
    @Log(title = "红包明细金额", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空")
                          @PathVariable Long[] ids) {
        return toAjax(redDetailService.deleteWithValidByIds(List.of(ids), true));
    }
}
