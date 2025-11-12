package org.dromara.im.service;

import org.dromara.im.domain.vo.RedRobRecordVo;
import org.dromara.im.domain.bo.RedRobRecordBo;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;

import java.util.Collection;
import java.util.List;

/**
 * 抢红包记录Service接口
 *
 * @author Blue
 * @date 2025-08-26
 */
public interface IRedRobRecordService {

    /**
     * 查询抢红包记录
     *
     * @param id 主键
     * @return 抢红包记录
     */
    RedRobRecordVo queryById(Long id);

    /**
     * 分页查询抢红包记录列表
     *
     * @param bo        查询条件
     * @param pageQuery 分页参数
     * @return 抢红包记录分页列表
     */
    TableDataInfo<RedRobRecordVo> queryPageList(RedRobRecordBo bo, PageQuery pageQuery);

    /**
     * 查询符合条件的抢红包记录列表
     *
     * @param bo 查询条件
     * @return 抢红包记录列表
     */
    List<RedRobRecordVo> queryList(RedRobRecordBo bo);

    /**
     * 新增抢红包记录
     *
     * @param bo 抢红包记录
     * @return 是否新增成功
     */
    Boolean insertByBo(RedRobRecordBo bo);

    /**
     * 修改抢红包记录
     *
     * @param bo 抢红包记录
     * @return 是否修改成功
     */
    Boolean updateByBo(RedRobRecordBo bo);

    /**
     * 校验并批量删除抢红包记录信息
     *
     * @param ids     待删除的主键集合
     * @param isValid 是否进行有效性校验
     * @return 是否删除成功
     */
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);
}
