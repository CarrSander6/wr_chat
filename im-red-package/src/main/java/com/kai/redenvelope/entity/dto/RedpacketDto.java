package com.kai.redenvelope.entity.dto;

import lombok.Data;
import lombok.ToString;

import javax.validation.constraints.NotNull;
import java.math.BigDecimal;

/**
 * @author kai
 * @version 1.0
 * @date 2024/10/14
 * @Description
 */
@Data
@ToString
public class RedpacketDto {

    private Integer userId; //用户id

    @NotNull
    private Integer total;//红包个数

    @NotNull
    private BigDecimal amount;//总金额


}
