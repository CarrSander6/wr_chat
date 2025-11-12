package org.dromara.im.domain;

import org.dromara.common.mybatis.core.domain.BaseEntity;
import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import lombok.EqualsAndHashCode;
import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import java.io.Serial;

/**
 * 用户资产明细对象 im_user_fund_detail
 *
 * @author Blue
 * @date 2025-08-26
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("im_user_fund_detail")
public class ImUserFundDetail extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 主键
     */
    @TableId(value = "id")
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
