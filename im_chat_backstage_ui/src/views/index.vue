<template>
  <div class="app-container home">
    <el-row :gutter="20">
      <el-col :sm="24" :lg="24" style="padding-left: 20px">
        <h2>IM 后台管理系统</h2>
        <h4>IM是一个功能完整的即时通讯系统，支持私聊、群聊、离线消息、发送图片、文件、语音、emoji表情、音视频通话等功能</h4>
      </el-col>
    </el-row>
    <el-divider />
    
    <!-- Statistics Cards -->
    <el-row :gutter="20" class="stats-row">
      <el-col :xs="24" :sm="12" :lg="6">
        <el-card shadow="hover" class="stat-card">
          <div class="stat-content">
            <div class="stat-icon" style="background-color: #409EFF;">
              <el-icon :size="30"><User /></el-icon>
            </div>
            <div class="stat-info">
              <div class="stat-value">{{ stats.totalUsers }}</div>
              <div class="stat-label">总用户数</div>
            </div>
          </div>
        </el-card>
      </el-col>
      
      <el-col :xs="24" :sm="12" :lg="6">
        <el-card shadow="hover" class="stat-card">
          <div class="stat-content">
            <div class="stat-icon" style="background-color: #67C23A;">
              <el-icon :size="30"><ChatDotRound /></el-icon>
            </div>
            <div class="stat-info">
              <div class="stat-value">{{ stats.totalGroups }}</div>
              <div class="stat-label">总群组数</div>
            </div>
          </div>
        </el-card>
      </el-col>
      
      <el-col :xs="24" :sm="12" :lg="6">
        <el-card shadow="hover" class="stat-card">
          <div class="stat-content">
            <div class="stat-icon" style="background-color: #E6A23C;">
              <el-icon :size="30"><ChatLineRound /></el-icon>
            </div>
            <div class="stat-info">
              <div class="stat-value">{{ stats.totalMessages }}</div>
              <div class="stat-label">消息总数</div>
            </div>
          </div>
        </el-card>
      </el-col>
      
      <el-col :xs="24" :sm="12" :lg="6">
        <el-card shadow="hover" class="stat-card">
          <div class="stat-content">
            <div class="stat-icon" style="background-color: #F56C6C;">
              <el-icon :size="30"><Connection /></el-icon>
            </div>
            <div class="stat-info">
              <div class="stat-value">{{ stats.onlineUsers }}</div>
              <div class="stat-label">在线用户</div>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <!-- Quick Links -->
    <el-row :gutter="20" class="quick-links-row">
      <el-col :span="24">
        <h3>快速访问</h3>
      </el-col>
      <el-col :xs="24" :sm="12" :lg="6">
        <el-card shadow="hover" class="link-card" @click="goTarget('/im/user/index')">
          <div class="link-content">
            <el-icon :size="40" color="#409EFF"><User /></el-icon>
            <div class="link-title">用户管理</div>
            <div class="link-desc">管理系统用户信息</div>
          </div>
        </el-card>
      </el-col>
      
      <el-col :xs="24" :sm="12" :lg="6">
        <el-card shadow="hover" class="link-card" @click="goTarget('/im/group/index')">
          <div class="link-content">
            <el-icon :size="40" color="#67C23A"><ChatDotRound /></el-icon>
            <div class="link-title">群组管理</div>
            <div class="link-desc">管理聊天群组信息</div>
          </div>
        </el-card>
      </el-col>
      
      <el-col :xs="24" :sm="12" :lg="6">
        <el-card shadow="hover" class="link-card" @click="goTarget('/im/message/private/index')">
          <div class="link-content">
            <el-icon :size="40" color="#E6A23C"><ChatLineRound /></el-icon>
            <div class="link-title">消息记录</div>
            <div class="link-desc">查看聊天消息记录</div>
          </div>
        </el-card>
      </el-col>
      
      <el-col :xs="24" :sm="12" :lg="6">
        <el-card shadow="hover" class="link-card" @click="goTarget('/im/sensitiveWord/index')">
          <div class="link-content">
            <el-icon :size="40" color="#F56C6C"><Warning /></el-icon>
            <div class="link-title">敏感词管理</div>
            <div class="link-desc">配置敏感词过滤</div>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <!-- System Info -->
    <el-row :gutter="20" class="system-info-row">
      <el-col :span="24">
        <el-card shadow="hover">
          <template #header>
            <div class="card-header">
              <span>系统信息</span>
            </div>
          </template>
          <el-descriptions :column="2" border>
            <el-descriptions-item label="系统名称">IM 即时通讯系统</el-descriptions-item>
            <el-descriptions-item label="系统版本">v3.0</el-descriptions-item>
            <el-descriptions-item label="后端框架">Spring Boot + Netty</el-descriptions-item>
            <el-descriptions-item label="前端框架">Vue 3 + Element Plus</el-descriptions-item>
            <el-descriptions-item label="数据库">MySQL + Redis</el-descriptions-item>
            <el-descriptions-item label="消息队列">支持</el-descriptions-item>
          </el-descriptions>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script setup name="Index" lang="ts">
