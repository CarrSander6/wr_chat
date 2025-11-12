package org.dromara.im.domain.vo;

import org.dromara.im.domain.RedDetail;
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
 * 红包明细金额视图对象 red_detail
 *
 * @author Blue
 * @date 2025-08-26
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = RedDetail.class)
public class RedDetailVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 
     */
    @ExcelProperty(value = "")
    private Long id;

    /**
     * 红包记录id
     */
    @ExcelProperty(value = "红包记录id")
    private Long recordId;

    /**
     * 金额(单位为分)
     */
    @ExcelProperty(value = "金额(单位为分)")
    private Long amount;

    /**
     * 是否有效
     */
    @ExcelProperty(value = "是否有效")
    private Long isActive;

    private Date createTime;

    private Date updateTime;
}
