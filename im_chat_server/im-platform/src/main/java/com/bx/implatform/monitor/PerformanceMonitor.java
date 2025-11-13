package com.bx.implatform.monitor;

import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

/**
 * 性能监控切面
 * 
 * @author Blue
 * @date 2024
 */
@Slf4j
@Aspect
@Component
public class PerformanceMonitor {

    /**
     * 监控Controller层性能
     */
    @Around("execution(* com.bx.implatform.controller..*.*(..))")
    public Object monitorController(ProceedingJoinPoint joinPoint) throws Throwable {
        return monitor(joinPoint, "Controller");
    }

    /**
     * 监控Service层性能
     */
    @Around("execution(* com.bx.implatform.service..*.*(..))")
    public Object monitorService(ProceedingJoinPoint joinPoint) throws Throwable {
        return monitor(joinPoint, "Service");
    }

    /**
     * 执行监控
     */
    private Object monitor(ProceedingJoinPoint joinPoint, String layer) throws Throwable {
        long startTime = System.currentTimeMillis();
        String methodName = joinPoint.getSignature().toShortString();
        
        try {
            Object result = joinPoint.proceed();
            long executionTime = System.currentTimeMillis() - startTime;
            
            // 慢请求预警（超过1秒）
            if (executionTime > 1000) {
                log.warn("[性能监控] {} - 慢方法: {}, 耗时: {}ms", layer, methodName, executionTime);
            } else if (executionTime > 500) {
                log.info("[性能监控] {} - 方法: {}, 耗时: {}ms", layer, methodName, executionTime);
            }
            
            return result;
        } catch (Throwable e) {
            long executionTime = System.currentTimeMillis() - startTime;
            log.error("[性能监控] {} - 方法异常: {}, 耗时: {}ms, 异常: {}", 
                layer, methodName, executionTime, e.getMessage());
            throw e;
        }
    }
}
