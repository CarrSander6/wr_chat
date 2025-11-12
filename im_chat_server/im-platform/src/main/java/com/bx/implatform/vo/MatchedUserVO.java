package com.bx.implatform.vo;

import lombok.Data;

import java.util.Date;

/**
 * 匹配用户VO
 */
@Data
public class MatchedUserVO {

    /**
     * 匹配ID
     */
    private Long matchId;

    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 用户昵称
     */
    private String nickName;

    /**
     * 用户头像
     */
    private String headImage;

    /**
     * 个性签名
     */
    private String signature;

    /**
     * 性别
     */
    private Integer sex;

    /**
     * 匹配时间
     */
    private Date matchTime;

    /**
     * 匹配状态
     */
    private Integer status;
}
