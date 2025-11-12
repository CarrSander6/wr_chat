package org.dromara.im.domain.bo;

import org.dromara.im.domain.ImUserWithdrawal;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;
import jakarta.validation.constraints.*;
import java.math.BigDecimal;

/**
 * 用户提现记录业务对象 im_user_withdrawal
 *
 * @author Blue
 * @date 2025-08-27
 */
@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = ImUserWithdrawal.class, reverseConvertGenerate = false)
public class ImUserWithdrawalBo extends BaseEntity {

    /**
     * 主键
     */
    @NotNull(message = "主键不能为空", groups = { EditGroup.class })
    private Long id;

    /**
     * 用户id
     */
    //@NotNull(message = "用户id不能为空", groups = { AddGroup.class, EditGroup.class })
    private Long userId;

    /**
     * 类型（1余额）
     */
    //@NotNull(message = "类型（1余额）不能为空", groups = { AddGroup.class, EditGroup.class })
    private Integer type;

    /**
     * 订单编号
     */
    //@NotBlank(message = "订单编号不能为空", groups = { AddGroup.class, EditGroup.class })
    private String orderSn;

    /**
     * 提现金额
     */
    //@NotNull(message = "提现金额不能为空", groups = { AddGroup.class, EditGroup.class })
    private BigDecimal amount;

    /**
     * 手续费
     */
    //@NotNull(message = "手续费不能为空", groups = { AddGroup.class, EditGroup.class })
    private BigDecimal feeAmount;

    /**
     * 实际到账金额
     */
    //@NotNull(message = "实际到账金额不能为空", groups = { AddGroup.class, EditGroup.class })
    private BigDecimal actualAmount;

    /**
     * hash
     */
    //@NotBlank(message = "hash不能为空", groups = { AddGroup.class, EditGroup.class })
    private String txHash;

    /**
     * 状态（1：待审核 2：待确认 3: 已到账 4: 未到账 5: 审核拒绝）
     */
    //@NotNull(message = "状态（1：待审核 2：待确认 3: 已到账 4: 未到账 5: 审核拒绝）不能为空", groups = { AddGroup.class, EditGroup.class })
    private Integer status;

    /**
     * 提现地址
     */
    //@NotBlank(message = "提现地址不能为空", groups = { AddGroup.class, EditGroup.class })
    private String fromAddress;

    /**
     * 数据
     */
    //@NotBlank(message = "数据不能为空", groups = { AddGroup.class, EditGroup.class })
    private String notifyData;

    /**
     * 备注
     */
    //@NotBlank(message = "备注不能为空", groups = { AddGroup.class, EditGroup.class })
    private String remark;


}
