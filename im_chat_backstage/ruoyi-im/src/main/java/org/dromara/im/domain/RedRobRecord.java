package org.dromara.im.domain;

import org.dromara.common.mybatis.core.domain.BaseEntity;
import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import lombok.EqualsAndHashCode;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import java.io.Serial;

/**
 * 抢红包记录对象 red_rob_record
 *
 * @author Blue
 * @date 2025-08-26
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("red_rob_record")
public class RedRobRecord extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 
     */
    @TableId(value = "id")
    private Long id;

    /**
     * 用户账号
     */
    private Long userId;

    /**
     * 红包标识串
     */
    private String redPacket;

    /**
     * 红包金额(单位为分)
     */
    private Long amount;

    /**
     * 时间
     */
    private Date robTime;

    /**
     * 删除标志（0代表存在 1代表删除）
     */
    @TableLogic
    private String delFlag;


}
