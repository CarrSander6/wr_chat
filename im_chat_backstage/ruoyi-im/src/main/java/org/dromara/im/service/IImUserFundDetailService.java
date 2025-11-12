package org.dromara.im.service;

import org.dromara.im.domain.vo.ImUserFundDetailVo;
import org.dromara.im.domain.bo.ImUserFundDetailBo;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;

import java.util.Collection;
import java.util.List;

/**
 * 用户资产明细Service接口
 *
 * @author Blue
 * @date 2025-08-26
 */
public interface IImUserFundDetailService {

    /**
     * 查询用户资产明细
     *
     * @param id 主键
     * @return 用户资产明细
     */
    ImUserFundDetailVo queryById(Long id);

    /**
     * 分页查询用户资产明细列表
     *
     * @param bo        查询条件
     * @param pageQuery 分页参数
     * @return 用户资产明细分页列表
     */
    TableDataInfo<ImUserFundDetailVo> queryPageList(ImUserFundDetailBo bo, PageQuery pageQuery);

    /**
     * 查询符合条件的用户资产明细列表
     *
     * @param bo 查询条件
     * @return 用户资产明细列表
     */
    List<ImUserFundDetailVo> queryList(ImUserFundDetailBo bo);

    /**
     * 新增用户资产明细
     *
     * @param bo 用户资产明细
     * @return 是否新增成功
     */
    Boolean insertByBo(ImUserFundDetailBo bo);

    /**
     * 修改用户资产明细
     *
     * @param bo 用户资产明细
     * @return 是否修改成功
     */
    Boolean updateByBo(ImUserFundDetailBo bo);

    /**
     * 校验并批量删除用户资产明细信息
     *
     * @param ids     待删除的主键集合
     * @param isValid 是否进行有效性校验
     * @return 是否删除成功
     */
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);
}
