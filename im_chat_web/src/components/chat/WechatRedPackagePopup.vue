<template>
  <el-dialog
    :visible.sync="visible"
    :show-close="false"
    :close-on-click-modal="false"
    :close-on-press-escape="false"
    width="400px"
    custom-class="wechat-red-package-dialog"
    center
  >
    <div class="wechat-red-package-popup">
      <!-- 关闭按钮 -->
      <div class="close-btn" @click="close">
        <i class="el-icon-close"></i>
      </div>
      
      <!-- 红包主体 -->
      <div class="popup-body">
        <!-- 发送者头像 -->
        <div class="sender-avatar">
          <img :src="senderAvatar" :alt="senderName" />
        </div>
        
        <!-- 发送者昵称 -->
        <div class="sender-name">{{ senderName }}</div>
        
        <!-- 红包祝福语 -->
        <div class="blessing-text">恭喜发财，大吉大利</div>
        
        <!-- 红包图标 -->
        <div class="red-package-icon">
          <div class="hongbao-icon">🧧</div>
        </div>
        
        <!-- 立即领取按钮 -->
        <el-button
          class="receive-btn"
          type="primary"
          :loading="loading"
          @click="onReceive"
        >
          {{ loading ? '领取中...' : '立即领取' }}
        </el-button>
        
        <!-- 红包说明 -->
        <div class="package-desc">群红包</div>
      </div>
      
      <!-- 装饰元素 -->
      <div class="decoration-top"></div>
      <div class="decoration-bottom"></div>
    </div>
  </el-dialog>
</template>

<script>
export default {
  name: 'WechatRedPackagePopup',
  props: {
    senderName: {
      type: String,
      default: '群友'
    },
    senderAvatar: {
      type: String,
      default: ''
    },
    redPackageId: {
      type: String,
      required: true
    }
  },
  data() {
    return {
      visible: false,
      loading: false
    }
  },
  methods: {
    open() {
      this.visible = true;
    },
    close() {
      this.visible = false;
    },
    async onReceive() {
      if (this.loading) return;
      
      this.loading = true;
      
      try {
        // 触发领取红包事件
        this.$emit('receive', this.redPackageId);
        this.close();
      } catch (error) {
        console.error('领取红包失败:', error);
        this.$message.error('领取失败，请重试');
      } finally {
        this.loading = false;
      }
    }
  }
}
</script>

<style lang="scss">
.wechat-red-package-dialog {
  .el-dialog {
    background: transparent;
    box-shadow: none;
  }
  
  .el-dialog__body {
    padding: 0;
  }
}
</style>

<style scoped lang="scss">
.wechat-red-package-popup {
  width: 100%;
  height: 500px;
  background: linear-gradient(135deg, #ff6b6b 0%, #ee5a24 100%);
  border-radius: 12px;
  position: relative;
  overflow: hidden;
  
  // 装饰元素
  .decoration-top {
    position: absolute;
    top: -60px;
    left: -60px;
    width: 180px;
    height: 180px;
    background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
    border-radius: 50%;
  }
  
  .decoration-bottom {
    position: absolute;
    bottom: -90px;
    right: -90px;
    width: 240px;
    height: 240px;
    background: radial-gradient(circle, rgba(255,255,255,0.08) 0%, transparent 70%);
    border-radius: 50%;
  }
  
  .close-btn {
    position: absolute;
    top: 15px;
    right: 15px;
    width: 30px;
    height: 30px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 50%;
    background: rgba(255,255,255,0.2);
    cursor: pointer;
    z-index: 10;
    
    i {
      color: white;
      font-size: 16px;
    }
    
    &:hover {
      background: rgba(255,255,255,0.3);
    }
  }
  
  .popup-body {
    height: 100%;
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: 50px 40px 40px;
    position: relative;
    z-index: 2;
    
    .sender-avatar {
      width: 80px;
      height: 80px;
      border-radius: 50%;
      overflow: hidden;
      border: 3px solid rgba(255,255,255,0.3);
      margin-bottom: 15px;
      
      img {
        width: 100%;
        height: 100%;
        object-fit: cover;
      }
    }
    
    .sender-name {
      font-size: 18px;
      color: white;
      font-weight: 500;
      margin-bottom: 8px;
    }
    
    .blessing-text {
      font-size: 14px;
      color: rgba(255,255,255,0.9);
      margin-bottom: 40px;
    }
    
    .red-package-icon {
      width: 120px;
      height: 120px;
      display: flex;
      align-items: center;
      justify-content: center;
      margin-bottom: 40px;
      position: relative;
      
      &::before {
        content: '';
        position: absolute;
        width: 100%;
        height: 100%;
        background: radial-gradient(circle, rgba(255,255,255,0.2) 0%, transparent 70%);
        border-radius: 50%;
        animation: pulse 2s infinite;
      }
      
      .hongbao-icon {
        font-size: 80px;
        position: relative;
        z-index: 1;
      }
    }
    
    .receive-btn {
      width: 200px;
      height: 45px;
      background: #ffd700 !important;
      border: none !important;
      border-radius: 25px;
      color: #d4380d !important;
      font-size: 18px;
      font-weight: bold;
      margin-bottom: 30px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.2);
      transition: all 0.3s ease;
      
      &:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 16px rgba(0,0,0,0.3);
      }
      
      &:active {
        transform: translateY(0);
        box-shadow: 0 2px 8px rgba(0,0,0,0.2);
      }
      
      &.is-loading {
        transform: none;
      }
    }
    
    .package-desc {
      font-size: 12px;
      color: rgba(255,255,255,0.7);
    }
  }
}

@keyframes pulse {
  0% {
    transform: scale(1);
    opacity: 0.8;
  }
  50% {
    transform: scale(1.1);
    opacity: 0.4;
  }
  100% {
    transform: scale(1);
    opacity: 0.8;
  }
}
</style>