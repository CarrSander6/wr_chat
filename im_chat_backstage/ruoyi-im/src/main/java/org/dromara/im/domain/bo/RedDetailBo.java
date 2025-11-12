package org.dromara.im.domain.bo;

import org.dromara.im.domain.RedDetail;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;
import jakarta.validation.constraints.*;

/**
 * 红包明细金额业务对象 red_detail
 *
 * @author Blue
 * @date 2025-08-26
 */
@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = RedDetail.class, reverseConvertGenerate = false)
public class RedDetailBo extends BaseEntity {

    /**
     * 
     */
    @NotNull(message = "不能为空", groups = { EditGroup.class })
    private Long id;

    /**
     * 红包记录id
     */
    @NotNull(message = "红包记录id不能为空", groups = { AddGroup.class, EditGroup.class })
    private Long recordId;

    /**
     * 金额(单位为分)
     */
    @NotNull(message = "金额(单位为分)不能为空", groups = { AddGroup.class, EditGroup.class })
    private Long amount;

    /**
     * 是否有效
     */
    @NotNull(message = "是否有效不能为空", groups = { AddGroup.class, EditGroup.class })
    private Long isActive;


}
