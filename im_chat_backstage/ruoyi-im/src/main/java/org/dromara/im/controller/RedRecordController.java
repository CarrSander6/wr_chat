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
import org.dromara.im.domain.vo.RedRecordVo;
import org.dromara.im.domain.bo.RedRecordBo;
import org.dromara.im.service.IRedRecordService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

/**
 * 发红包记录
 *
 * @author Blue
 * @date 2025-08-26
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/im/record")
public class RedRecordController extends BaseController {

    private final IRedRecordService redRecordService;

    /**
     * 查询发红包记录列表
     */
    @SaCheckPermission("im:record:list")
    @GetMapping("/list")
    public TableDataInfo<RedRecordVo> list(RedRecordBo bo, PageQuery pageQuery) {
        return redRecordService.queryPageList(bo, pageQuery);
    }

    /**
     * 导出发红包记录列表
     */
    @SaCheckPermission("im:record:export")
    @Log(title = "发红包记录", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(RedRecordBo bo, HttpServletResponse response) {
        List<RedRecordVo> list = redRecordService.queryList(bo);
        ExcelUtil.exportExcel(list, "发红包记录", RedRecordVo.class, response);
    }

    /**
     * 获取发红包记录详细信息
     *
     * @param id 主键
     */
    @SaCheckPermission("im:record:query")
    @GetMapping("/{id}")
    public R<RedRecordVo> getInfo(@NotNull(message = "主键不能为空")
                                     @PathVariable Long id) {
        return R.ok(redRecordService.queryById(id));
    }

    /**
     * 新增发红包记录
     */
    @SaCheckPermission("im:record:add")
    @Log(title = "发红包记录", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody RedRecordBo bo) {
        return toAjax(redRecordService.insertByBo(bo));
    }

    /**
     * 修改发红包记录
     */
    @SaCheckPermission("im:record:edit")
    @Log(title = "发红包记录", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody RedRecordBo bo) {
        return toAjax(redRecordService.updateByBo(bo));
    }

    /**
     * 删除发红包记录
     *
     * @param ids 主键串
     */
    @SaCheckPermission("im:record:remove")
    @Log(title = "发红包记录", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空")
                          @PathVariable Long[] ids) {
        return toAjax(redRecordService.deleteWithValidByIds(List.of(ids), true));
    }
}
