<template>
  <view class="deposit-page">
    <!-- 导航栏 -->
    <nav-bar title="充值" back />

    <!-- 充值地址卡片 -->
    <view class="deposit-card">
      <!-- 充值说明 -->
      <view class="tip-section">
        <uni-icons type="info" color="#ff9500" size="16"></uni-icons>
        <text class="tip-text">请向该地址转入 BSC 相关资产进行充值</text>
      </view>

      <!-- 二维码区域 -->
      <view class="qr-section" v-if="depositAddress">
        <uqrcode ref="qrcode" canvas-id="depositQrcode" :value="depositAddress" :size="qrSize" :options="qrOptions"
          class="qr-canvas">
          <template v-slot:loading>
            <text>二维码生成中...</text>
          </template>
        </uqrcode>
      </view>

      <!-- 加载状态 -->
      <view class="loading-section" v-else>
        <uni-load-more status="loading" content-text="正在获取充值地址..."></uni-load-more>
      </view>

      <!-- 充值地址 -->
      <view class="address-section" v-if="depositAddress">
        <text class="address-label">充值地址</text>
        <view class="address-content">
          <text class="address-text">{{ depositAddress }}</text>
        </view>
      </view>

      <!-- 充值须知 -->
      <view class="notice-section" v-if="depositAddress">
        <view class="notice-title">
          <uni-icons type="info-filled" color="#1890ff" size="16"></uni-icons>
          <text>充值须知</text>
        </view>
        <view class="notice-list">
          <text class="notice-item">• 仅支持 BSC 网络充值</text>
          <text class="notice-item">• 请确认转账网络与地址匹配</text>
          <text class="notice-item">• 充值到账需要网络确认，请耐心等待</text>
        </view>
      </view>

      <!-- 操作按钮 -->
      <view class="action-buttons" v-if="depositAddress">
        <!-- <button class="btn-share" @tap="onShare">
          <uni-icons type="redo" color="#666" size="18"></uni-icons>
          <text>分享地址</text>
        </button> -->
        <button class="btn-copy" @tap="copyAddress">
          <uni-icons type="paperclip" color="#666" size="18"></uni-icons>
          <text>复制地址</text>
        </button>
      </view>
    </view>

    <!-- 底部品牌标识 -->
    <view class="brand-section">
    </view>
  </view>
</template>

<script>
import { mapStores } from 'pinia';
import useUserStore from '@/store/userStore.js';

export default {
  name: "mine-deposit",
  data () {
    return {
      depositAddress: '',
      qrSize: 200,
      qrOptions: {
        margin: 10,
        colorDark: '#000000',
        colorLight: '#ffffff'
      }
    }
  },
  methods: {
    // 获取充值地址
    getDepositAddress () {
      // 从用户信息中获取充值地址
      const userInfo = this.userStore.userInfo;
      if (userInfo && userInfo.toAddress) {
        this.depositAddress = userInfo.toAddress;
        // uqrcode组件会自动生成二维码
      } else {
        uni.showToast({
          title: '获取充值地址失败',
          icon: 'none'
        });
        setTimeout(() => {
          uni.navigateBack();
        }, 1500);
      }
    },

    // 生成二维码（使用uqrcode组件自动生成）
    generateQRCode () {
      // uqrcode组件会自动根据value属性生成二维码
      // 无需手动调用生成方法
    },

    // 复制充值地址
    copyAddress () {
      if (!this.depositAddress) {
        uni.showToast({
          title: '充值地址为空',
          icon: 'none'
        });
        return;
      }

      uni.setClipboardData({
        data: this.depositAddress,
        success: () => {
          uni.showToast({
            title: '充值地址已复制',
            icon: 'success'
          });
        },
        fail: () => {
          uni.showToast({
            title: '复制失败',
            icon: 'none'
          });
        }
      });
    },

    // 分享充值地址
    onShare () {
      // #ifdef MP-WEIXIN
      uni.showShareMenu({
        withShareTicket: true
      });
      // #endif

      // #ifndef MP-WEIXIN
      uni.showToast({
        title: '分享功能暂不支持',
        icon: 'none'
      });
      // #endif
    }
  },
  computed: {
    userInfo () {
      return this.userStore.userInfo;
    }
  },
  ...mapStores(useUserStore),
  onLoad () {
    this.getDepositAddress();
  }
}
</script>

<style lang="scss" scoped>
.deposit-page {
  min-height: 100vh;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);

  display: flex;
  flex-direction: column;
}

.deposit-card {
  margin-top: 140rpx;
  margin-left: 40rpx;
  margin-right: 40rpx;
  background: #ffffff;
  border-radius: 20rpx;
  padding: 40rpx 40rpx;
  box-shadow: 0 8rpx 32rpx rgba(0, 0, 0, 0.1);
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.tip-section {
  background: #fff7e6;
  border: 2rpx solid #ffd591;
  border-radius: 12rpx;
  padding: 20rpx;
  display: flex;
  align-items: center;

  .tip-text {
    margin-left: 12rpx;
    font-size: 28rpx;
    color: #d48806;
    line-height: 1.4;
  }
}

.qr-section {
  margin-bottom: 40rpx;
  padding: 20rpx;
  background: #f8f9fa;
  border-radius: 16rpx;
  display: flex;
  justify-content: center;
  align-items: center;

  .qr-canvas {
    border: 4rpx solid #ffffff;
    border-radius: 12rpx;
    box-shadow: 0 4rpx 16rpx rgba(0, 0, 0, 0.1);
    background: #ffffff;
  }
}

.loading-section {
  padding: 60rpx 0;
  margin-bottom: 40rpx;
}

.address-section {
  width: 100%;
  margin-bottom: 40rpx;

  .address-label {
    font-size: 28rpx;
    color: #666666;
    display: block;
    margin-bottom: 16rpx;
    text-align: center;
  }

  .address-content {
    background: #f5f5f5;
    border-radius: 12rpx;
    padding: 24rpx 20rpx;

    .address-text {
      font-size: 26rpx;
      color: #333333;
      line-height: 1.6;
      word-break: break-all;
      text-align: center;
      display: block;
    }
  }
}

.notice-section {
  width: 100%;
  margin-bottom: 40rpx;
  background: #f0f8ff;
  border: 2rpx solid #d6e4ff;
  border-radius: 12rpx;
  padding: 24rpx;

  .notice-title {
    display: flex;
    align-items: center;
    margin-bottom: 16rpx;

    text {
      margin-left: 8rpx;
      font-size: 28rpx;
      color: #1890ff;
      font-weight: 500;
    }
  }

  .notice-list {
    display: flex;
    flex-direction: column;
    gap: 8rpx;

    .notice-item {
      font-size: 26rpx;
      color: #666666;
      line-height: 1.5;
    }
  }
}

.action-buttons {
  display: flex;
  gap: 40rpx;

  button {
    flex: 1;
    height: 88rpx;
    border-radius: 44rpx;
    border: none;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 12rpx;
    font-size: 32rpx;

    &.btn-share {
      background: #f5f5f5;
      color: #666666;
    }

    &.btn-copy {
      background: #f5f5f5;
      color: #666666;
    }

    &:active {
      opacity: 0.8;
    }
  }
}

.brand-section {
  text-align: center;
  padding: 40rpx 0;

  .brand-text {
    font-size: 32rpx;
    color: rgba(255, 255, 255, 0.8);
    font-weight: 500;
    letter-spacing: 2rpx;
  }
}
</style>