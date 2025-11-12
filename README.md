# IM Chat - 即时通讯系统

一个功能完整的即时通讯系统，支持单聊、群聊、音视频通话、红包等核心功能。

## 📖 项目文档

完整的项目文档已生成，请访问以下链接查看：

- **[📚 文档中心](./docs/README.md)** - 文档索引和快速导航
- **[📋 项目说明文档](./docs/项目说明文档.md)** - 详细的项目架构和子项目说明
- **[🔌 API接口文档](./docs/API接口文档.md)** - 完整的后端API接口文档

## 🚀 快速开始

### 环境要求

- JDK 8/17/21（根据具体模块）
- Maven 3.6+
- MySQL 8.0+
- Redis 6.0+
- Node.js 16+

### 启动服务

```bash
# 1. 启动数据库
mysql.server start
redis-server

# 2. 启动IM服务器
cd im_chat_server && mvn spring-boot:run

# 3. 启动Web客户端
cd im_chat_web && npm install && npm run serve
```

### 访问应用

- Web客户端: http://localhost:8082
- API文档: http://localhost:8080/doc.html
- 管理后台: http://localhost:8083

## 📦 项目结构

```
wr_chat/
├── docs/                        # 📚 项目文档
│   ├── README.md                # 文档索引
│   ├── 项目说明文档.md           # 项目说明
│   └── API接口文档.md            # API文档
├── im_chat_server/              # IM聊天核心服务端 (Java 17)
├── im_chat_backstage/           # 后台管理系统 (Java 21)
├── im_chat_backstage_ui/        # 管理后台前端 (Vue 3)
├── im_chat_web/                 # Web聊天客户端 (Vue 2)
├── im_chat_uniapp/              # 移动端应用 (uni-app)
├── im-red-package/              # 红包服务 (Java 8)
├── im-webview-group-rtc/        # 群组音视频 (Vue 2)
└── im-webview-private-rtc/      # 私聊音视频 (Vue 2)
```

## ✨ 核心功能

### 即时通讯
- ✅ 单聊/群聊
- ✅ 文本/图片/语音/视频消息
- ✅ 消息撤回
- ✅ 离线消息
- ✅ 消息已读回执

### 音视频通话
- ✅ 一对一音视频通话
- ✅ 多人视频会议
- ✅ 通话邀请/接受/拒绝

### 红包功能
- ✅ 普通红包/拼手气红包
- ✅ 群红包/私聊红包
- ✅ 高并发抢红包

### 后台管理
- ✅ 用户管理
- ✅ 群组管理
- ✅ 消息监控
- ✅ 敏感词过滤

## 🛠️ 技术栈

**后端：** Spring Boot · MyBatis Plus · Redis · WebSocket · Netty  
**前端：** Vue 2/3 · Element UI/Plus · uni-app · Electron  
**数据库：** MySQL · Redis  
**文件存储：** MinIO

## 📝 开发指南

详细的开发指南请查看 [项目说明文档](./docs/项目说明文档.md)

## 📞 联系方式

如有问题，请提交Issue或Pull Request。

## 📄 许可证

本项目采用 MIT 许可证。
