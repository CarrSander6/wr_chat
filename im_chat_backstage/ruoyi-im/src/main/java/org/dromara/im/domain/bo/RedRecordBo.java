package org.dromara.im.domain.bo;

import org.dromara.im.domain.RedRecord;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;
import jakarta.validation.constraints.*;

/**
 * 发红包记录业务对象 red_record
 *
 * @author Blue
 * @date 2025-08-26
 */
@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = RedRecord.class, reverseConvertGenerate = false)
public class RedRecordBo extends BaseEntity {

    /**
     * 
     */
    @NotNull(message = "不能为空", groups = { EditGroup.class })
    private Long id;

    /**
     * 用户id
     */
    @NotNull(message = "用户id不能为空", groups = { AddGroup.class, EditGroup.class })
    private Long userId;

    /**
     * 红包全局唯一标识串
     */
    @NotBlank(message = "红包全局唯一标识串不能为空", groups = { AddGroup.class, EditGroup.class })
    private String redPacket;

    /**
     * 人数
     */
    @NotNull(message = "人数不能为空", groups = { AddGroup.class, EditGroup.class })
    private Long total;

    /**
     * 总金额(单位为分)
     */
    @NotNull(message = "总金额(单位为分)不能为空", groups = { AddGroup.class, EditGroup.class })
    private Long amount;

    /**
     * 是否有效
     */
    @NotNull(message = "是否有效不能为空", groups = { AddGroup.class, EditGroup.class })
    private Long isActive;


}
