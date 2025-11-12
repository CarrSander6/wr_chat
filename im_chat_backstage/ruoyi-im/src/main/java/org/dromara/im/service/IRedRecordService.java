package org.dromara.im.service;

import org.dromara.im.domain.vo.RedRecordVo;
import org.dromara.im.domain.bo.RedRecordBo;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;

import java.util.Collection;
import java.util.List;

/**
 * 发红包记录Service接口
 *
 * @author Blue
 * @date 2025-08-26
 */
public interface IRedRecordService {

    /**
     * 查询发红包记录
     *
     * @param id 主键
     * @return 发红包记录
     */
    RedRecordVo queryById(Long id);

    /**
     * 分页查询发红包记录列表
     *
     * @param bo        查询条件
     * @param pageQuery 分页参数
     * @return 发红包记录分页列表
     */
    TableDataInfo<RedRecordVo> queryPageList(RedRecordBo bo, PageQuery pageQuery);

    /**
     * 查询符合条件的发红包记录列表
     *
     * @param bo 查询条件
     * @return 发红包记录列表
     */
    List<RedRecordVo> queryList(RedRecordBo bo);

    /**
     * 新增发红包记录
     *
     * @param bo 发红包记录
     * @return 是否新增成功
     */
    Boolean insertByBo(RedRecordBo bo);

    /**
     * 修改发红包记录
     *
     * @param bo 发红包记录
     * @return 是否修改成功
     */
    Boolean updateByBo(RedRecordBo bo);

    /**
     * 校验并批量删除发红包记录信息
     *
     * @param ids     待删除的主键集合
     * @param isValid 是否进行有效性校验
     * @return 是否删除成功
     */
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);
}
