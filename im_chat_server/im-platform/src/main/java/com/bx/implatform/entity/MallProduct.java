package com.bx.implatform.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 商城商品表
 */
@Data
@TableName("im_mall_product")
public class MallProduct {

    /**
     * 主键ID
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 商品名称
     */
    private String productName;

    /**
     * 商品描述
     */
    private String description;

    /**
     * 商品图片
     */
    private String imageUrl;

    /**
     * 商品价格
     */
    private BigDecimal price;

    /**
     * 原价
     */
    private BigDecimal originalPrice;

    /**
     * 库存
     */
    private Integer stock;

    /**
     * 销量
     */
    private Integer salesCount;

    /**
     * 商品类型: 1-虚拟商品 2-实物商品
     */
    private Integer productType;

    /**
     * 商品状态: 0-下架 1-上架
     */
    private Integer status;

    /**
     * 排序
     */
    private Integer sortOrder;

    /**
     * 是否支持分销: 0-否 1-是
     */
    private Boolean enableDistribution;

    /**
     * 一级佣金比例
     */
    private BigDecimal level1CommissionRate;

    /**
     * 二级佣金比例
     */
    private BigDecimal level2CommissionRate;

    /**
     * 创建时间
     */
    private Date createdTime;

    /**
     * 更新时间
     */
    private Date updatedTime;
}
