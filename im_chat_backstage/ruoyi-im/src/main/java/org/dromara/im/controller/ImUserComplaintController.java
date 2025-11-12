package org.dromara.im.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import org.dromara.common.core.domain.R;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.idempotent.annotation.RepeatSubmit;
import org.dromara.common.log.annotation.Log;
import org.dromara.common.log.enums.BusinessType;
import org.dromara.common.mybatis.core.page.PageQuery;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.web.core.BaseController;
import org.dromara.im.domain.bo.ImUserComplaintBo;
import org.dromara.im.domain.vo.ImUserComplaintVo;
import org.dromara.im.service.IImUserComplaintService;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

/**
 * 用户投诉
 *
 * @author Blue
 * @date 2025-06-24
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/im/complaint")
public class ImUserComplaintController extends BaseController {

    private final IImUserComplaintService userComplaintService;

    /**
     * 查询用户投诉列表
     */
    @SaCheckPermission("im:complaint:list")
    @GetMapping("/list")
    public TableDataInfo<ImUserComplaintVo> list(ImUserComplaintBo bo, PageQuery pageQuery) {
        return userComplaintService.queryPageList(bo, pageQuery);
    }


    /**
     * 获取用户投诉详细信息
     *
     * @param id 主键
     */
    @SaCheckPermission("im:complaint:query")
    @GetMapping("/{id}")
    public R<ImUserComplaintVo> getInfo(@NotNull(message = "主键不能为空") @PathVariable Long id) {
        return R.ok(userComplaintService.queryById(id));
    }

    /**
     * 新增用户投诉
     */
    @SaCheckPermission("im:complaint:resolve")
    @Log(title = "处理用户投诉", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PostMapping("/reslove")
    public R<Void> reslove(@Validated(AddGroup.class) @RequestBody ImUserComplaintBo bo) {
        return toAjax(userComplaintService.reslove(bo));
    }

}

