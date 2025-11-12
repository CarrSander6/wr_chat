package org.dromara.im.service;

import org.dromara.common.mybatis.core.page.PageQuery;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.im.domain.bo.ImUserComplaintBo;
import org.dromara.im.domain.vo.ImUserComplaintVo;

/**
 * 用户投诉Service接口
 *
 * @author Blue
 * @date 2025-06-24
 */
public interface IImUserComplaintService {

    /**
     * 查询用户投诉
     *
     * @param id 主键
     * @return 用户投诉
     */
    ImUserComplaintVo queryById(Long id);

    /**
     * 分页查询用户投诉列表
     *
     * @param bo        查询条件
     * @param pageQuery 分页参数
     * @return 用户投诉分页列表
     */
    TableDataInfo<ImUserComplaintVo> queryPageList(ImUserComplaintBo bo, PageQuery pageQuery);

    /**
     * 处理用户投诉
     * @param bo
     */
    Boolean reslove(ImUserComplaintBo bo);

}
