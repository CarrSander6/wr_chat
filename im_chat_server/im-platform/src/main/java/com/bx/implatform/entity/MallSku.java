package com.bx.implatform.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

@Data
@TableName("im_mall_sku")
public class MallSku {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long productId;

    private String skuCode;

    private String attributes;

    private BigDecimal price;

    private Integer stock;

    private Integer status;

    private Date createdTime;

    private Date updatedTime;
}
