package org.dromara.im.service.impl;

import org.dromara.common.core.utils.MapstructUtils;
import org.dromara.common.core.utils.StringUtils;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.dromara.im.domain.bo.RedDetailBo;
import org.dromara.im.domain.vo.RedDetailVo;
import org.dromara.im.domain.RedDetail;
import org.dromara.im.mapper.RedDetailMapper;
import org.dromara.im.service.IRedDetailService;

import java.util.List;
import java.util.Map;
import java.util.Collection;

/**
 * 红包明细金额Service业务层处理
 *
 * @author Blue
 * @date 2025-08-26
 */
@RequiredArgsConstructor
@Service
public class RedDetailServiceImpl implements IRedDetailService {

    private final RedDetailMapper baseMapper;

    /**
     * 查询红包明细金额
     *
     * @param id 主键
     * @return 红包明细金额
     */
    @Override
    public RedDetailVo queryById(Long id){
        return baseMapper.selectVoById(id);
    }

    /**
     * 分页查询红包明细金额列表
     *
     * @param bo        查询条件
     * @param pageQuery 分页参数
     * @return 红包明细金额分页列表
     */
    @Override
    public TableDataInfo<RedDetailVo> queryPageList(RedDetailBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<RedDetail> lqw = buildQueryWrapper(bo);
        Page<RedDetailVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    /**
     * 查询符合条件的红包明细金额列表
     *
     * @param bo 查询条件
     * @return 红包明细金额列表
     */
    @Override
    public List<RedDetailVo> queryList(RedDetailBo bo) {
        LambdaQueryWrapper<RedDetail> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<RedDetail> buildQueryWrapper(RedDetailBo bo) {
        Map<String, Object> params = bo.getParams();
        LambdaQueryWrapper<RedDetail> lqw = Wrappers.lambdaQuery();
        lqw.eq(bo.getRecordId() != null, RedDetail::getRecordId, bo.getRecordId());
        lqw.eq(bo.getAmount() != null, RedDetail::getAmount, bo.getAmount());
        lqw.eq(bo.getIsActive() != null, RedDetail::getIsActive, bo.getIsActive());
        return lqw;
    }

    /**
     * 新增红包明细金额
     *
     * @param bo 红包明细金额
     * @return 是否新增成功
     */
    @Override
    public Boolean insertByBo(RedDetailBo bo) {
        RedDetail add = MapstructUtils.convert(bo, RedDetail.class);
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setId(add.getId());
        }
        return flag;
    }

    /**
     * 修改红包明细金额
     *
     * @param bo 红包明细金额
     * @return 是否修改成功
     */
    @Override
    public Boolean updateByBo(RedDetailBo bo) {
        RedDetail update = MapstructUtils.convert(bo, RedDetail.class);
        validEntityBeforeSave(update);
        return baseMapper.updateById(update) > 0;
    }

    /**
     * 保存前的数据校验
     */
    private void validEntityBeforeSave(RedDetail entity){
        //TODO 做一些数据校验,如唯一约束
    }

    /**
     * 校验并批量删除红包明细金额信息
     *
     * @param ids     待删除的主键集合
     * @param isValid 是否进行有效性校验
     * @return 是否删除成功
     */
    @Override
    public Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid) {
        if(isValid){
            //TODO 做一些业务上的校验,判断是否需要校验
        }
        return baseMapper.deleteByIds(ids) > 0;
    }
}
