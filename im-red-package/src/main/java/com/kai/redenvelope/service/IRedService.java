package com.kai.redenvelope.service;

import com.kai.redenvelope.entity.dto.RedpacketDto;

import java.math.BigDecimal;
import java.util.List;

/**
 * @author kai
 * @version 1.0
 * @date 2024/10/14
 * @Description 发红包和抢红包时将其信息存入数据库 - 异步实现
 *
 */
public interface IRedService {

    //记录发红包时红包的全局唯一标识串 随机金额列表和个数存入数据库
    void recordRedpacket(RedpacketDto dto, String redId, List<BigDecimal> list);

    void recordRobpacket(Integer userId, String redId, BigDecimal amount);


}
