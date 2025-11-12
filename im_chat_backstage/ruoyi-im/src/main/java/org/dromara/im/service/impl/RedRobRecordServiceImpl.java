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
import org.dromara.im.domain.bo.RedRobRecordBo;
import org.dromara.im.domain.vo.RedRobRecordVo;
import org.dromara.im.domain.RedRobRecord;
import org.dromara.im.mapper.RedRobRecordMapper;
import org.dromara.im.service.IRedRobRecordService;

import java.util.List;
import java.util.Map;
import java.util.Collection;

/**
 * 抢红包记录Service业务层处理
 *
 * @author Blue
 * @date 2025-08-26
 */
@RequiredArgsConstructor
@Service
public class RedRobRecordServiceImpl implements IRedRobRecordService {

    private final RedRobRecordMapper baseMapper;

    /**
     * 查询抢红包记录
     *
     * @param id 主键
     * @return 抢红包记录
     */
    @Override
    public RedRobRecordVo queryById(Long id){
        return baseMapper.selectVoById(id);
    }

    /**
     * 分页查询抢红包记录列表
     *
     * @param bo        查询条件
     * @param pageQuery 分页参数
     * @return 抢红包记录分页列表
     */
    @Override
    public TableDataInfo<RedRobRecordVo> queryPageList(RedRobRecordBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<RedRobRecord> lqw = buildQueryWrapper(bo);
        Page<RedRobRecordVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    /**
     * 查询符合条件的抢红包记录列表
     *
     * @param bo 查询条件
     * @return 抢红包记录列表
     */
    @Override
    public List<RedRobRecordVo> queryList(RedRobRecordBo bo) {
        LambdaQueryWrapper<RedRobRecord> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<RedRobRecord> buildQueryWrapper(RedRobRecordBo bo) {
        Map<String, Object> params = bo.getParams();
        LambdaQueryWrapper<RedRobRecord> lqw = Wrappers.lambdaQuery();
        lqw.eq(bo.getUserId() != null, RedRobRecord::getUserId, bo.getUserId());
        lqw.eq(StringUtils.isNotBlank(bo.getRedPacket()), RedRobRecord::getRedPacket, bo.getRedPacket());
        lqw.eq(bo.getAmount() != null, RedRobRecord::getAmount, bo.getAmount());
        lqw.eq(bo.getRobTime() != null, RedRobRecord::getRobTime, bo.getRobTime());
        return lqw;
    }

    /**
     * 新增抢红包记录
     *
     * @param bo 抢红包记录
     * @return 是否新增成功
     */
    @Override
    public Boolean insertByBo(RedRobRecordBo bo) {
        RedRobRecord add = MapstructUtils.convert(bo, RedRobRecord.class);
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setId(add.getId());
        }
        return flag;
    }

    /**
     * 修改抢红包记录
     *
     * @param bo 抢红包记录
     * @return 是否修改成功
     */
    @Override
    public Boolean updateByBo(RedRobRecordBo bo) {
        RedRobRecord update = MapstructUtils.convert(bo, RedRobRecord.class);
        validEntityBeforeSave(update);
        return baseMapper.updateById(update) > 0;
    }

    /**
     * 保存前的数据校验
     */
    private void validEntityBeforeSave(RedRobRecord entity){
        //TODO 做一些数据校验,如唯一约束
    }

    /**
     * 校验并批量删除抢红包记录信息
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
