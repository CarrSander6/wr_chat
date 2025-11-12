package com.bx.implatform.task.schedule;

import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.bx.implatform.entity.FriendRequest;
import com.bx.implatform.enums.FriendRequestStatus;
import com.bx.implatform.service.FriendRequestService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.time.DateUtils;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.concurrent.TimeUnit;

/**
 * 清理24小时前的聊天记录 - 暂时无法实现
 * @author Blue
 * @version 1.0
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class ClearMsg24HoursExpireTask {


    /*@Scheduled(cron = "0 0 * * * ?")
    public void run() {
        log.info("【定时任务】清理24小时前的消息记录...");

    }*/

}
