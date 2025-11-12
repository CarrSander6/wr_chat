package org.dromara.im.domain.bo;

import org.dromara.im.domain.ImUserFundDetail;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;
import jakarta.validation.constraints.*;
import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 用户资产明细业务对象 im_user_fund_detail
 *
 * @author Blue
 * @date 2025-08-26
 */
@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = ImUserFundDetail.class, reverseConvertGenerate = false)
public class ImUserFundDetailBo extends BaseEntity {

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
     * 描述
     */
    @NotBlank(message = "描述不能为空", groups = { AddGroup.class, EditGroup.class })
    private String describes;

    /**
     * 资产类型
     */
    @NotNull(message = "资产类型不能为空", groups = { AddGroup.class, EditGroup.class })
    private Integer type;

    /**
     * 转入转出标识 -1：转出 1：转入
     */
    @NotNull(message = "转入转出标识 -1：转出 1：转入不能为空", groups = { AddGroup.class, EditGroup.class })
    private Integer transferFlag;

    /**
     * 订单编号
     */
    @NotBlank(message = "订单编号不能为空", groups = { AddGroup.class, EditGroup.class })
    private String orderNo;

    /**
     * 变动前
     */
    @NotNull(message = "变动前不能为空", groups = { AddGroup.class, EditGroup.class })
    private BigDecimal pointBefore;

    /**
     * 数量
     */
    @NotNull(message = "数量不能为空", groups = { AddGroup.class, EditGroup.class })
    private BigDecimal amount;

    /**
     * 变动后
     */
    @NotNull(message = "变动后不能为空", groups = { AddGroup.class, EditGroup.class })
    private BigDecimal pointAfter;

    /**
     * hash
     */
    @NotBlank(message = "hash不能为空", groups = { AddGroup.class, EditGroup.class })
    private String txHash;

    /**
     * 存证时间
     */
    @NotNull(message = "存证时间不能为空", groups = { AddGroup.class, EditGroup.class })
    private Date txTime;

    /**
     * 备注
     */
    @NotBlank(message = "备注不能为空", groups = { AddGroup.class, EditGroup.class })
    private String remark;


}
