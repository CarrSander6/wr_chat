package com.bx.implatform.vo;

import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 商品VO
 */
@Data
public class ProductVO {

    /**
     * 商品ID
     */
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
     * 商品类型
     */
    private Integer productType;

    /**
     * 是否支持分销
     */
    private Boolean enableDistribution;

    /**
     * 创建时间
     */
    private Date createdTime;
}
