<template>
  <u-popup mode="center" :mask-close-able="false" :show="show" @close="close" bg-color="transparent">
    <view class="wechat-red-package-popup">
      <!-- 红包弹窗头部 -->
      <view class="popup-header">
        <view class="close-btn" @click="close">
          <text class="iconfont">✕</text>
        </view>
      </view>

      <!-- 红包主体 -->
      <view class="popup-body">
        <!-- 发送者头像 -->
        <view class="sender-avatar">
          <image :src="senderAvatar" mode="aspectFill"></image>
        </view>

        <!-- 发送者昵称 -->
        <text class="sender-name">{{ senderName }}</text>

        <!-- 红包祝福语 -->
        <text class="blessing-text">恭喜发财，大吉大利</text>

        <!-- 红包图标 -->
        <view class="red-package-icon">
          <text class="hongbao-icon">🧧</text>
        </view>

        <!-- 领取成功显示金额 -->
        <view v-if="receiveSuccess" class="receive-success">
          <text class="success-text">恭喜你获得</text>
          <text class="amount-text">{{ receivedAmount }} USDT</text>
          <button class="close-success-btn" @click="close">关闭</button>
        </view>

        <!-- 已领取状态显示 -->
        <view v-else-if="alreadyClaimed" class="already-claimed">
          <text class="claimed-text">红包已被领取</text>
          <button class="close-btn" @click="close">关闭</button>
        </view>

        <!-- 立即领取按钮 -->
        <button v-else class="receive-btn" @click="onReceive" :disabled="loading">
          <text v-if="!loading">立即领取</text>
          <text v-else>领取中...</text>
        </button>

        <!-- 红包说明 -->
        <text v-if="!receiveSuccess" class="package-desc">群红包</text>
      </view>

      <!-- 装饰元素 -->
      <view class="decoration-top"></view>
      <view class="decoration-bottom"></view>
    </view>
  </u-popup>
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
  data () {
    return {
      show: false,
      loading: false,
      receiveSuccess: false,
      receivedAmount: 0,
      alreadyClaimed: false
    }
  },
  methods: {
    open () {
      console.log('open 方法调用');
      // 重置状态
      this.receiveSuccess = false;
      this.receivedAmount = 0;
      this.loading = false;
      this.alreadyClaimed = false;
      this.show = true;
    },
    close () {
      this.show = false;
    },
    async onReceive () {
      if (this.loading) return;

      this.loading = true;

      try {
        // 触发领取红包事件并等待返回结果
        const result = await new Promise((resolve, reject) => {
          this.$emit('receive', this.redPackageId, resolve, reject);
        });

        // 显示领取成功状态和金额
        if (result && result > 0) {
          this.receivedAmount = result;
          this.receiveSuccess = true;
        }
      } catch (error) {
        console.error('领取红包失败:', error);

        // 检查是否是已领取的错误
        const errorMessage = error.message || '';
        const isAlreadyClaimed = errorMessage.includes('红包已抢完') ||
          errorMessage.includes('已领取') ||
          errorMessage.includes('已抢完');

        if (isAlreadyClaimed) {
          // 设置已领取状态，按钮变为"关闭"
          this.alreadyClaimed = true;
        }
        // 其他错误不在这里显示提示，因为red-package-item组件已经处理了
      } finally {
        this.loading = false;
      }
    },
    closeSuccessPopup () {
      this.close();
    }
  }
}
</script>

