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
import org.dromara.im.domain.bo.ImUserWithdrawalBo;
import org.dromara.im.domain.vo.ImUserWithdrawalVo;
import org.dromara.im.domain.ImUserWithdrawal;
import org.dromara.im.mapper.ImUserWithdrawalMapper;
import org.dromara.im.service.IImUserWithdrawalService;

import java.util.List;
import java.util.Map;
import java.util.Collection;

/**
 * 用户提现记录Service业务层处理
 *
 * @author Blue
 * @date 2025-08-27
 */
@RequiredArgsConstructor
@Service
public class ImUserWithdrawalServiceImpl implements IImUserWithdrawalService {

    private final ImUserWithdrawalMapper baseMapper;

    /**
     * 查询用户提现记录
     *
     * @param id 主键
     * @return 用户提现记录
     */
    @Override
    public ImUserWithdrawalVo queryById(Long id){
        return baseMapper.selectVoById(id);
    }

    /**
     * 分页查询用户提现记录列表
     *
     * @param bo        查询条件
     * @param pageQuery 分页参数
     * @return 用户提现记录分页列表
     */
    @Override
    public TableDataInfo<ImUserWithdrawalVo> queryPageList(ImUserWithdrawalBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<ImUserWithdrawal> lqw = buildQueryWrapper(bo);
        lqw.orderByDesc(ImUserWithdrawal::getId);
        Page<ImUserWithdrawalVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    /**
     * 查询符合条件的用户提现记录列表
     *
     * @param bo 查询条件
     * @return 用户提现记录列表
     */
    @Override
    public List<ImUserWithdrawalVo> queryList(ImUserWithdrawalBo bo) {
        LambdaQueryWrapper<ImUserWithdrawal> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<ImUserWithdrawal> buildQueryWrapper(ImUserWithdrawalBo bo) {
        Map<String, Object> params = bo.getParams();
        LambdaQueryWrapper<ImUserWithdrawal> lqw = Wrappers.lambdaQuery();
        lqw.eq(bo.getUserId() != null, ImUserWithdrawal::getUserId, bo.getUserId());
        lqw.eq(bo.getType() != null, ImUserWithdrawal::getType, bo.getType());
        lqw.eq(StringUtils.isNotBlank(bo.getOrderSn()), ImUserWithdrawal::getOrderSn, bo.getOrderSn());
        lqw.eq(bo.getAmount() != null, ImUserWithdrawal::getAmount, bo.getAmount());
        lqw.eq(bo.getFeeAmount() != null, ImUserWithdrawal::getFeeAmount, bo.getFeeAmount());
        lqw.eq(bo.getActualAmount() != null, ImUserWithdrawal::getActualAmount, bo.getActualAmount());
        lqw.eq(StringUtils.isNotBlank(bo.getTxHash()), ImUserWithdrawal::getTxHash, bo.getTxHash());
        lqw.eq(bo.getStatus() != null, ImUserWithdrawal::getStatus, bo.getStatus());
        lqw.eq(StringUtils.isNotBlank(bo.getFromAddress()), ImUserWithdrawal::getFromAddress, bo.getFromAddress());
        lqw.eq(StringUtils.isNotBlank(bo.getNotifyData()), ImUserWithdrawal::getNotifyData, bo.getNotifyData());
        return lqw;
    }

    /**
     * 新增用户提现记录
     *
     * @param bo 用户提现记录
     * @return 是否新增成功
     */
    @Override
    public Boolean insertByBo(ImUserWithdrawalBo bo) {
        ImUserWithdrawal add = MapstructUtils.convert(bo, ImUserWithdrawal.class);
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setId(add.getId());
        }
        return flag;
    }

    /**
     * 修改用户提现记录
     *
     * @param bo 用户提现记录
     * @return 是否修改成功
     */
    @Override
    public Boolean updateByBo(ImUserWithdrawalBo bo) {
        ImUserWithdrawal update = MapstructUtils.convert(bo, ImUserWithdrawal.class);
        validEntityBeforeSave(update);
        return baseMapper.updateById(update) > 0;
    }

    /**
     * 保存前的数据校验
     */
    private void validEntityBeforeSave(ImUserWithdrawal entity){
        //TODO 做一些数据校验,如唯一约束
    }

    /**
     * 校验并批量删除用户提现记录信息
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
