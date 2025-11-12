package com.bx.implatform.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.util.Date;

/**
 * 用户匹配记录
 * 记录用户浏览和操作历史
 */
@Data
@TableName("im_user_match_record")
public class UserMatchRecord {

    /**
     * 主键ID
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 操作用户ID
     */
    private Long userId;

    /**
     * 被浏览用户ID
     */
    private Long targetUserId;

    /**
     * 操作类型: 1-喜欢 2-不喜欢 0-仅浏览
     */
    private Integer actionType;

    /**
     * 创建时间
     */
    private Date createdTime;
}
