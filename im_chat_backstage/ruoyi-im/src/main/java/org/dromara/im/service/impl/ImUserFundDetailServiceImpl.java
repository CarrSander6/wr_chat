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
import org.dromara.im.domain.bo.ImUserFundDetailBo;
import org.dromara.im.domain.vo.ImUserFundDetailVo;
import org.dromara.im.domain.ImUserFundDetail;
import org.dromara.im.mapper.ImUserFundDetailMapper;
import org.dromara.im.service.IImUserFundDetailService;

import java.util.List;
import java.util.Map;
import java.util.Collection;

/**
 * 用户资产明细Service业务层处理
 *
 * @author Blue
 * @date 2025-08-26
 */
@RequiredArgsConstructor
@Service
public class ImUserFundDetailServiceImpl implements IImUserFundDetailService {

    private final ImUserFundDetailMapper baseMapper;

    /**
     * 查询用户资产明细
     *
     * @param id 主键
     * @return 用户资产明细
     */
    @Override
    public ImUserFundDetailVo queryById(Long id){
        return baseMapper.selectVoById(id);
    }

    /**
     * 分页查询用户资产明细列表
     *
     * @param bo        查询条件
     * @param pageQuery 分页参数
     * @return 用户资产明细分页列表
     */
    @Override
    public TableDataInfo<ImUserFundDetailVo> queryPageList(ImUserFundDetailBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<ImUserFundDetail> lqw = buildQueryWrapper(bo);
        lqw.orderByDesc(ImUserFundDetail::getId);
        Page<ImUserFundDetailVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    /**
     * 查询符合条件的用户资产明细列表
     *
     * @param bo 查询条件
     * @return 用户资产明细列表
     */
    @Override
    public List<ImUserFundDetailVo> queryList(ImUserFundDetailBo bo) {
        LambdaQueryWrapper<ImUserFundDetail> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<ImUserFundDetail> buildQueryWrapper(ImUserFundDetailBo bo) {
        Map<String, Object> params = bo.getParams();
        LambdaQueryWrapper<ImUserFundDetail> lqw = Wrappers.lambdaQuery();
        lqw.eq(bo.getUserId() != null, ImUserFundDetail::getUserId, bo.getUserId());
        lqw.eq(StringUtils.isNotBlank(bo.getDescribes()), ImUserFundDetail::getDescribes, bo.getDescribes());
        lqw.eq(bo.getType() != null, ImUserFundDetail::getType, bo.getType());
        lqw.eq(bo.getTransferFlag() != null, ImUserFundDetail::getTransferFlag, bo.getTransferFlag());
        lqw.eq(StringUtils.isNotBlank(bo.getOrderNo()), ImUserFundDetail::getOrderNo, bo.getOrderNo());
        lqw.eq(bo.getPointBefore() != null, ImUserFundDetail::getPointBefore, bo.getPointBefore());
        lqw.eq(bo.getAmount() != null, ImUserFundDetail::getAmount, bo.getAmount());
        lqw.eq(bo.getPointAfter() != null, ImUserFundDetail::getPointAfter, bo.getPointAfter());
        lqw.eq(StringUtils.isNotBlank(bo.getTxHash()), ImUserFundDetail::getTxHash, bo.getTxHash());
        lqw.eq(bo.getTxTime() != null, ImUserFundDetail::getTxTime, bo.getTxTime());
        return lqw;
    }

    /**
     * 新增用户资产明细
     *
     * @param bo 用户资产明细
     * @return 是否新增成功
     */
    @Override
    public Boolean insertByBo(ImUserFundDetailBo bo) {
        ImUserFundDetail add = MapstructUtils.convert(bo, ImUserFundDetail.class);
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setId(add.getId());
        }
        return flag;
    }

    /**
     * 修改用户资产明细
     *
     * @param bo 用户资产明细
     * @return 是否修改成功
     */
    @Override
    public Boolean updateByBo(ImUserFundDetailBo bo) {
        ImUserFundDetail update = MapstructUtils.convert(bo, ImUserFundDetail.class);
        validEntityBeforeSave(update);
        return baseMapper.updateById(update) > 0;
    }

    /**
     * 保存前的数据校验
     */
    private void validEntityBeforeSave(ImUserFundDetail entity){
        //TODO 做一些数据校验,如唯一约束
    }

    /**
     * 校验并批量删除用户资产明细信息
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
