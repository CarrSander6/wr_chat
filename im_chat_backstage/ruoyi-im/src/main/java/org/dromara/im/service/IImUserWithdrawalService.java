package org.dromara.im.service;

import org.dromara.im.domain.vo.ImUserWithdrawalVo;
import org.dromara.im.domain.bo.ImUserWithdrawalBo;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;

import java.util.Collection;
import java.util.List;

/**
 * 用户提现记录Service接口
 *
 * @author Blue
 * @date 2025-08-27
 */
public interface IImUserWithdrawalService {

    /**
     * 查询用户提现记录
     *
     * @param id 主键
     * @return 用户提现记录
     */
    ImUserWithdrawalVo queryById(Long id);

    /**
     * 分页查询用户提现记录列表
     *
     * @param bo        查询条件
     * @param pageQuery 分页参数
     * @return 用户提现记录分页列表
     */
    TableDataInfo<ImUserWithdrawalVo> queryPageList(ImUserWithdrawalBo bo, PageQuery pageQuery);

    /**
     * 查询符合条件的用户提现记录列表
     *
     * @param bo 查询条件
     * @return 用户提现记录列表
     */
    List<ImUserWithdrawalVo> queryList(ImUserWithdrawalBo bo);

    /**
     * 新增用户提现记录
     *
     * @param bo 用户提现记录
     * @return 是否新增成功
     */
    Boolean insertByBo(ImUserWithdrawalBo bo);

    /**
     * 修改用户提现记录
     *
     * @param bo 用户提现记录
     * @return 是否修改成功
     */
    Boolean updateByBo(ImUserWithdrawalBo bo);

    /**
     * 校验并批量删除用户提现记录信息
     *
     * @param ids     待删除的主键集合
     * @param isValid 是否进行有效性校验
     * @return 是否删除成功
     */
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);
}