import { ref, onMounted } from 'vue';
import { User, ChatDotRound, ChatLineRound, Connection, Warning } from '@element-plus/icons-vue';
import { useRouter } from 'vue-router';

const router = useRouter();

const stats = ref({
  totalUsers: 0,
  totalGroups: 0,
  totalMessages: 0,
  onlineUsers: 0
});

const goTarget = (path: string) => {
  router.push(path);
};

// Simulate loading statistics (in real app, fetch from API)
onMounted(() => {
  // This would typically be an API call
  stats.value = {
    totalUsers: 1234,
    totalGroups: 89,
    totalMessages: 45678,
    onlineUsers: 156
  };
});
</script>

<style scoped lang="scss">
.home {
  blockquote {
    padding: 10px 20px;
    margin: 0 0 20px;
    font-size: 17.5px;
    border-left: 5px solid #eee;
  }
  hr {
    margin-top: 20px;
    margin-bottom: 20px;
    border: 0;
    border-top: 1px solid #eee;
  }
  .col-item {
    margin-bottom: 20px;
  }

  ul {
    padding: 0;
    margin: 0;
  }

  font-family: 'open sans', 'Helvetica Neue', Helvetica, Arial, sans-serif;
  font-size: 13px;
  color: #676a6c;
  overflow-x: hidden;

  ul {
    list-style-type: none;
  }

  h4 {
    margin-top: 0px;
    color: #909399;
  }

  h2 {
    margin-top: 10px;
    font-size: 26px;
    font-weight: 500;
    color: #303133;
  }

  h3 {
    margin: 20px 0 15px 0;
    font-size: 20px;
    font-weight: 500;
    color: #303133;
  }

  p {
    margin-top: 10px;

    b {
      font-weight: 700;
    }
  }

  .stats-row {
    margin-top: 20px;
    margin-bottom: 20px;
  }

  .stat-card {
    margin-bottom: 20px;
    cursor: default;
    
    :deep(.el-card__body) {
      padding: 20px;
    }
  }

  .stat-content {
    display: flex;
    align-items: center;
    gap: 20px;
  }

  .stat-icon {
    width: 60px;
    height: 60px;
    border-radius: 10px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    flex-shrink: 0;
  }

  .stat-info {
    flex: 1;
  }

  .stat-value {
    font-size: 28px;
    font-weight: bold;
    color: #303133;
    line-height: 1.2;
  }

  .stat-label {
    font-size: 14px;
    color: #909399;
    margin-top: 5px;
  }

  .quick-links-row {
    margin-bottom: 20px;
  }

  .link-card {
    margin-bottom: 20px;
    cursor: pointer;
    transition: all 0.3s;
    
    &:hover {
      transform: translateY(-5px);
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
    }

    :deep(.el-card__body) {
      padding: 30px 20px;
    }
  }

  .link-content {
    display: flex;
    flex-direction: column;
    align-items: center;
    text-align: center;
    gap: 10px;
  }

  .link-title {
    font-size: 16px;
    font-weight: 500;
    color: #303133;
  }

  .link-desc {
    font-size: 13px;
    color: #909399;
  }

  .system-info-row {
    margin-top: 20px;
  }

  .card-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-weight: 500;
  }

  .update-log {
    ol {
      display: block;
      list-style-type: decimal;
      margin-block-start: 1em;
      margin-block-end: 1em;
      margin-inline-start: 0;
      margin-inline-end: 0;
      padding-inline-start: 40px;
    }
  }
}
</style>
