package com.bx.implatform.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.util.Date;

@Data
@TableName("im_mall_aftersale")
public class AfterSaleRequest {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long orderId;

    private Long userId;

    private String reason;

    private Integer status; // 0-待审核 1-通过 2-拒绝 3-已退款

    private Date createdTime;

    private Date updatedTime;
}
