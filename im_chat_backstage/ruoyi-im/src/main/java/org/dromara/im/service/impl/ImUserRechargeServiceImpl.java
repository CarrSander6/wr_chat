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
import org.dromara.im.domain.bo.ImUserRechargeBo;
import org.dromara.im.domain.vo.ImUserRechargeVo;
import org.dromara.im.domain.ImUserRecharge;
import org.dromara.im.mapper.ImUserRechargeMapper;
import org.dromara.im.service.IImUserRechargeService;

import java.util.List;
import java.util.Map;
import java.util.Collection;

/**
 * 用户充值记录Service业务层处理
 *
 * @author Blue
 * @date 2025-08-27
 */
@RequiredArgsConstructor
@Service
public class ImUserRechargeServiceImpl implements IImUserRechargeService {

    private final ImUserRechargeMapper baseMapper;

    /**
     * 查询用户充值记录
     *
     * @param id 主键
     * @return 用户充值记录
     */
    @Override
    public ImUserRechargeVo queryById(Long id){
        return baseMapper.selectVoById(id);
    }

    /**
     * 分页查询用户充值记录列表
     *
     * @param bo        查询条件
     * @param pageQuery 分页参数
     * @return 用户充值记录分页列表
     */
    @Override
    public TableDataInfo<ImUserRechargeVo> queryPageList(ImUserRechargeBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<ImUserRecharge> lqw = buildQueryWrapper(bo);
        lqw.orderByDesc(ImUserRecharge::getId);
        Page<ImUserRechargeVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    /**
     * 查询符合条件的用户充值记录列表
     *
     * @param bo 查询条件
     * @return 用户充值记录列表
     */
    @Override
    public List<ImUserRechargeVo> queryList(ImUserRechargeBo bo) {
        LambdaQueryWrapper<ImUserRecharge> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<ImUserRecharge> buildQueryWrapper(ImUserRechargeBo bo) {
        Map<String, Object> params = bo.getParams();
        LambdaQueryWrapper<ImUserRecharge> lqw = Wrappers.lambdaQuery();
        lqw.eq(bo.getUserId() != null, ImUserRecharge::getUserId, bo.getUserId());
        lqw.eq(StringUtils.isNotBlank(bo.getOrderSn()), ImUserRecharge::getOrderSn, bo.getOrderSn());
        lqw.eq(bo.getAmount() != null, ImUserRecharge::getAmount, bo.getAmount());
        lqw.eq(bo.getUsdtAmount() != null, ImUserRecharge::getUsdtAmount, bo.getUsdtAmount());
        lqw.eq(StringUtils.isNotBlank(bo.getTxHash()), ImUserRecharge::getTxHash, bo.getTxHash());
        lqw.eq(bo.getStatus() != null, ImUserRecharge::getStatus, bo.getStatus());
        lqw.eq(StringUtils.isNotBlank(bo.getFromAddress()), ImUserRecharge::getFromAddress, bo.getFromAddress());
        lqw.eq(StringUtils.isNotBlank(bo.getToAddress()), ImUserRecharge::getToAddress, bo.getToAddress());
        lqw.eq(StringUtils.isNotBlank(bo.getNotifyData()), ImUserRecharge::getNotifyData, bo.getNotifyData());
        lqw.eq(StringUtils.isNotBlank(bo.getImg()), ImUserRecharge::getImg, bo.getImg());
        return lqw;
    }

    /**
     * 新增用户充值记录
     *
     * @param bo 用户充值记录
     * @return 是否新增成功
     */
    @Override
    public Boolean insertByBo(ImUserRechargeBo bo) {
        ImUserRecharge add = MapstructUtils.convert(bo, ImUserRecharge.class);
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setId(add.getId());
        }
        return flag;
    }

    /**
     * 修改用户充值记录
     *
     * @param bo 用户充值记录
     * @return 是否修改成功
     */
    @Override
    public Boolean updateByBo(ImUserRechargeBo bo) {
        ImUserRecharge update = MapstructUtils.convert(bo, ImUserRecharge.class);
        validEntityBeforeSave(update);
        return baseMapper.updateById(update) > 0;
    }

    /**
     * 保存前的数据校验
     */
    private void validEntityBeforeSave(ImUserRecharge entity){
        //TODO 做一些数据校验,如唯一约束
    }

    /**
     * 校验并批量删除用户充值记录信息
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
