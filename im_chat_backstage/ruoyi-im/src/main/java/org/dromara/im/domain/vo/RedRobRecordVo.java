package org.dromara.im.domain.vo;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.dromara.im.domain.RedRobRecord;
import com.alibaba.excel.annotation.ExcelIgnoreUnannotated;
import com.alibaba.excel.annotation.ExcelProperty;
import org.dromara.common.excel.annotation.ExcelDictFormat;
import org.dromara.common.excel.convert.ExcelDictConvert;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.util.Date;



/**
 * 抢红包记录视图对象 red_rob_record
 *
 * @author Blue
 * @date 2025-08-26
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = RedRobRecord.class)
public class RedRobRecordVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 
     */
    @ExcelProperty(value = "")
    private Long id;

    /**
     * 用户账号
     */
    @ExcelProperty(value = "用户账号")
    private Long userId;

    /**
     * 红包标识串
     */
    @ExcelProperty(value = "红包标识串")
    private String redPacket;

    /**
     * 红包金额(单位为分)
     */
    @ExcelProperty(value = "红包金额(单位为分)")
    private Long amount;

    /**
     * 时间
     */
    @ExcelProperty(value = "时间")
    private Date robTime;

    private Date createTime;

    private Date updateTime;
}
