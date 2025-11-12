# API测试指南

本文档提供社交匹配与分销商城功能的API测试示例。

## 环境配置

- **BaseURL**: `http://localhost:8888/api`
- **Content-Type**: `application/json`
- **Authorization**: Bearer Token (从登录接口获取)

## 测试流程

### 1. 用户登录

```http
POST /user/login
Content-Type: application/json

{
  "username": "testuser",
  "password": "123456"
}
```

响应:
```json
{
  "code": 200,
  "data": {
    "accessToken": "eyJhbGc...",
    "refreshToken": "eyJhbGc..."
  }
}
```

### 2. 社交匹配测试

#### 2.1 获取推荐用户

```http
GET /match/candidates?limit=10
Authorization: Bearer {accessToken}
```

#### 2.2 喜欢用户

```http
POST /match/action
Authorization: Bearer {accessToken}
Content-Type: application/json

{
  "targetUserId": 123,
  "actionType": 1
}
```

响应: `true` 表示匹配成功, `false` 表示未匹配

#### 2.3 获取匹配历史

```http
GET /match/history?actionType=1&pageNum=1&pageSize=20
Authorization: Bearer {accessToken}
```

#### 2.4 获取已匹配用户

```http
GET /match/matched
Authorization: Bearer {accessToken}
```

### 3. 智能推荐测试

#### 3.1 智能推荐

```http
GET /match/recommend/smart?limit=10
Authorization: Bearer {accessToken}
```

#### 3.2 兴趣推荐

```http
GET /match/recommend/by-interest?limit=10
Authorization: Bearer {accessToken}
```

#### 3.3 附近的人

```http
GET /match/recommend/nearby?longitude=113.23&latitude=23.16&radius=10&limit=10
Authorization: Bearer {accessToken}
```

#### 3.4 计算匹配度

```http
GET /match/recommend/match-score?targetUserId=123
Authorization: Bearer {accessToken}
```

### 4. 分销系统测试

#### 4.1 激活分销商

```http
POST /distribution/activate
Authorization: Bearer {accessToken}
Content-Type: application/json

{
  "referralCode": "ABC12345"
}
```

响应:
```json
{
  "code": 200,
  "data": "DEF67890"  // 新生成的推广码
}
```

#### 4.2 获取分销商信息

```http
GET /distribution/info
Authorization: Bearer {accessToken}
```

#### 4.3 获取佣金列表

```http
GET /distribution/commission/list?pageNum=1&pageSize=20
Authorization: Bearer {accessToken}
```

#### 4.4 佣金提现

```http
POST /distribution/commission/withdraw
Authorization: Bearer {accessToken}
Content-Type: application/json

{
  "amount": 100.00,
  "tradePassword": "123456"
}
```

### 5. 分销统计测试

#### 5.1 统计概览

```http
GET /distribution/statistics/overview
Authorization: Bearer {accessToken}
```

#### 5.2 团队列表

```http
GET /distribution/statistics/team?level=1&pageNum=1&pageSize=20
Authorization: Bearer {accessToken}
```

#### 5.3 每日统计

```http
GET /distribution/statistics/daily?days=7
Authorization: Bearer {accessToken}
```

#### 5.4 排行榜

```http
GET /distribution/statistics/ranking?type=1&limit=10
Authorization: Bearer {accessToken}
```

#### 5.5 预估佣金

```http
GET /distribution/statistics/estimate?productId=1&quantity=1
Authorization: Bearer {accessToken}
```

### 6. 商城系统测试

#### 6.1 获取商品列表

```http
GET /mall/product/list?pageNum=1&pageSize=20
Authorization: Bearer {accessToken}
```

#### 6.2 获取商品详情

```http
GET /mall/product/1
Authorization: Bearer {accessToken}
```

#### 6.3 创建订单(余额支付)

```http
POST /mall/order/create
Authorization: Bearer {accessToken}
Content-Type: application/json

{
  "productId": 1,
  "quantity": 1,
  "paymentMethod": 1,
  "referrerUserId": 100
}
```

#### 6.4 创建订单(iOS内购)

```http
POST /mall/order/create
Authorization: Bearer {accessToken}
Content-Type: application/json

{
  "productId": 1,
  "quantity": 1,
  "paymentMethod": 2,
  "iosReceipt": "base64_encoded_receipt_data",
  "referrerUserId": 100
}
```

#### 6.5 获取订单列表

```http
GET /mall/order/list?pageNum=1&pageSize=20
Authorization: Bearer {accessToken}
```

