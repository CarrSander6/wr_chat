package com.kai.redenvelope;

import com.kai.redenvelope.utils.RedPacketUtil;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import java.math.BigDecimal;
import java.util.List;

/**
 * @author kai
 * @version 1.0
 * @date 2024/10/14
 * @Description
 */
@SpringBootTest
@Slf4j
public class RedPacketTest {
//    @Test
//    public void one() {
//        //总金额单位为分
//        Integer amount = 2000;
//        //总人数即红包总个数 假设
//        Integer total = 10;
//        //调用二倍均值法产生随机金额列表
//        List<Integer> list = RedPacketUtil.divideRedPackage(amount, total);
//        log.info("总金额={}分，总个数={}个", amount, total);
//        //用于统计生成的随机金额是否等于总金额
//        Integer sum = 0;
//        //遍历输出每个随机金额
//        for (Integer item : list) {
//            //输出随机金额时包括分和元的信息
//            log.info("随机金额为：{}分 即{}元", item, new BigDecimal(item.toString()).divide(new BigDecimal(100)));
//            sum += item;
//        }
//        log.info("所有随机金额叠加之和={}分 即{}元", sum, new BigDecimal(sum.toString()).divide(new BigDecimal(100)));
//
//    }

}
