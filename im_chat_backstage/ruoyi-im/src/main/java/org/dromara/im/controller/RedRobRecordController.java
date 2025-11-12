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
import org.dromara.im.domain.vo.RedRobRecordVo;
import org.dromara.im.domain.bo.RedRobRecordBo;
import org.dromara.im.service.IRedRobRecordService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

/**
 * 抢红包记录
 *
 * @author Blue
 * @date 2025-08-26
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/im/robRecord")
public class RedRobRecordController extends BaseController {

    private final IRedRobRecordService redRobRecordService;

    /**
     * 查询抢红包记录列表
     */
    @SaCheckPermission("im:robRecord:list")
    @GetMapping("/list")
    public TableDataInfo<RedRobRecordVo> list(RedRobRecordBo bo, PageQuery pageQuery) {
        return redRobRecordService.queryPageList(bo, pageQuery);
    }

    /**
     * 导出抢红包记录列表
     */
    @SaCheckPermission("im:robRecord:export")
    @Log(title = "抢红包记录", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(RedRobRecordBo bo, HttpServletResponse response) {
        List<RedRobRecordVo> list = redRobRecordService.queryList(bo);
        ExcelUtil.exportExcel(list, "抢红包记录", RedRobRecordVo.class, response);
    }

    /**
     * 获取抢红包记录详细信息
     *
     * @param id 主键
     */
    @SaCheckPermission("im:robRecord:query")
    @GetMapping("/{id}")
    public R<RedRobRecordVo> getInfo(@NotNull(message = "主键不能为空")
                                     @PathVariable Long id) {
        return R.ok(redRobRecordService.queryById(id));
    }

    /**
     * 新增抢红包记录
     */
    @SaCheckPermission("im:robRecord:add")
    @Log(title = "抢红包记录", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody RedRobRecordBo bo) {
        return toAjax(redRobRecordService.insertByBo(bo));
    }

    /**
     * 修改抢红包记录
     */
    @SaCheckPermission("im:robRecord:edit")
    @Log(title = "抢红包记录", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody RedRobRecordBo bo) {
        return toAjax(redRobRecordService.updateByBo(bo));
    }

    /**
     * 删除抢红包记录
     *
     * @param ids 主键串
     */
    @SaCheckPermission("im:robRecord:remove")
    @Log(title = "抢红包记录", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空")
                          @PathVariable Long[] ids) {
        return toAjax(redRobRecordService.deleteWithValidByIds(List.of(ids), true));
    }
}
