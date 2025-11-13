/**
 * 前端性能监控工具
 * 
 * @author Blue
 * @date 2024
 */

interface PerformanceMetric {
  name: string;
  startTime: number;
  endTime?: number;
  duration?: number;
}

class PerformanceMonitor {
  private metrics: Map<string, PerformanceMetric> = new Map();
  private apiMetrics: Map<string, number[]> = new Map();

  /**
   * 开始性能监控
   */
  startMetric(name: string): void {
    this.metrics.set(name, {
      name,
      startTime: performance.now()
    });
  }

  /**
   * 结束性能监控
   */
  endMetric(name: string): number | undefined {
    const metric = this.metrics.get(name);
    if (metric) {
      metric.endTime = performance.now();
      metric.duration = metric.endTime - metric.startTime;
      
      // 慢操作预警（超过1秒）
      if (metric.duration > 1000) {
        console.warn(`[性能预警] ${name} 耗时: ${metric.duration.toFixed(2)}ms`);
      }
      
      return metric.duration;
    }
    return undefined;
  }

  /**
   * 记录API响应时间
   */
  recordApiMetric(url: string, duration: number): void {
    if (!this.apiMetrics.has(url)) {
      this.apiMetrics.set(url, []);
    }
    this.apiMetrics.get(url)!.push(duration);
  }

  /**
   * 获取API平均响应时间
   */
  getAvgApiTime(url: string): number {
    const times = this.apiMetrics.get(url);
    if (!times || times.length === 0) {
      return 0;
    }
    const sum = times.reduce((a, b) => a + b, 0);
    return sum / times.length;
  }

  /**
   * 获取所有指标
   */
  getAllMetrics(): PerformanceMetric[] {
    return Array.from(this.metrics.values());
  }

  /**
   * 清除指标
   */
  clearMetrics(): void {
    this.metrics.clear();
    this.apiMetrics.clear();
  }

  /**
   * 获取页面性能指标
   */
  getPagePerformance(): any {
    if (!window.performance || !window.performance.timing) {
      return null;
    }

    const timing = window.performance.timing;
    const performanceData = {
      // 页面加载时间
      loadTime: timing.loadEventEnd - timing.fetchStart,
      // DNS查询时间
      dnsTime: timing.domainLookupEnd - timing.domainLookupStart,
      // TCP连接时间
      tcpTime: timing.connectEnd - timing.connectStart,
      // 请求响应时间
      requestTime: timing.responseEnd - timing.requestStart,
      // DOM解析时间
      domParseTime: timing.domInteractive - timing.domLoading,
      // 白屏时间
      whiteScreenTime: timing.responseStart - timing.fetchStart,
      // 首屏时间
      firstScreenTime: timing.domContentLoadedEventEnd - timing.fetchStart
    };

    return performanceData;
  }
}

// 导出单例
export const performanceMonitor = new PerformanceMonitor();

/**
 * 性能监控装饰器
 */
export function measurePerformance(name?: string) {
  return function (target: any, propertyKey: string, descriptor: PropertyDescriptor) {
    const originalMethod = descriptor.value;
    const metricName = name || `${target.constructor.name}.${propertyKey}`;

    descriptor.value = async function (...args: any[]) {
      performanceMonitor.startMetric(metricName);
      try {
        const result = await originalMethod.apply(this, args);
        return result;
      } finally {
        performanceMonitor.endMetric(metricName);
      }
    };

    return descriptor;
  };
}

export default performanceMonitor;
