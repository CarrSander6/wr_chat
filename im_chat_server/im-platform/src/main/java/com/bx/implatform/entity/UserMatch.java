package com.bx.implatform.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.util.Date;

/**
 * 用户匹配表
 * 记录成功匹配的用户对
 */
@Data
@TableName("im_user_match")
public class UserMatch {

    /**
     * 主键ID
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 用户1的ID
     */
    private Long user1Id;

    /**
     * 用户2的ID
     */
    private Long user2Id;

    /**
     * 匹配状态: 1-已匹配 2-已取消
     */
    private Integer status;

    /**
     * 匹配时间
     */
    private Date matchTime;

    /**
     * 创建时间
     */
    private Date createdTime;
}
