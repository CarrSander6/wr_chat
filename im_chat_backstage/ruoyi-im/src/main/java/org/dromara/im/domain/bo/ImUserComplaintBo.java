package org.dromara.im.domain.bo;

import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import org.dromara.im.domain.ImUserComplaint;

/**
 * 用户投诉业务对象 im_user_complaint
 *
 * @author Blue
 * @date 2025-06-24
 */
@Data
@AutoMapper(target = ImUserComplaint.class, reverseConvertGenerate = false)
public class ImUserComplaintBo  {

    /**
     * id
     */
    private Long id;

    /**
     * 用户id
     */
    private Long userId;

    /**
     * 投诉对象类型 1:用户 2:群聊
     */
    private Long targetType;

    /**
     * 投诉对象id
     */
    private Long targetId;

    /**
     * 投诉原因类型 字典: im_complatin_type
     */
    private Integer type;

    /**
     * 图片列表,最多9张
     */
    private String images;

    /**
     * 投诉内容
     */
    private String content;

    /**
     * 状态 1:未处理 2:已处理
     */
    private Integer status;

    /**
     * 处理投诉的管理员id
     */
    private Long resolvedAdminId;

    /**
     * 处理结果类型,字典:im_resolved_type
     */
    private String resolvedType;

    /**
     * 处理结果摘要
     */
    private String resolvedSummary;

    /**
     * 处理时间
     */
    private String resolvedTime;


}
