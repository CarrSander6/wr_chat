package org.dromara.im.domain.vo;

import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.dromara.im.domain.ImUserFundDetail;
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
 * 用户资产明细视图对象 im_user_fund_detail
 *
 * @author Blue
 * @date 2025-08-26
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = ImUserFundDetail.class)
public class ImUserFundDetailVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 主键
     */
    @ExcelProperty(value = "主键")
    private Long id;

    /**
     * 用户id
     */
    @ExcelProperty(value = "用户id")
    private Long userId;

    /**
     * 描述
     */
    @ExcelProperty(value = "描述")
    private String describes;

    /**
     * 资产类型
     */
    @ExcelProperty(value = "资产类型", converter = ExcelDictConvert.class)
    @ExcelDictFormat(dictType = "biz_fund_type")
    private Integer type;

    /**
     * 转入转出标识 -1：转出 1：转入
     */
    @ExcelProperty(value = "转入转出标识 -1：转出 1：转入", converter = ExcelDictConvert.class)
    @ExcelDictFormat(dictType = "biz_transfer_flag")
    private Integer transferFlag;

    /**
     * 订单编号
     */
    @ExcelProperty(value = "订单编号")
    private String orderNo;

    /**
     * 变动前
     */
    @ExcelProperty(value = "变动前")
    private BigDecimal pointBefore;

    /**
     * 数量
     */
    @ExcelProperty(value = "数量")
    private BigDecimal amount;

    /**
     * 变动后
     */
    @ExcelProperty(value = "变动后")
    private BigDecimal pointAfter;

    /**
     * hash
     */
    @ExcelProperty(value = "hash")
    private String txHash;

    /**
     * 存证时间
     */
    @ExcelProperty(value = "存证时间")
    private Date txTime;

    /**
     * 备注
     */
    @ExcelProperty(value = "备注")
    private String remark;

    private Date createTime;

    private Date updateTime;
}
