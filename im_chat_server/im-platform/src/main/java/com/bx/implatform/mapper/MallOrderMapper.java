package com.bx.implatform.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.bx.implatform.entity.MallOrder;
import org.apache.ibatis.annotations.Mapper;

/**
 * 商城订单Mapper
 */
@Mapper
public interface MallOrderMapper extends BaseMapper<MallOrder> {
}
