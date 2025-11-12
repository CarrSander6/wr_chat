# IM Chat API 接口文档

## 目录

- [1. 概述](#1-概述)
- [2. im_chat_server API](#2-im_chat_server-api)
  - [2.1 用户相关](#21-用户相关)
  - [2.2 好友相关](#22-好友相关)
  - [2.3 群聊相关](#23-群聊相关)
  - [2.4 私聊消息](#24-私聊消息)
  - [2.5 群聊消息](#25-群聊消息)
  - [2.6 音视频通话](#26-音视频通话)
  - [2.7 红包相关](#27-红包相关)
  - [2.8 文件相关](#28-文件相关)
- [3. im_chat_backstage API](#3-im_chat_backstage-api)
- [4. im-red-package API](#4-im-red-package-api)
- [5. 通用说明](#5-通用说明)

---

## 1. 概述

### 1.1 基本信息

- **协议：** HTTP/HTTPS
- **数据格式：** JSON
- **字符编码：** UTF-8
- **认证方式：** JWT Token

### 1.2 通用请求头

```
Content-Type: application/json
Authorization: Bearer {token}
```

### 1.3 通用响应格式

```json
{
  "code": 200,
  "message": "success",
  "data": {}
}
```

**状态码说明：**
- `200`: 成功
- `400`: 请求参数错误
- `401`: 未授权
- `403`: 无权限
- `500`: 服务器内部错误

---

## 2. im_chat_server API

基础URL: `http://localhost:8080`

### 2.1 用户相关

#### 2.1.1 用户登录

**接口地址：** `POST /login`

**请求参数：**
```json
{
  "username": "string",
  "password": "string"
}
```

**响应示例：**
```json
{
  "code": 200,
  "data": {
    "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "userId": 10001
  }
}
```

#### 2.1.2 用户注册

**接口地址：** `POST /register`

**请求参数：**
```json
{
  "username": "string",
  "password": "string",
  "nickName": "string",
  "email": "string",
  "phone": "string"
}
```

#### 2.1.3 刷新Token

**接口地址：** `PUT /refreshToken`

**请求参数：**
```json
{
  "refreshToken": "string"
}
```

#### 2.1.4 获取当前用户信息

**接口地址：** `GET /user/self`

**响应示例：**
```json
{
  "code": 200,
  "data": {
    "id": 10001,
    "username": "zhangsan",
    "nickName": "张三",
    "headImage": "http://...",
    "email": "zhangsan@example.com",
    "phone": "13800138000",
    "sex": 1,
    "signature": "个性签名",
    "balance": 100.00,
    "isVip": true,
    "vipExpireTime": "2024-12-31 23:59:59"
  }
}
```

#### 2.1.5 修改用户信息

**接口地址：** `PUT /user/update`

**请求参数：**
```json
{
  "nickName": "string",
  "headImage": "string",
  "sex": 1,
  "signature": "string"
}
```

#### 2.1.6 查找用户

**接口地址：** `GET /user/search?name={name}`

**查询参数：**
- `name`: 用户名/昵称/手机/邮箱

**响应示例：**
```json
{
  "code": 200,
  "data": [
    {
      "id": 10001,
      "username": "zhangsan",
      "nickName": "张三",
      "headImage": "http://..."
    }
  ]
}
```

#### 2.1.7 修改密码

**接口地址：** `PUT /modifyPwd`

**请求参数：**
```json
{
  "oldPassword": "string",
  "newPassword": "string"
}
```

#### 2.1.8 设置交易密码

**接口地址：** `PUT /setTradePwd`

**请求参数：**
```json
{
  "tradePassword": "string"
}
```

#### 2.1.9 充值

**接口地址：** `POST /user/recharge`

**请求参数：**
```json
{
  "amount": 100.00,
  "payType": "alipay",
  "chainType": "bsc",
  "fromAddress": "0x..."
}
```

#### 2.1.10 提现

**接口地址：** `POST /user/withdraw`

**请求参数：**
```json
{
  "amount": 50.00,
  "toAddress": "0x...",
  "tradePassword": "string"
}
```

#### 2.1.11 查询资金明细

**接口地址：** `GET /user/queryUserFundDetail?page=1&size=10`

**响应示例：**
```json
{
  "code": 200,
  "data": {
    "total": 100,
    "records": [
      {
        "id": 1,
        "userId": 10001,
        "type": 1,
        "amount": 100.00,
        "balance": 1000.00,
        "remark": "充值",
        "createTime": "2024-01-01 12:00:00"
      }
    ]
  }
}
```

#### 2.1.12 购买VIP

**接口地址：** `POST /user/buyVip`

**请求参数：**
```json
{
  "duration": 30,
  "tradePassword": "string"
}
```

---

### 2.2 好友相关

#### 2.2.1 好友申请

**接口地址：** `POST /friend/request/apply`

**请求参数：**
```json
{
  "friendId": 10002,
  "applyInfo": "我是张三"
}
```

#### 2.2.2 同意好友申请

**接口地址：** `POST /friend/request/approve`

**请求参数：**
```json
{
  "requestId": 1
}
```

#### 2.2.3 拒绝好友申请

**接口地址：** `POST /friend/request/reject`

**请求参数：**
```json
{
  "requestId": 1,
  "reason": "拒绝理由"
}
```

#### 2.2.4 撤回好友申请

**接口地址：** `POST /friend/request/recall`

**请求参数：**
```json
{
  "requestId": 1
}
```

#### 2.2.5 查询好友列表

**接口地址：** `GET /friend/list`

**响应示例：**
```json
{
  "code": 200,
  "data": [
    {
      "id": 10002,
      "username": "lisi",
      "nickName": "李四",
      "headImage": "http://...",
      "remark": "备注名",
      "isOnline": true
    }
  ]
}
```

#### 2.2.6 删除好友

**接口地址：** `DELETE /friend/delete/{friendId}`

**路径参数：**
- `friendId`: 好友ID

#### 2.2.7 修改好友备注

**接口地址：** `PUT /friend/remark`

**请求参数：**
```json
{
  "friendId": 10002,
  "remark": "新备注"
}
```

#### 2.2.8 拉黑好友

**接口地址：** `POST /blacklist/add`

**请求参数：**
```json
{
  "targetId": 10002
}
```

#### 2.2.9 移除黑名单

**接口地址：** `DELETE /blacklist/remove/{targetId}`

---

### 2.3 群聊相关

#### 2.3.1 创建群聊

**接口地址：** `POST /group/create`

**请求参数：**
```json
{
  "groupName": "技术交流群",
  "groupAvatar": "http://...",
  "groupNotice": "群公告内容",
  "memberIds": [10002, 10003, 10004]
}
```

**响应示例：**
```json
{
  "code": 200,
  "data": {
    "id": 1001,
    "groupName": "技术交流群",
    "groupAvatar": "http://...",
    "ownerId": 10001,
    "memberCount": 4
  }
}
```

#### 2.3.2 修改群聊信息

**接口地址：** `PUT /group/modify`

**请求参数：**
```json
{
  "groupId": 1001,
  "groupName": "新群名",
  "groupAvatar": "http://...",
  "groupNotice": "新群公告"
}
```

#### 2.3.3 解散群聊

**接口地址：** `DELETE /group/delete/{groupId}`

**权限：** 仅群主可操作

#### 2.3.4 查询群聊信息

**接口地址：** `GET /group/find/{groupId}`

**响应示例：**
```json
{
  "code": 200,
  "data": {
    "id": 1001,
    "groupName": "技术交流群",
    "groupAvatar": "http://...",
    "groupNotice": "群公告内容",
    "ownerId": 10001,
    "memberCount": 50,
    "createTime": "2024-01-01 12:00:00",
    "isMuted": false,
    "isJoined": true
  }
}
```

#### 2.3.5 查询群聊列表

**接口地址：** `GET /group/list`

**响应示例：**
```json
{
  "code": 200,
  "data": [
    {
      "id": 1001,
      "groupName": "技术交流群",
      "groupAvatar": "http://...",
      "memberCount": 50,
      "unreadCount": 5
    }
  ]
}
```

#### 2.3.6 邀请进群

**接口地址：** `POST /group/invite`

**请求参数：**
```json
{
  "groupId": 1001,
  "memberIds": [10005, 10006]
}
```

#### 2.3.7 主动加入群聊

**接口地址：** `POST /group/join/{groupId}`

#### 2.3.8 查询群成员

**接口地址：** `GET /group/members/{groupId}`

**响应示例：**
```json
{
  "code": 200,
  "data": [
    {
      "userId": 10001,
      "nickName": "张三",
      "headImage": "http://...",
      "role": "OWNER",
      "joinTime": "2024-01-01 12:00:00",
      "isMuted": false
    }
  ]
}
```

#### 2.3.9 移除群成员

**接口地址：** `DELETE /group/members/remove`

**请求参数：**
```json
{
  "groupId": 1001,
  "memberIds": [10005]
}
```

**权限：** 群主或管理员

#### 2.3.10 退出群聊

**接口地址：** `DELETE /group/quit/{groupId}`

#### 2.3.11 开启/关闭全员禁言

**接口地址：** `PUT /group/muted`

**请求参数：**
```json
{
  "groupId": 1001,
  "isMuted": true
}
```

**权限：** 群主或管理员

#### 2.3.12 对群成员禁言

**接口地址：** `PUT /group/members/muted`

**请求参数：**
```json
{
  "groupId": 1001,
  "userId": 10005,
  "isMuted": true,
  "duration": 3600
}
```

#### 2.3.13 设置群置顶消息

**接口地址：** `POST /group/setTopMessage/{groupId}`

**请求参数：**
```json
{
  "content": "重要通知内容"
}
```

#### 2.3.14 移除群置顶消息

**接口地址：** `DELETE /group/removeTopMessage/{groupId}`

#### 2.3.15 新增管理员

**接口地址：** `POST /group/manager/add`

**请求参数：**
```json
{
  "groupId": 1001,
  "userId": 10005
}
```

**权限：** 仅群主

#### 2.3.16 移除管理员

**接口地址：** `DELETE /group/manager/remove`

**请求参数：**
```json
{
  "groupId": 1001,
  "userId": 10005
}
```

#### 2.3.17 开启/关闭免打扰

**接口地址：** `PUT /group/dnd`

**请求参数：**
```json
{
  "groupId": 1001,
  "isDnd": true
}
```

---

### 2.4 私聊消息

#### 2.4.1 发送私聊消息

**说明：** 消息通过WebSocket发送，此处仅列出消息格式

**消息格式：**
```json
{
  "type": "PRIVATE_MESSAGE",
  "data": {
    "receiverId": 10002,
    "content": "消息内容",
    "messageType": 1,
    "atUserIds": []
  }
}
```

**消息类型：**
- `1`: 文本消息
- `2`: 图片消息
- `3`: 语音消息
- `4`: 视频消息
- `5`: 文件消息
- `6`: 位置消息

#### 2.4.2 撤回消息

**接口地址：** `DELETE /message/private/recall/{id}`

**路径参数：**
- `id`: 消息ID

**说明：** 仅支持撤回2分钟内的消息

#### 2.4.3 拉取离线消息

**接口地址：** `GET /message/private/pullOfflineMessage`

**响应示例：**
```json
{
  "code": 200,
  "data": [
    {
      "id": 10001,
      "senderId": 10002,
      "receiverId": 10001,
      "content": "你好",
      "messageType": 1,
      "sendTime": "2024-01-01 12:00:00",
      "status": 1
    }
  ]
}
```

#### 2.4.4 消息已读

**接口地址：** `PUT /message/private/readed`

**请求参数：**
```json
{
  "friendId": 10002,
  "maxMessageId": 10001
}
```

#### 2.4.5 获取最大已读消息ID

**接口地址：** `GET /message/private/maxReadedId?friendId={friendId}`

#### 2.4.6 查询历史消息

**接口地址：** `GET /message/private/history?friendId={friendId}&page=1&size=20`

**查询参数：**
- `friendId`: 好友ID
- `page`: 页码
- `size`: 每页数量

---

### 2.5 群聊消息

#### 2.5.1 发送群聊消息

**消息格式：**
```json
{
  "type": "GROUP_MESSAGE",
  "data": {
    "groupId": 1001,
    "content": "消息内容",
    "messageType": 1,
    "atUserIds": [10002, 10003]
  }
}
```

#### 2.5.2 撤回群聊消息

**接口地址：** `DELETE /message/group/recall/{id}`

**权限：** 消息发送者、群主、管理员

#### 2.5.3 拉取离线消息

**接口地址：** `GET /message/group/pullOfflineMessage`

#### 2.5.4 消息已读

**接口地址：** `PUT /message/group/readed`

**请求参数：**
```json
{
  "groupId": 1001,
  "maxMessageId": 10001
}
```

#### 2.5.5 获取已读用户列表

**接口地址：** `GET /message/group/findReadedUsers?messageId={messageId}`

**响应示例：**
```json
{
  "code": 200,
  "data": [
    {
      "userId": 10002,
      "nickName": "李四",
      "headImage": "http://...",
      "readTime": "2024-01-01 12:01:00"
    }
  ]
}
```

#### 2.5.6 查询历史消息

**接口地址：** `GET /message/group/history?groupId={groupId}&page=1&size=20`

---

### 2.6 音视频通话

#### 2.6.1 单人通话

##### 呼叫视频通话

**接口地址：** `POST /webrtc/private/setup`

**请求参数：**
```json
{
  "friendId": 10002,
  "mode": 1
}
```

**通话模式：**
- `1`: 视频通话
- `2`: 语音通话

##### 接受通话

**接口地址：** `POST /webrtc/private/accept`

**请求参数：**
```json
{
  "callId": "uuid"
}
```

##### 拒绝通话

**接口地址：** `POST /webrtc/private/reject`

**请求参数：**
```json
{
  "callId": "uuid",
  "reason": "拒绝原因"
}
```

##### 取消呼叫

**接口地址：** `POST /webrtc/private/cancel`

**请求参数：**
```json
{
  "callId": "uuid"
}
```

##### 挂断

**接口地址：** `POST /webrtc/private/handup`

**请求参数：**
```json
{
  "callId": "uuid"
}
```

##### 推送Offer信息

**接口地址：** `POST /webrtc/private/offer`

**请求参数：**
```json
{
  "callId": "uuid",
  "offer": "sdp内容"
}
```

##### 推送Answer信息

**接口地址：** `POST /webrtc/private/answer`

**请求参数：**
```json
{
  "callId": "uuid",
  "answer": "sdp内容"
}
```

##### 同步Candidate

**接口地址：** `POST /webrtc/private/heartbeat`

**请求参数：**
```json
{
  "callId": "uuid",
  "candidate": "candidate内容"
}
```

#### 2.6.2 群组通话

##### 发起群视频通话

**接口地址：** `POST /webrtc/group/setup`

**请求参数：**
```json
{
  "groupId": 1001,
  "mode": 1
}
```

##### 接受通话

**接口地址：** `POST /webrtc/group/accept`

**请求参数：**
```json
{
  "callId": "uuid"
}
```

##### 拒绝通话

**接口地址：** `POST /webrtc/group/reject`

**请求参数：**
```json
{
  "callId": "uuid"
}
```

##### 加入通话

**接口地址：** `POST /webrtc/group/join`

**请求参数：**
```json
{
  "callId": "uuid"
}
```

##### 挂断

**接口地址：** `POST /webrtc/group/handup`

**请求参数：**
```json
{
  "callId": "uuid"
}
```

---

### 2.7 红包相关

#### 2.7.1 发红包

**接口地址：** `POST /redPackage/send`

**请求参数：**
```json
{
  "receiverType": 1,
  "receiverId": 1001,
  "totalAmount": 100.00,
  "totalCount": 10,
  "redPacketType": 1,
  "remark": "恭喜发财",
  "tradePassword": "string"
}
```

**红包类型：**
- `1`: 拼手气红包
- `2`: 普通红包

**接收者类型：**
- `1`: 群红包
- `2`: 私聊红包

#### 2.7.2 抢红包

**接口地址：** `POST /redPackage/rob`

**请求参数：**
```json
{
  "redPacketId": "uuid"
}
```

**响应示例：**
```json
{
  "code": 200,
  "data": {
    "amount": 8.88,
    "remainCount": 9,
    "remainAmount": 91.12
  }
}
```

---

### 2.8 文件相关

#### 2.8.1 上传文件

**接口地址：** `POST /file/upload`

**请求类型：** multipart/form-data

**请求参数：**
- `file`: 文件
- `type`: 文件类型 (image/video/file/voice)

**响应示例：**
```json
{
  "code": 200,
  "data": {
    "url": "http://...",
    "fileName": "test.jpg",
    "fileSize": 102400
  }
}
```

#### 2.8.2 下载文件

**接口地址：** `GET /file/download?url={url}`

---

### 2.9 系统相关

#### 2.9.1 获取验证码

**接口地址：** `GET /captcha`

**响应示例：**
```json
{
  "code": 200,
  "data": {
    "captchaId": "uuid",
    "captchaImage": "base64..."
  }
}
```

#### 2.9.2 加载系统配置

**接口地址：** `GET /system/config`

**响应示例：**
```json
{
  "code": 200,
  "data": {
    "version": "3.0.0",
    "minVersion": "2.5.0",
    "downloadUrl": "http://..."
  }
}
```

#### 2.9.3 用户投诉

**接口地址：** `POST /complaint/submit`

**请求参数：**
```json
{
  "targetType": 1,
  "targetId": 10002,
  "reason": "投诉原因",
  "description": "详细描述",
  "images": ["http://..."]
}
```

**投诉类型：**
- `1`: 用户
- `2`: 群组

---

## 3. im_chat_backstage API

基础URL: `http://localhost:8081`

### 3.1 用户管理

#### 3.1.1 账号封禁

**接口地址：** `PUT /im/user/ban`

**请求参数：**
```json
{
  "userId": 10001,
  "reason": "违规原因",
  "duration": 7
}
```

#### 3.1.2 账号解封

**接口地址：** `PUT /im/user/unban`

**请求参数：**
```json
{
  "userId": 10001
}
```

#### 3.1.3 根据用户名查找用户

**接口地址：** `GET /im/user/findByName?name={name}`

#### 3.1.4 根据ID列表查找用户

**接口地址：** `POST /im/user/findByIds`

**请求参数：**
```json
{
  "userIds": [10001, 10002, 10003]
}
```

---

### 3.2 群组管理

#### 3.2.1 群组封禁

**接口地址：** `PUT /im/group/ban`

**请求参数：**
```json
{
  "groupId": 1001,
  "reason": "违规原因"
}
```

#### 3.2.2 群组解封

**接口地址：** `PUT /im/group/unban`

**请求参数：**
```json
{
  "groupId": 1001
}
```

#### 3.2.3 查询群成员列表

**接口地址：** `GET /im/group/member/list?groupId={groupId}&page=1&size=20`

---

### 3.3 敏感词管理

**说明：** 后台管理系统还包含敏感词管理、消息监控、投诉处理、充值提现审核等功能，具体接口可通过SpringDoc文档查看。

---

## 4. im-red-package API

基础URL: `http://localhost:8082`

### 4.1 发红包

**接口地址：** `POST /red/packet/hand/out`

**请求参数：**
```json
{
  "userId": 10001,
  "total": 100.00,
  "count": 10,
  "type": 1
}
```

**红包类型：**
- `1`: 拼手气红包
- `2`: 普通红包

**响应示例：**
```json
{
  "code": 200,
  "message": "success",
  "data": "red_packet_uuid"
}
```

### 4.2 抢红包

**接口地址：** `POST /red/packet/rob`

**请求参数：**
```json
{
  "userId": 10002,
  "redId": "red_packet_uuid"
}
```

**响应示例：**
```json
{
  "code": 200,
  "message": "success",
  "data": 8.88
}
```

### 4.3 查询是否已抢

**接口地址：** `POST /red/packet/isRob`

**请求参数：**
```json
{
  "userId": 10002,
  "redId": "red_packet_uuid"
}
```

**响应示例：**
```json
{
  "code": 200,
  "message": "success",
  "data": true
}
```

---

## 5. 通用说明

### 5.1 WebSocket连接

**连接地址：** `ws://localhost:8081/ws`

**连接参数：**
- `accessToken`: JWT Token

**消息格式：**
```json
{
  "type": "MESSAGE_TYPE",
  "data": {}
}
```

**消息类型：**
- `HEARTBEAT`: 心跳
- `PRIVATE_MESSAGE`: 私聊消息
- `GROUP_MESSAGE`: 群聊消息
- `FRIEND_REQUEST`: 好友申请
- `SYSTEM_MESSAGE`: 系统消息
- `RTC_CALL`: 音视频通话信令

### 5.2 分页参数

大部分列表接口支持分页查询：

- `page`: 页码，从1开始
- `size`: 每页数量，默认20，最大100

### 5.3 时间格式

所有时间字段统一使用格式：`yyyy-MM-dd HH:mm:ss`

### 5.4 错误码

| 错误码 | 说明 |
|-------|------|
| 200 | 成功 |
| 400 | 请求参数错误 |
| 401 | 未授权，Token无效或过期 |
| 403 | 无权限访问 |
| 404 | 资源不存在 |
| 500 | 服务器内部错误 |
| 1001 | 用户不存在 |
| 1002 | 密码错误 |
| 1003 | 用户已被封禁 |
| 2001 | 好友关系不存在 |
| 2002 | 已经是好友 |
| 3001 | 群组不存在 |
| 3002 | 不是群成员 |
| 3003 | 权限不足 |
| 4001 | 余额不足 |
| 4002 | 交易密码错误 |
| 5001 | 红包已抢完 |
| 5002 | 已抢过该红包 |

### 5.5 API文档访问

- **im_chat_server Swagger文档：** `http://localhost:8080/doc.html`
- **im_chat_backstage Swagger文档：** `http://localhost:8081/doc.html`

### 5.6 开发建议

1. 使用环境变量管理不同环境的配置
2. Token过期后自动刷新
3. 实现请求重试机制
4. 合理使用缓存减少API调用
5. 注意接口限流，避免频繁调用
6. WebSocket断线重连机制
7. 文件上传前进行大小和类型校验

---

## 附录

### A. 消息状态

- `0`: 未发送
- `1`: 已发送
- `2`: 已送达
- `3`: 已读

### B. 群成员角色

- `OWNER`: 群主
- `MANAGER`: 管理员
- `MEMBER`: 普通成员

### C. 在线状态

- `ONLINE`: 在线
- `OFFLINE`: 离线
- `BUSY`: 忙碌
- `AWAY`: 离开

---

**文档版本：** v3.0.0  
**最后更新：** 2024-11-12  
**维护者：** IM Chat Team
