package com.kai.redenvelope.service.Impl;

import com.kai.redenvelope.Mapper.RedDetailMapper;
import com.kai.redenvelope.Mapper.RedRecordMapper;
import com.kai.redenvelope.Mapper.RedRobRecordMapper;
import com.kai.redenvelope.entity.RedDetail;
import com.kai.redenvelope.entity.RedRecord;
import com.kai.redenvelope.entity.RedRobRecord;
import com.kai.redenvelope.entity.dto.RedpacketDto;
import com.kai.redenvelope.service.IRedService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * @author kai
 * @version 1.0
 * @date 2024/10/14
 * @Description
 */

@Service
public class RedService implements IRedService {

    private static final Logger log = LoggerFactory.getLogger(RedService.class);

    @Resource
    private RedRecordMapper redRecordMapper;
    @Resource
    private RedDetailMapper redDetailMapper;
    @Resource
    private RedRobRecordMapper redRobRecordMapper;


    /**
     * 发红包记录-异步方式
     *
     * @param dto
     * @param redId
     * @param list
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    @Async
    public void recordRedpacket(RedpacketDto dto, String redId, List<BigDecimal> list) {
        RedRecord redRecord = new RedRecord();
        //填充字段 还有isactive没有保存
        redRecord.setRedPacket(redId);
        redRecord.setUserId(dto.getUserId());
        redRecord.setTotal(dto.getTotal());
        redRecord.setAmount(dto.getAmount());
        redRecord.setCreateTime(new Date());

        //将对象信息插入
        redRecordMapper.insertSelective(redRecord);

        //redRecordMapper.selectByExample(redRecord)

        RedDetail redDetail ;
        for (BigDecimal item : list) {
            redDetail = new RedDetail();
            redDetail.setRecordId(redRecord.getId());
            redDetail.setAmount(item);
            redDetail.setCreateTime(new Date());
            redDetailMapper.insertSelective(redDetail);

        }

    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    @Async
    public void recordRobpacket(Integer userId, String redId, BigDecimal amount) {

        RedRobRecord record = new RedRobRecord();
        record.setUserId(userId);
        record.setRedPacket(redId);
        record.setAmount(amount);
        record.setRobTime(new Date());
        redRobRecordMapper.insertSelective(record);


    }
}
