package com.bx.implatform.aspect;

import com.bx.implatform.annotation.RateLimit;
import com.bx.implatform.exception.GlobalException;
import com.bx.implatform.result.ResultUtils;
import lombok.RequiredArgsConstructor;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Component;

import java.time.Duration;

@Aspect
@Component
@RequiredArgsConstructor
public class RateLimitAspect {

    private final StringRedisTemplate stringRedisTemplate;

    @Around("@annotation(rateLimit)")
    public Object around(ProceedingJoinPoint pjp, RateLimit rateLimit) throws Throwable {
        String key = rateLimit.key();
        if (key == null || key.isEmpty()) {
            key = pjp.getSignature().toShortString();
        }
        String redisKey = "rl:" + key;
        Long count = stringRedisTemplate.opsForValue().increment(redisKey);
        if (count != null && count == 1L) {
            stringRedisTemplate.expire(redisKey, Duration.ofSeconds(rateLimit.windowSeconds()));
        }
        if (count != null && count > rateLimit.limit()) {
            throw new GlobalException("请求过于频繁，请稍后再试");
        }
        return pjp.proceed();
    }
}
