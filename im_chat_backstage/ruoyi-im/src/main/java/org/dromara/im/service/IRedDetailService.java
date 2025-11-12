package org.dromara.im.service;

import org.dromara.im.domain.vo.RedDetailVo;
import org.dromara.im.domain.bo.RedDetailBo;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;

import java.util.Collection;
import java.util.List;

/**
 * 红包明细金额Service接口
 *
 * @author Blue
 * @date 2025-08-26
 */
public interface IRedDetailService {

    /**
     * 查询红包明细金额
     *
     * @param id 主键
     * @return 红包明细金额
     */
    RedDetailVo queryById(Long id);

    /**
     * 分页查询红包明细金额列表
     *
     * @param bo        查询条件
     * @param pageQuery 分页参数
     * @return 红包明细金额分页列表
     */
    TableDataInfo<RedDetailVo> queryPageList(RedDetailBo bo, PageQuery pageQuery);

    /**
     * 查询符合条件的红包明细金额列表
     *
     * @param bo 查询条件
     * @return 红包明细金额列表
     */
    List<RedDetailVo> queryList(RedDetailBo bo);

    /**
     * 新增红包明细金额
     *
     * @param bo 红包明细金额
     * @return 是否新增成功
     */
    Boolean insertByBo(RedDetailBo bo);

    /**
     * 修改红包明细金额
     *
     * @param bo 红包明细金额
     * @return 是否修改成功
     */
    Boolean updateByBo(RedDetailBo bo);

    /**
     * 校验并批量删除红包明细金额信息
     *
     * @param ids     待删除的主键集合
     * @param isValid 是否进行有效性校验
     * @return 是否删除成功
     */
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);
}
