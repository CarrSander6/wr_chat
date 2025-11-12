package com.bx.implatform.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

@Data
@TableName("im_user_fund_detail")
public class UserFundDetail {

    /**
     * 主键
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 用户id
     */
    private Long userId;

    /**
     * 描述
     */
    private String describes;

    /**
     * 资产类型
     */
    private Integer type;

    /**
     * 转入转出标识 -1：转出 1：转入
     */
    private Integer transferFlag;

    /**
     * 订单编号
     */
    private String orderNo;

    /**
     * 变动前
     */
    private BigDecimal pointBefore;

    /**
     * 数量
     */
    private BigDecimal amount;

    /**
     * 变动后
     */
    private BigDecimal pointAfter;

    /**
     * hash
     */
    private String txHash;

    /**
     * 存证时间
     */
    private Date txTime;

    /**
     * 备注
     */
    private String remark;

    private Date createTime;

    private Date updateTime;

    /**
     * 删除标志（0代表存在 2代表删除）
     */
    @TableLogic
    private String delFlag;

    /**
     * 版本
     */
    @Version
    private Long version;


}
