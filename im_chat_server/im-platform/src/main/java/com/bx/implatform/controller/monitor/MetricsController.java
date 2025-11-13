package com.bx.implatform.controller.monitor;

import com.bx.implatform.monitor.PerformanceMetrics;
import com.bx.implatform.result.Result;
import com.bx.implatform.result.ResultUtils;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.concurrent.ConcurrentHashMap;

/**
 * 性能指标监控控制器
 * 
 * @author Blue
 * @date 2024
 */
@RestController
@RequestMapping("/monitor/metrics")
@RequiredArgsConstructor
@Tag(name = "性能监控", description = "性能指标监控接口")
public class MetricsController {

    private final PerformanceMetrics performanceMetrics;

    /**
     * 获取所有性能指标
     */
    @GetMapping("/all")
    @Operation(summary = "获取所有性能指标")
    public Result<ConcurrentHashMap<String, PerformanceMetrics.MetricData>> getAllMetrics() {
        return ResultUtils.success(performanceMetrics.getAllMetrics());
    }

    /**
     * 获取系统健康状态
     */
    @GetMapping("/health")
    @Operation(summary = "获取系统健康状态")
    public Result<HealthStatus> getHealthStatus() {
        HealthStatus status = new HealthStatus();
        status.setStatus("UP");
        status.setTimestamp(System.currentTimeMillis());
        return ResultUtils.success(status);
    }

    /**
     * 健康状态
     */
    public static class HealthStatus {
        private String status;
        private long timestamp;

        public String getStatus() {
            return status;
        }

        public void setStatus(String status) {
            this.status = status;
        }

        public long getTimestamp() {
            return timestamp;
        }

        public void setTimestamp(long timestamp) {
            this.timestamp = timestamp;
        }
    }
}
