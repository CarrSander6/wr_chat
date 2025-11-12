package org.dromara.im.domain;

import org.dromara.common.mybatis.core.domain.BaseEntity;
import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import lombok.EqualsAndHashCode;
import java.math.BigDecimal;

import java.io.Serial;

/**
 * 用户提现记录对象 im_user_withdrawal
 *
 * @author Blue
 * @date 2025-08-27
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("im_user_withdrawal")
public class ImUserWithdrawal extends BaseEntity {

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
     * 类型（1余额）
     */
    private Integer type;

    /**
     * 订单编号
     */
    private String orderSn;

    /**
     * 提现金额
     */
    private BigDecimal amount;

    /**
     * 手续费
     */
    private BigDecimal feeAmount;

    /**
     * 实际到账金额
     */
    private BigDecimal actualAmount;

    /**
     * hash
     */
    private String txHash;

    /**
     * 状态（1：待审核 2：待确认 3: 已到账 4: 未到账 5: 审核拒绝）
     */
    private Integer status;

    /**
     * 提现地址
     */
    private String fromAddress;

    /**
     * 数据
     */
    private String notifyData;

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
