package com.kai.redenvelope.service;

import com.kai.redenvelope.entity.dto.RedpacketDto;

import java.math.BigDecimal;

/**
 * @author kai
 * @version 1.0
 * @date 2024/10/14
 * @Description
 */

public interface IRedPacketService {


    //发红包核心业务逻辑
    String handOut(RedpacketDto dto) throws Exception;

    //抢红包核心业务逻辑
    BigDecimal rob(Integer userId, String redId) throws Exception;

    //是否抢过该红包
    Boolean isRob(Integer userId, String redId) throws Exception;


}
