package org.dromara.im.domain.bo;

import org.dromara.im.domain.ImUserRecharge;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;
import jakarta.validation.constraints.*;
import java.math.BigDecimal;

/**
 * 用户充值记录业务对象 im_user_recharge
 *
 * @author Blue
 * @date 2025-08-27
 */
@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = ImUserRecharge.class, reverseConvertGenerate = false)
public class ImUserRechargeBo extends BaseEntity {

    /**
     * 主键
     */
    @NotNull(message = "主键不能为空", groups = { EditGroup.class })
    private Long id;

    /**
     * 用户id
     */
    @NotNull(message = "用户id不能为空", groups = { AddGroup.class, EditGroup.class })
    private Long userId;

    /**
     * 订单编号
     */
    @NotBlank(message = "订单编号不能为空", groups = { AddGroup.class, EditGroup.class })
    private String orderSn;

    /**
     * 充值金额
     */
    @NotNull(message = "充值金额不能为空", groups = { AddGroup.class, EditGroup.class })
    private BigDecimal amount;

    /**
     * usdt金额
     */
    @NotNull(message = "usdt金额不能为空", groups = { AddGroup.class, EditGroup.class })
    private BigDecimal usdtAmount;

    /**
     * hash
     */
    @NotBlank(message = "hash不能为空", groups = { AddGroup.class, EditGroup.class })
    private String txHash;

    /**
     * 状态
     */
    @NotNull(message = "状态不能为空", groups = { AddGroup.class, EditGroup.class })
    private Integer status;

    /**
     * 转出地址
     */
    @NotBlank(message = "转出地址不能为空", groups = { AddGroup.class, EditGroup.class })
    private String fromAddress;

    /**
     * 转入地址
     */
    @NotBlank(message = "转入地址不能为空", groups = { AddGroup.class, EditGroup.class })
    private String toAddress;

    /**
     * 链上数据
     */
    @NotBlank(message = "链上数据不能为空", groups = { AddGroup.class, EditGroup.class })
    private String notifyData;

    /**
     * 凭证
     */
    @NotBlank(message = "凭证不能为空", groups = { AddGroup.class, EditGroup.class })
    private String img;

    /**
     * 备注
     */
    @NotBlank(message = "备注不能为空", groups = { AddGroup.class, EditGroup.class })
    private String remark;


}
