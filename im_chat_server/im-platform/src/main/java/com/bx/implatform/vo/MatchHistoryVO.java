package com.bx.implatform.vo;

import lombok.Data;

import java.util.Date;

/**
 * 匹配历史VO
 */
@Data
public class MatchHistoryVO {

    /**
     * 记录ID
     */
    private Long id;

    /**
     * 目标用户ID
     */
    private Long targetUserId;

    /**
     * 目标用户昵称
     */
    private String nickName;

    /**
     * 目标用户头像
     */
    private String headImage;

    /**
     * 操作类型: 1-喜欢 2-不喜欢
     */
    private Integer actionType;

    /**
     * 创建时间
     */
    private Date createdTime;
}
