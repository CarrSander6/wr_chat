package com.bx.implatform.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.util.Date;

@Data
@TableName("im_match_feedback")
public class MatchFeedback {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long userId;

    private Long targetUserId;

    private Integer score;

    private String comment;

    private Date createdTime;
}
