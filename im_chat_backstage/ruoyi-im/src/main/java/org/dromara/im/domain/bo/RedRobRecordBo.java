package org.dromara.im.domain.bo;

import org.dromara.im.domain.RedRobRecord;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;
import jakarta.validation.constraints.*;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 抢红包记录业务对象 red_rob_record
 *
 * @author Blue
 * @date 2025-08-26
 */
@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = RedRobRecord.class, reverseConvertGenerate = false)
public class RedRobRecordBo extends BaseEntity {

    /**
     * 
     */
    @NotNull(message = "不能为空", groups = { EditGroup.class })
    private Long id;

    /**
     * 用户账号
     */
    @NotNull(message = "用户账号不能为空", groups = { AddGroup.class, EditGroup.class })
    private Long userId;

    /**
     * 红包标识串
     */
    @NotBlank(message = "红包标识串不能为空", groups = { AddGroup.class, EditGroup.class })
    private String redPacket;

    /**
     * 红包金额(单位为分)
     */
    @NotNull(message = "红包金额(单位为分)不能为空", groups = { AddGroup.class, EditGroup.class })
    private Long amount;

    /**
     * 时间
     */
    @NotNull(message = "时间不能为空", groups = { AddGroup.class, EditGroup.class })
    private Date robTime;


}