<style scoped lang="scss">
.wechat-red-package-popup {
  width: 600rpx;
  background: linear-gradient(135deg, #ff6b6b 0%, #ee5a24 100%);
  border-radius: 20rpx;
  position: relative;
  overflow: hidden;

  // 装饰元素
  .decoration-top {
    position: absolute;
    top: -100rpx;
    left: -100rpx;
    width: 300rpx;
    height: 300rpx;
    background: radial-gradient(circle, rgba(255, 255, 255, 0.1) 0%, transparent 70%);
    border-radius: 50%;
  }

  .decoration-bottom {
    position: absolute;
    bottom: -150rpx;
    right: -150rpx;
    width: 400rpx;
    height: 400rpx;
    background: radial-gradient(circle, rgba(255, 255, 255, 0.08) 0%, transparent 70%);
    border-radius: 50%;
  }

  .popup-header {
    position: relative;
    height: 80rpx;
    display: flex;
    justify-content: flex-end;
    align-items: center;
    padding: 0 30rpx;

    .close-btn {
      width: 60rpx;
      display: flex;
      align-items: center;
      justify-content: center;
      border-radius: 50%;
      background: rgba(255, 255, 255, 0.2);

      .iconfont {
        font-size: 32rpx;
        color: white;
      }
    }
  }

  .popup-body {
    flex: 1;
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: 40rpx 60rpx 60rpx;
    position: relative;
    z-index: 2;

    .sender-avatar {
      width: 120rpx;
      height: 120rpx;
      border-radius: 50%;
      overflow: hidden;
      border: 4rpx solid rgba(255, 255, 255, 0.3);
      margin-bottom: 20rpx;

      image {
        width: 100%;
        height: 100%;
      }
    }

    .sender-name {
      font-size: 32rpx;
      color: white;
      font-weight: 500;
      margin-bottom: 10rpx;
    }

    .blessing-text {
      font-size: 28rpx;
      color: rgba(255, 255, 255, 0.9);
      margin-bottom: 60rpx;
    }

    .red-package-icon {
      width: 200rpx;
      height: 200rpx;
      display: flex;
      align-items: center;
      justify-content: center;
      margin-bottom: 60rpx;
      position: relative;

      &::before {
        content: '';
        position: absolute;
        width: 100%;
        height: 100%;
        background: radial-gradient(circle, rgba(255, 255, 255, 0.2) 0%, transparent 70%);
        border-radius: 50%;
        animation: pulse 2s infinite;
      }

      .hongbao-icon {
        font-size: 120rpx;
        position: relative;
        z-index: 1;
      }
    }

    .receive-btn {
      width: 300rpx;
      height: 80rpx;
      background: #ffd700;
      border: none;
      border-radius: 40rpx;
      color: #d4380d;
      font-size: 32rpx;
      font-weight: bold;
      margin-bottom: 40rpx;
      box-shadow: 0 8rpx 20rpx rgba(0, 0, 0, 0.2);
      transition: all 0.3s ease;

      &:active {
        transform: scale(0.95);
        box-shadow: 0 4rpx 10rpx rgba(0, 0, 0, 0.2);
      }

      &:disabled {
        opacity: 0.6;
        transform: none;
      }
    }

    .package-desc {
      font-size: 24rpx;
      color: rgba(255, 255, 255, 0.7);
    }

    .receive-success {
      display: flex;
      flex-direction: column;
      align-items: center;
      margin-bottom: 40rpx;

      .success-text {
        font-size: 28rpx;
        color: rgba(255, 255, 255, 0.9);
        margin-bottom: 20rpx;
      }

      .amount-text {
        font-size: 48rpx;
        color: #ffd700;
        font-weight: bold;
        margin-bottom: 40rpx;
        text-shadow: 0 2rpx 4rpx rgba(0, 0, 0, 0.3);
      }

      .close-success-btn {
        width: 200rpx;
        background: rgba(255, 255, 255, 0.2);
        border: 2rpx solid rgba(255, 255, 255, 0.5);
        border-radius: 30rpx;
        color: white;
        font-size: 28rpx;
        transition: all 0.3s ease;

        &:active {
          background: rgba(255, 255, 255, 0.3);
          transform: scale(0.95);
        }
      }
    }

    .already-claimed {
      display: flex;
      flex-direction: column;
      align-items: center;
      margin-bottom: 40rpx;

      .claimed-text {
        font-size: 32rpx;
        color: rgba(255, 255, 255, 0.8);
        margin-bottom: 40rpx;
      }

      .close-btn {
        width: 200rpx;
        background: rgba(255, 255, 255, 0.2);
        border: 2rpx solid rgba(255, 255, 255, 0.5);
        border-radius: 30rpx;
        color: white;
        font-size: 28rpx;
        transition: all 0.3s ease;

        &:active {
          background: rgba(255, 255, 255, 0.3);
          transform: scale(0.95);
        }
      }
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