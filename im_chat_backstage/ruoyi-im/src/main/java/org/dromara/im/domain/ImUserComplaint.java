package org.dromara.im.domain;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fhs.core.trans.vo.TransPojo;
import lombok.Data;

import java.util.Date;

/**
 * 用户投诉对象 im_user_complaint
 *
 * @author Blue
 * @date 2025-06-24
 */
@Data
@TableName("im_user_complaint")
public class ImUserComplaint implements TransPojo {

    /**
     * id
     */
    @TableId(value = "id")
    private Long id;

    /**
     * 用户id
     */
    private Long userId;

    /**
     * 投诉对象类型 1:用户 2:群聊
     */
    private Integer targetType;

    /**
     * 投诉对象id
     */
    private Long targetId;

    /**
     * 投诉对象名
     */
    private String targetName;

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

    /**
     * 创建时间
     */
    private Date createTime;
}
