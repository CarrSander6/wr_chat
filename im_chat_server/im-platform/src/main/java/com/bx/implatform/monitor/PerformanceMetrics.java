package com.bx.implatform.monitor;

import lombok.Data;
import org.springframework.stereotype.Component;

import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicLong;

/**
 * 性能指标收集器
 * 
 * @author Blue
 * @date 2024
 */
@Component
public class PerformanceMetrics {

    /**
     * 请求计数器
     */
    private final ConcurrentHashMap<String, AtomicLong> requestCounters = new ConcurrentHashMap<>();
    
    /**
     * 平均响应时间
     */
    private final ConcurrentHashMap<String, AvgTime> avgResponseTimes = new ConcurrentHashMap<>();

    /**
     * 记录请求
     */
    public void recordRequest(String endpoint) {
        requestCounters.computeIfAbsent(endpoint, k -> new AtomicLong(0)).incrementAndGet();
    }

    /**
     * 记录响应时间
     */
    public void recordResponseTime(String endpoint, long timeMs) {
        avgResponseTimes.computeIfAbsent(endpoint, k -> new AvgTime()).add(timeMs);
    }

    /**
     * 获取请求计数
     */
    public long getRequestCount(String endpoint) {
        AtomicLong counter = requestCounters.get(endpoint);
        return counter != null ? counter.get() : 0;
    }

    /**
     * 获取平均响应时间
     */
    public double getAvgResponseTime(String endpoint) {
        AvgTime avgTime = avgResponseTimes.get(endpoint);
        return avgTime != null ? avgTime.getAvg() : 0.0;
    }

    /**
     * 获取所有指标
     */
    public ConcurrentHashMap<String, MetricData> getAllMetrics() {
        ConcurrentHashMap<String, MetricData> metrics = new ConcurrentHashMap<>();
        for (String endpoint : requestCounters.keySet()) {
            MetricData data = new MetricData();
            data.setEndpoint(endpoint);
            data.setRequestCount(getRequestCount(endpoint));
            data.setAvgResponseTime(getAvgResponseTime(endpoint));
            metrics.put(endpoint, data);
        }
        return metrics;
    }

    /**
     * 平均时间计算器
     */
    private static class AvgTime {
        private final AtomicLong totalTime = new AtomicLong(0);
        private final AtomicLong count = new AtomicLong(0);

        public void add(long time) {
            totalTime.addAndGet(time);
            count.incrementAndGet();
        }

        public double getAvg() {
            long c = count.get();
            return c > 0 ? (double) totalTime.get() / c : 0.0;
        }
    }

    /**
     * 指标数据
     */
    @Data
    public static class MetricData {
        private String endpoint;
        private long requestCount;
        private double avgResponseTime;
    }
}
