package com.kai.redenvelope.service.Impl;

import com.kai.redenvelope.entity.dto.RedpacketDto;
import com.kai.redenvelope.service.IRedPacketService;
import com.kai.redenvelope.utils.RedPacketUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * @author kai
 * @version 1.0
 * @date 2024/10/14
 * @Description
 */
@Service
public class RedpacketService implements IRedPacketService {

    private static final Logger log = LoggerFactory.getLogger(RedpacketService.class);

    //定义存储redis时的key
    private static final String keyPrefix = "redis:red:packet:";

    @Autowired
    private RedisTemplate redisTemplate;

    @Autowired
    private RedService redService;


    @Override
    public String handOut(RedpacketDto dto) throws Exception {
        //判断参数合法性
        if (dto.getTotal() > 0 && dto.getAmount().compareTo(BigDecimal.ZERO) > 0) {
            List<BigDecimal> list = RedPacketUtil.divideRedPackage(dto.getAmount(), dto.getTotal());
            String timeStamp = String.valueOf(System.nanoTime());
            String redId = new StringBuffer(keyPrefix).append(dto.getUserId()).append(":").append(timeStamp).toString();
            //将随机金额list存入redis
            redisTemplate.opsForList().leftPushAll(redId, list);
            //用于存储红包总数的key
            String redTotalKey = redId + ":total";
            //放入redis
            redisTemplate.opsForValue().set(redTotalKey, dto.getTotal());

            //异步记录将红包的全局唯一标识串，红包个数与随机金额列表存至数据库
            redService.recordRedpacket(dto, redId, list);

            //将红包的全局唯一标识返回给前端
            return redId;
        } else {
            throw new Exception("系统异常-分发红包-参数不合法");
        }


    }


    /*
      抢红包业务逻辑处理
      @param userId 当前用户-抢红包
     * @param redId 红包唯一Id
     * @return
     */
    //改进代码
    @Override
    public BigDecimal rob(Integer userId, String redId) throws Exception {
        //定义redis值操作方法
        ValueOperations ops = redisTemplate.opsForValue();
        //先判断用户是否抢过红包  userId区分
        Object obj = ops.get(redId + userId + ":rob");
        //如果抢过了，则直接返回红包金额，并在前端显示
        if (obj != null) {
            return new BigDecimal(obj.toString());
        }
        //点红包的业务逻辑
        boolean res = click(redId);
        if (!res) {
            return null; //表示没抢到
        }
        //定义分布式锁，一个红包只有一个人能抢一次随机金额。即要永远保证一对一关系
        //构造缓存中的key
        final String lockKey = redId + userId + "-lock";
       /* //调用setIfAbsent()方法，其实就是简接实现了分布式锁
        Boolean lock = ops.setIfAbsent(lockKey, redId);
        //设置过期时间
        redisTemplate.expire(lockKey, 24L, TimeUnit.HOURS);*/

        Boolean lock = ops.setIfAbsent(lockKey, redId, 24L, TimeUnit.HOURS);
        try {
            //表示该线程获取到了该分布式锁
            if (lock) {
                //开始执行后续流程
                //进入拆红包业务
                Object pop = redisTemplate.opsForList().rightPop(redId);
                if (pop == null) {
                    log.info("您已经抢过红包，userId={}", userId);
                    return null;
                }
                //排除没抢上的问题
                //抢到一个红包，则更新缓存，并将信息记入数据库
                String redTotalKey = redId + ":total";

           /*     //更新缓存 红包个数减一
                Integer currentTotal = (Integer) ops.get(redTotalKey);
                if (currentTotal != null && (Integer) ops.get(redTotalKey) > 0) {
                    ops.set(redTotalKey, currentTotal - 1);
                }*/
                //优化高并发情况下currentTotal只减一次的问题
                // 使用Redis的原子操作减少红包数量
                Long currentTotal = redisTemplate.opsForValue().decrement(redTotalKey, 1);
                if (currentTotal < 0) {
                    // 如果减1后小于0，说明已经没有红包了
                    log.info("红包已抢完，userId={}", userId);
                    return null;
                }

                //将金额单位处理为 元
                BigDecimal result = new BigDecimal(pop.toString());
                //将抢红包的用户账号及抢到的金额信息等记入数据库
                redService.recordRobpacket(userId, redId, result);
                //将当前用户放入缓存中，表示他已经抢过红包
                ops.set(redId + userId + ":rob", result, 24L, TimeUnit.HOURS);
                //打印当前用户抢到红包的记录信息
                log.info("当前用户抢到红包：userId={} key= {} 金额={}", userId, redId, result);

                return result;
            }
        } catch (Exception e) {
            throw new Exception("系统异常-抢红包-加分布式锁失败");
        }
        // 如果没有抢到红包或者分布式锁获取失败，返回 null
        return null;

    }

    /**
      判断是否抢过该红包
      @param userId 当前用户-抢红包
     * @param redId 红包唯一Id
     * @return
     */
    //改进代码
    @Override
    public Boolean isRob(Integer userId, String redId) throws Exception {

        //先判断用户是否抢过红包  userId区分
        Object obj = redisTemplate.opsForValue().get(redId + userId + ":rob");
        //如果抢过了，则直接返回红包金额，并在前端显示
        return obj != null;
    }


    /**
     * 判断缓存中是否还有红包
     *
     * @param redId
     * @return
     */
    private boolean click(String redId) {
        ValueOperations ops = redisTemplate.opsForValue();

        //定义查询缓存系统中剩余个数的key
        String redTotalKey = redId + ":total";
        Object obj = ops.get(redTotalKey);
        if (obj != null && Integer.valueOf(obj.toString()) > 0) {
            return true;
        }
        return false;

    }
}
/*    *//**
 * 抢红包业务逻辑处理
 *
 * @param userId 当前用户-抢红包
 * @param redId 红包唯一Id
 * @return
 *//*
    @Override
    public BigDecimal rob(Integer userId, String redId) {
        //定义redis值操作方法
        ValueOperations ops = redisTemplate.opsForValue();
        //先判断用户是否抢过红包  userId区分
        Object obj = ops.get(redId + userId + ":rob");
        //如果抢过了，则直接返回红包金额，并在前端显示
        if (obj != null) {
            return new BigDecimal(obj.toString());
        }
        //点红包的业务逻辑
        boolean res = click(redId);
        if (!res) {
            return null; //表示没抢到
        }
        //进入拆红包业务
        Object pop = redisTemplate.opsForList().rightPop(redId);
        if (pop == null) {
            log.info("您已经抢过红包，userId={}",userId);
            return null;
        }
        //排除没抢上的问题
        //抢到一个红包，则更新缓存，并将信息记入数据库
        String redTotalKey = redId + ":total";
        //更新缓存 红包个数减一
        Integer currentTotal = (Integer)ops.get(redTotalKey) ;
        if (currentTotal != null && (Integer) ops.get(redTotalKey) > 0) {
            ops.set(redTotalKey, currentTotal - 1);
        }

        //将金额单位处理为 元
        BigDecimal result = new BigDecimal(pop.toString()).divide(new BigDecimal(100));
        //将抢红包的用户账号及抢到的金额信息等记入数据库
        redService.recordRobpacket(userId, redId, result);
        //将当前用户放入缓存中，表示他已经抢过红包
        ops.set(redId + userId + ":rob", result, 24L, TimeUnit.HOURS);
        //打印当前用户抢到红包的记录信息
        log.info("当前用户抢到红包：userId={} key= {} 金额={}", userId, redId, result);

        return result;
    }*/
