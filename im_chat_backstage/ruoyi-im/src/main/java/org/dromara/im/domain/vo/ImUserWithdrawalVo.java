package org.dromara.im.domain.vo;

import java.math.BigDecimal;
import org.dromara.im.domain.ImUserWithdrawal;
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
 * 用户提现记录视图对象 im_user_withdrawal
 *
 * @author Blue
 * @date 2025-08-27
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = ImUserWithdrawal.class)
public class ImUserWithdrawalVo implements Serializable {

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
     * 类型（1余额）
     */
    @ExcelProperty(value = "类型", converter = ExcelDictConvert.class)
    @ExcelDictFormat(readConverterExp = "1=余额")
    private Integer type;

    /**
     * 订单编号
     */
    @ExcelProperty(value = "订单编号")
    private String orderSn;

    /**
     * 提现金额
     */
    @ExcelProperty(value = "提现金额")
    private BigDecimal amount;

    /**
     * 手续费
     */
    @ExcelProperty(value = "手续费")
    private BigDecimal feeAmount;

    /**
     * 实际到账金额
     */
    @ExcelProperty(value = "实际到账金额")
    private BigDecimal actualAmount;

    /**
     * hash
     */
    @ExcelProperty(value = "hash")
    private String txHash;

    /**
     * 状态（1：待审核 2：待确认 3: 已到账 4: 未到账 5: 审核拒绝）
     */
    @ExcelProperty(value = "状态", converter = ExcelDictConvert.class)
    @ExcelDictFormat(dictType = "biz_withdraw_status")
    private Integer status;

    /**
     * 提现地址
     */
    @ExcelProperty(value = "提现地址")
    private String fromAddress;

    /**
     * 数据
     */
    @ExcelProperty(value = "数据")
    private String notifyData;

    /**
     * 备注
     */
    @ExcelProperty(value = "备注")
    private String remark;

    private Date createTime;

    private Date updateTime;
}
