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
import org.dromara.im.domain.bo.RedRecordBo;
import org.dromara.im.domain.vo.RedRecordVo;
import org.dromara.im.domain.RedRecord;
import org.dromara.im.mapper.RedRecordMapper;
import org.dromara.im.service.IRedRecordService;

import java.util.List;
import java.util.Map;
import java.util.Collection;

/**
 * 发红包记录Service业务层处理
 *
 * @author Blue
 * @date 2025-08-26
 */
@RequiredArgsConstructor
@Service
public class RedRecordServiceImpl implements IRedRecordService {

    private final RedRecordMapper baseMapper;

    /**
     * 查询发红包记录
     *
     * @param id 主键
     * @return 发红包记录
     */
    @Override
    public RedRecordVo queryById(Long id){
        return baseMapper.selectVoById(id);
    }

    /**
     * 分页查询发红包记录列表
     *
     * @param bo        查询条件
     * @param pageQuery 分页参数
     * @return 发红包记录分页列表
     */
    @Override
    public TableDataInfo<RedRecordVo> queryPageList(RedRecordBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<RedRecord> lqw = buildQueryWrapper(bo);
        Page<RedRecordVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    /**
     * 查询符合条件的发红包记录列表
     *
     * @param bo 查询条件
     * @return 发红包记录列表
     */
    @Override
    public List<RedRecordVo> queryList(RedRecordBo bo) {
        LambdaQueryWrapper<RedRecord> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<RedRecord> buildQueryWrapper(RedRecordBo bo) {
        Map<String, Object> params = bo.getParams();
        LambdaQueryWrapper<RedRecord> lqw = Wrappers.lambdaQuery();
        lqw.eq(bo.getUserId() != null, RedRecord::getUserId, bo.getUserId());
        lqw.eq(StringUtils.isNotBlank(bo.getRedPacket()), RedRecord::getRedPacket, bo.getRedPacket());
        lqw.eq(bo.getTotal() != null, RedRecord::getTotal, bo.getTotal());
        lqw.eq(bo.getAmount() != null, RedRecord::getAmount, bo.getAmount());
        lqw.eq(bo.getIsActive() != null, RedRecord::getIsActive, bo.getIsActive());
        return lqw;
    }

    /**
     * 新增发红包记录
     *
     * @param bo 发红包记录
     * @return 是否新增成功
     */
    @Override
    public Boolean insertByBo(RedRecordBo bo) {
        RedRecord add = MapstructUtils.convert(bo, RedRecord.class);
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setId(add.getId());
        }
        return flag;
    }

    /**
     * 修改发红包记录
     *
     * @param bo 发红包记录
     * @return 是否修改成功
     */
    @Override
    public Boolean updateByBo(RedRecordBo bo) {
        RedRecord update = MapstructUtils.convert(bo, RedRecord.class);
        validEntityBeforeSave(update);
        return baseMapper.updateById(update) > 0;
    }

    /**
     * 保存前的数据校验
     */
    private void validEntityBeforeSave(RedRecord entity){
        //TODO 做一些数据校验,如唯一约束
    }

    /**
     * 校验并批量删除发红包记录信息
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
