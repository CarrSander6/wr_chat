package com.bx.implatform.load;

import lombok.extern.slf4j.Slf4j;

import java.util.concurrent.CountDownLatch;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicLong;

/**
 * 负载测试基类
 * 
 * @author Blue
 * @date 2024
 */
@Slf4j
public abstract class LoadTestBase {

    /**
     * 执行负载测试
     * 
     * @param concurrentUsers 并发用户数
     * @param totalRequests 总请求数
     * @param task 测试任务
     */
    protected LoadTestResult executeLoadTest(int concurrentUsers, int totalRequests, Runnable task) {
        ExecutorService executor = Executors.newFixedThreadPool(concurrentUsers);
        CountDownLatch latch = new CountDownLatch(totalRequests);
        
        AtomicInteger successCount = new AtomicInteger(0);
        AtomicInteger failCount = new AtomicInteger(0);
        AtomicLong totalResponseTime = new AtomicLong(0);
        
        long startTime = System.currentTimeMillis();
        
        for (int i = 0; i < totalRequests; i++) {
            executor.submit(() -> {
                try {
                    long requestStart = System.currentTimeMillis();
                    task.run();
                    long responseTime = System.currentTimeMillis() - requestStart;
                    totalResponseTime.addAndGet(responseTime);
                    successCount.incrementAndGet();
                } catch (Exception e) {
                    failCount.incrementAndGet();
                    log.error("请求失败: {}", e.getMessage());
                } finally {
                    latch.countDown();
                }
            });
        }
        
        try {
            latch.await();
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            log.error("负载测试被中断", e);
        }
        
        long totalTime = System.currentTimeMillis() - startTime;
        executor.shutdown();
        
        // 计算结果
        LoadTestResult result = new LoadTestResult();
        result.setConcurrentUsers(concurrentUsers);
        result.setTotalRequests(totalRequests);
        result.setSuccessCount(successCount.get());
        result.setFailCount(failCount.get());
        result.setTotalTime(totalTime);
        result.setAvgResponseTime(successCount.get() > 0 ? 
            totalResponseTime.get() / (double) successCount.get() : 0);
        result.setThroughput(totalRequests / (totalTime / 1000.0));
        
        return result;
    }

    /**
     * 负载测试结果
     */
    public static class LoadTestResult {
        private int concurrentUsers;
        private int totalRequests;
        private int successCount;
        private int failCount;
        private long totalTime;
        private double avgResponseTime;
        private double throughput;

        public void print() {
            log.info("========== 负载测试结果 ==========");
            log.info("并发用户数: {}", concurrentUsers);
            log.info("总请求数: {}", totalRequests);
            log.info("成功请求: {}", successCount);
            log.info("失败请求: {}", failCount);
            log.info("总耗时: {}ms", totalTime);
            log.info("平均响应时间: {}ms", String.format("%.2f", avgResponseTime));
            log.info("吞吐量: {} req/s", String.format("%.2f", throughput));
            log.info("==================================");
        }

        // Getters and setters
        public int getConcurrentUsers() { return concurrentUsers; }
        public void setConcurrentUsers(int concurrentUsers) { this.concurrentUsers = concurrentUsers; }
        public int getTotalRequests() { return totalRequests; }
        public void setTotalRequests(int totalRequests) { this.totalRequests = totalRequests; }
        public int getSuccessCount() { return successCount; }
        public void setSuccessCount(int successCount) { this.successCount = successCount; }
        public int getFailCount() { return failCount; }
        public void setFailCount(int failCount) { this.failCount = failCount; }
        public long getTotalTime() { return totalTime; }
        public void setTotalTime(long totalTime) { this.totalTime = totalTime; }
        public double getAvgResponseTime() { return avgResponseTime; }
        public void setAvgResponseTime(double avgResponseTime) { this.avgResponseTime = avgResponseTime; }
        public double getThroughput() { return throughput; }
        public void setThroughput(double throughput) { this.throughput = throughput; }
    }
}
