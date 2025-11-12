package org.dromara.im.domain.vo;

import org.dromara.im.domain.RedRecord;
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
 * 发红包记录视图对象 red_record
 *
 * @author Blue
 * @date 2025-08-26
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = RedRecord.class)
public class RedRecordVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 
     */
    @ExcelProperty(value = "")
    private Long id;

    /**
     * 用户id
     */
    @ExcelProperty(value = "用户id")
    private Long userId;

    /**
     * 红包全局唯一标识串
     */
    @ExcelProperty(value = "红包全局唯一标识串")
    private String redPacket;

    /**
     * 人数
     */
    @ExcelProperty(value = "人数")
    private Long total;

    /**
     * 总金额(单位为分)
     */
    @ExcelProperty(value = "总金额(单位为分)")
    private Long amount;

    /**
     * 是否有效
     */
    @ExcelProperty(value = "是否有效")
    private Long isActive;

    private Date createTime;

    private Date updateTime;
}