#### 6.6 获取订单详情

```http
GET /mall/order/1
Authorization: Bearer {accessToken}
```

#### 6.7 支付订单(余额)

```http
POST /mall/order/pay/1
Authorization: Bearer {accessToken}
```

#### 6.8 支付订单(iOS)

```http
POST /mall/order/pay/1?iosReceipt=base64_encoded_receipt_data
Authorization: Bearer {accessToken}
```

#### 6.9 取消订单

```http
POST /mall/order/cancel/1
Authorization: Bearer {accessToken}
```

## 测试场景

### 场景1: 完整的匹配流程

1. 用户A登录
2. 用户A获取推荐用户列表
3. 用户A喜欢用户B
4. 用户B登录
5. 用户B喜欢用户A
6. 系统自动创建匹配关系
7. 双方可以查看已匹配用户列表

### 场景2: 完整的分销流程

1. 用户A激活为分销商,获得推广码
2. 用户B使用用户A的推广码注册/激活
3. 用户B购买支持分销的商品
4. 系统自动为用户A计算并分配佣金
5. 用户A查看佣金明细
6. 用户A申请提现

### 场景3: 二级分销流程

1. 用户A激活为分销商
2. 用户B使用A的推广码激活(B是A的一级)
3. 用户C使用B的推广码激活(C是B的一级,A的二级)
4. 用户C购买商品
5. 系统为B分配一级佣金,为A分配二级佣金

## 错误处理

常见错误码:

- `400`: 请求参数错误
- `401`: 未授权,需要登录
- `403`: 无权限访问
- `404`: 资源不存在
- `500`: 服务器内部错误

错误响应格式:
```json
{
  "code": 400,
  "message": "参数错误"
}
```

## 性能测试

### 并发测试

使用JMeter或Apache Bench进行并发测试:

```bash
# 测试匹配接口并发性能
ab -n 1000 -c 100 -H "Authorization: Bearer {token}" \
   http://localhost:8888/api/match/candidates?limit=10

# 测试商品列表并发性能
ab -n 1000 -c 100 -H "Authorization: Bearer {token}" \
   http://localhost:8888/api/mall/product/list?pageNum=1&pageSize=20
```

### 压力测试

监控以下指标:
- 响应时间(平均/最大/最小)
- 吞吐量(TPS/QPS)
- 错误率
- CPU使用率
- 内存使用率
- 数据库连接数

## Postman Collection

导入以下JSON到Postman:

```json
{
  "info": {
    "name": "社交匹配与分销商城API",
    "schema": "https://schema.getpostman.com/json/collection/v2.1.0/collection.json"
  },
  "item": [
    {
      "name": "社交匹配",
      "item": [
        {
          "name": "获取推荐用户",
          "request": {
            "method": "GET",
            "header": [],
            "url": {
              "raw": "{{baseUrl}}/match/candidates?limit=10",
              "host": ["{{baseUrl}}"],
              "path": ["match", "candidates"],
              "query": [{"key": "limit", "value": "10"}]
            }
          }
        }
      ]
    }
  ],
  "variable": [
    {
      "key": "baseUrl",
      "value": "http://localhost:8888/api"
    }
  ]
}
```

## 自动化测试

使用Jest或Mocha编写自动化测试脚本:

```javascript
describe('社交匹配API测试', () => {
  let accessToken;
  
  beforeAll(async () => {
    // 登录获取token
    const response = await request(app)
      .post('/user/login')
      .send({ username: 'test', password: '123456' });
    accessToken = response.body.data.accessToken;
  });

  test('获取推荐用户', async () => {
    const response = await request(app)
      .get('/match/candidates?limit=10')
      .set('Authorization', `Bearer ${accessToken}`);
    
    expect(response.status).toBe(200);
    expect(response.body.code).toBe(200);
    expect(Array.isArray(response.body.data)).toBe(true);
  });

  // 更多测试用例...
});
```

## 数据库验证

测试后验证数据库数据:

```sql
-- 验证匹配记录
SELECT * FROM im_user_match_record 
WHERE user_id = 1 
ORDER BY created_time DESC LIMIT 10;

-- 验证佣金记录
SELECT * FROM im_distribution_commission 
WHERE distributor_user_id = 1 
ORDER BY created_time DESC LIMIT 10;

-- 验证订单状态
SELECT * FROM im_mall_order 
WHERE user_id = 1 
ORDER BY created_time DESC LIMIT 10;
```
