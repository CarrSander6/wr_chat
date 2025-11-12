package org.dromara.im.service.impl;

import com.baomidou.dynamic.datasource.annotation.DS;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.RequiredArgsConstructor;
import org.dromara.common.mybatis.core.page.PageQuery;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.satoken.utils.LoginHelper;
import org.dromara.im.constant.ImConstant;
import org.dromara.im.domain.ImUserComplaint;
import org.dromara.im.domain.bo.ImUserComplaintBo;
import org.dromara.im.domain.vo.ImUserComplaintVo;
import org.dromara.im.enums.ImComplaintStatus;
import org.dromara.im.mapper.ImUserComplaintMapper;
import org.dromara.im.service.IImUserComplaintService;
import org.springframework.stereotype.Service;

import java.util.Date;

/**
 * 用户投诉Service业务层处理
 *
 * @author Blue
 * @date 2025-06-24
 */
@DS(ImConstant.DS_IM_PLATFORM)
@RequiredArgsConstructor
@Service
public class ImUserComplaintServiceImpl implements IImUserComplaintService {

    private final ImUserComplaintMapper baseMapper;

    /**
     * 查询用户投诉
     *
     * @param id 主键
     * @return 用户投诉
     */
    @Override
    public ImUserComplaintVo queryById(Long id) {
        return baseMapper.selectVoById(id);
    }

    /**
     * 分页查询用户投诉列表
     *
     * @param bo        查询条件
     * @param pageQuery 分页参数
     * @return 用户投诉分页列表
     */
    @Override
    public TableDataInfo<ImUserComplaintVo> queryPageList(ImUserComplaintBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<ImUserComplaint> wrapper = buildQueryWrapper(bo);
        Page<ImUserComplaintVo> result = baseMapper.selectVoPage(pageQuery.build(), wrapper);
        return TableDataInfo.build(result);
    }

    @Override
    public Boolean reslove(ImUserComplaintBo bo) {
        LambdaUpdateWrapper<ImUserComplaint> wrapper = Wrappers.lambdaUpdate();
        wrapper.eq(ImUserComplaint::getId, bo.getId());
        wrapper.set(ImUserComplaint::getStatus, ImComplaintStatus.HANDLED.getValue());
        wrapper.set(ImUserComplaint::getResolvedAdminId, LoginHelper.getUserId());
        wrapper.set(ImUserComplaint::getResolvedType, bo.getResolvedType());
        wrapper.set(ImUserComplaint::getResolvedSummary, bo.getResolvedSummary());
        wrapper.set(ImUserComplaint::getResolvedTime, new Date());
        wrapper.orderByDesc(ImUserComplaint::getId);
        return baseMapper.update(wrapper) > 0;
    }

    private LambdaQueryWrapper<ImUserComplaint> buildQueryWrapper(ImUserComplaintBo bo) {
        LambdaQueryWrapper<ImUserComplaint> wrapper = Wrappers.lambdaQuery();
        wrapper.eq(bo.getUserId() != null, ImUserComplaint::getUserId, bo.getUserId());
        wrapper.eq(bo.getTargetType() != null, ImUserComplaint::getTargetType, bo.getTargetType());
        wrapper.eq(bo.getTargetId() != null, ImUserComplaint::getTargetId, bo.getTargetId());
        wrapper.eq(bo.getType() != null, ImUserComplaint::getType, bo.getType());
        wrapper.eq(bo.getStatus() != null, ImUserComplaint::getStatus, bo.getStatus());
        wrapper.eq(bo.getResolvedAdminId() != null, ImUserComplaint::getResolvedAdminId, bo.getResolvedAdminId());
        wrapper.eq(bo.getResolvedType() != null, ImUserComplaint::getResolvedType, bo.getResolvedType());
        return wrapper;
    }

}
