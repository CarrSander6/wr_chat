package org.dromara.im.domain.vo;

import java.math.BigDecimal;
import org.dromara.im.domain.ImUserRecharge;
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
 * 用户充值记录视图对象 im_user_recharge
 *
 * @author Blue
 * @date 2025-08-27
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = ImUserRecharge.class)
public class ImUserRechargeVo implements Serializable {

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
     * 订单编号
     */
    @ExcelProperty(value = "订单编号")
    private String orderSn;

    /**
     * 充值金额
     */
    @ExcelProperty(value = "充值金额")
    private BigDecimal amount;

    /**
     * usdt金额
     */
    @ExcelProperty(value = "usdt金额")
    private BigDecimal usdtAmount;

    /**
     * hash
     */
    @ExcelProperty(value = "hash")
    private String txHash;

    /**
     * 状态
     */
    @ExcelProperty(value = "状态", converter = ExcelDictConvert.class)
    @ExcelDictFormat(dictType = "biz_recharge_status")
    private Integer status;

    /**
     * 转出地址
     */
    @ExcelProperty(value = "转出地址")
    private String fromAddress;

    /**
     * 转入地址
     */
    @ExcelProperty(value = "转入地址")
    private String toAddress;

    /**
     * 链上数据
     */
    @ExcelProperty(value = "链上数据")
    private String notifyData;

    /**
     * 凭证
     */
    @ExcelProperty(value = "凭证")
    private String img;

    /**
     * 备注
     */
    @ExcelProperty(value = "备注")
    private String remark;

    private Date createTime;

    private Date updateTime;
}
