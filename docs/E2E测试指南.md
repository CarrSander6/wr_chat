# E2E 测试指南

## 概述

本文档介绍项目中的端到端（E2E）测试框架和使用方法。

## 测试框架

### 后端测试

后端使用 Spring Boot Test 和 JUnit 5 进行测试。

#### 测试类型

1. **单元测试**
   - 位置: `im_chat_server/im-platform/src/test/java/.../service/`
   - 示例: `MatchRecommendServiceImplTest.java`

2. **E2E测试**
   - 位置: `im_chat_server/im-platform/src/test/java/.../e2e/`
   - 基类: `E2ETestBase.java`
   - 示例: `UserE2ETest.java`

3. **负载测试**
   - 位置: `im_chat_server/im-platform/src/test/java/.../load/`
   - 基类: `LoadTestBase.java`
   - 示例: `CacheLoadTest.java`

### 前端测试

前端可以使用 Playwright 进行 E2E 测试。

#### 安装 Playwright

```bash
# 管理后台
cd im_chat_backstage_ui
npm install --save-dev @playwright/test

# Web客户端
cd im_chat_web
npm install --save-dev @playwright/test
```

#### 运行测试

```bash
# 运行所有测试
npx playwright test

# 运行特定测试文件
npx playwright test tests/e2e/admin.spec.ts

# 调试模式
npx playwright test --debug
```

## 性能监控

### 后端性能监控

系统已集成性能监控切面，自动记录 Controller 和 Service 层的执行时间。

#### 监控指标

- 方法执行时间
- 慢方法预警（>1秒）
- API 响应时间统计

#### 查看监控数据

访问监控接口：
```
GET /monitor/metrics/all
GET /monitor/metrics/health
```

### 前端性能监控

前端提供了性能监控工具类。

#### 使用方法

```typescript
// 管理后台 (TypeScript)
import { performanceMonitor } from '@/utils/performance';

// 开始监控
performanceMonitor.startMetric('loadUserList');

// 执行操作
await loadUsers();

// 结束监控
performanceMonitor.endMetric('loadUserList');

// 获取页面性能
const pagePerf = performanceMonitor.getPagePerformance();
console.log('页面加载时间:', pagePerf.loadTime);
```

```javascript
// Web客户端 (JavaScript)
import performanceMonitor from '@/utils/performance';

// 记录API响应时间
performanceMonitor.recordApiMetric('/api/users', 150);

// 获取平均响应时间
const avgTime = performanceMonitor.getAvgApiTime('/api/users');
```

## 负载测试

### 编写负载测试

继承 `LoadTestBase` 类：

```java
public class MyLoadTest extends LoadTestBase {
    
    @Test
    public void testMyFeature() {
        Runnable task = () -> {
            // 测试任务
            myService.doSomething();
        };
        
        // 执行负载测试：100并发，1000次请求
        LoadTestResult result = executeLoadTest(100, 1000, task);
        result.print();
        
        // 断言性能指标
        assert result.getAvgResponseTime() < 100;
    }
}
```

### 性能指标

负载测试会输出以下指标：
- 并发用户数
- 总请求数
- 成功/失败请求数
- 总耗时
- 平均响应时间
- 吞吐量（req/s）

## 最佳实践

### 测试原则

1. **独立性**: 每个测试应该独立运行，不依赖其他测试
2. **可重复性**: 测试结果应该是确定的和可重复的
3. **清晰性**: 测试代码应该清晰易读
4. **快速反馈**: 测试应该尽快完成，提供快速反馈

### 测试覆盖

建议覆盖以下场景：
- 核心业务流程（用户注册、登录、聊天等）
- 边界条件测试
- 错误处理测试
- 性能关键路径测试

### 持续集成

建议在 CI/CD 流程中集成自动化测试：

```yaml
# GitHub Actions 示例
- name: Run Backend Tests
  run: cd im_chat_server && mvn test

- name: Run Frontend Tests
  run: cd im_chat_backstage_ui && npm test
```

## 常见问题

### Q: 测试需要数据库吗？

A: E2E 测试建议使用测试数据库或内存数据库（如 H2）。可以在 `application-test.yml` 中配置测试数据源。

### Q: 如何模拟用户认证？

A: 在测试基类中提供 `getTestUserToken()` 方法，可以生成测试用的 token。

### Q: 负载测试会影响生产环境吗？

A: 不会。负载测试应该在测试环境运行，不要在生产环境执行。

## 相关文档

- [API测试指南](./API测试指南.md)
- [性能优化指南](./性能优化指南.md)
- [部署指南](./部署指南-社交匹配与分销商城.md)
