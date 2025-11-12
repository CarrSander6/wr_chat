<template>
  <view class="page mine-vip-purchase">
    <nav-bar title="购买VIP" back></nav-bar>

    <!-- VIP特权介绍 -->
    <uni-card :is-shadow="false" is-full :border="false">
      <view class="vip-intro">
        <view class="vip-header">
          <uni-icons type="vip-filled" color="#faad14" size="32"></uni-icons>
          <text class="vip-title">VIP专属特权</text>
        </view>

        <view class="privilege-list">
          <view class="privilege-item">
            <uni-icons type="checkmarkempty" color="#52c41a" size="16"></uni-icons>
            <text>可创建最多3个专属群组</text>
          </view>
          <view class="privilege-item">
            <uni-icons type="checkmarkempty" color="#52c41a" size="16"></uni-icons>
            <text>享受群组管理特权</text>
          </view>
          <view class="privilege-item">
            <uni-icons type="checkmarkempty" color="#52c41a" size="16"></uni-icons>
            <text>专属VIP标识显示</text>
          </view>
          <view class="privilege-item">
            <uni-icons type="checkmarkempty" color="#52c41a" size="16"></uni-icons>
            <text>优先客服支持</text>
          </view>
        </view>
      </view>
    </uni-card>

    <!-- VIP价格信息 -->
    <uni-card :is-shadow="false" is-full :border="false">
      <view class="vip-price-info">
        <view class="price-title">VIP服务价格</view>
        <view class="price-display">
          <text class="price-amount">{{ vipPrice }}</text>
          <text class="price-unit">USDT</text>
        </view>
        <view class="price-desc">一次性购买，永久享受VIP特权</view>
      </view>
    </uni-card>

    <!-- 余额显示 -->
    <uni-card :is-shadow="false" is-full :border="false">
      <view class="balance-info">
        <view class="balance-item">
          <text class="balance-label">USDT余额</text>
          <text class="balance-amount">{{ usdtBalance }} USDT</text>
        </view>
        <view class="balance-item">
          <text class="balance-label">需要支付</text>
          <text class="balance-amount pay-amount">{{ vipPrice }} USDT</text>
        </view>
        <view class="balance-item">
          <text class="balance-label">支付后余额</text>
          <text class="balance-amount" :class="{ insufficient: balanceAfterPay < 0 }">
            {{ balanceAfterPay >= 0 ? balanceAfterPay.toFixed(2) : '余额不足' }} USDT
          </text>
        </view>
      </view>
    </uni-card>

    <!-- 支付密码 -->
    <uni-card :is-shadow="false" is-full :border="false">
      <view class="payment-form">
        <view class="form-item">
          <view class="form-label">交易密码</view>
          <input v-model="paymentPassword" class="form-input" placeholder="请输入6位交易密码" type="number" maxlength="6"
            password />
        </view>
      </view>
    </uni-card>

    <!-- 购买须知 -->
    <uni-card :is-shadow="false" is-full :border="false">
      <view class="purchase-notice">
        <view class="notice-title">
          <uni-icons type="info-filled" color="#faad14" size="18"></uni-icons>
          <text>购买须知</text>
        </view>
        <view class="notice-content">
          <text>• VIP服务一经购买，不支持退款</text>
          <text>• VIP权限在有效期内立即生效</text>
          <text>• 到期后可续费延长有效期</text>
          <text>• 如有疑问请联系客服</text>
        </view>
      </view>
    </uni-card>

    <!-- 购买按钮 -->
    <view class="purchase-wrapper">
      <button class="purchase-btn" :class="{ disabled: !canPurchase }" :disabled="!canPurchase" @tap="purchaseVip">
        {{ purchaseLoading ? '购买中...' : `立即购买 ${vipPrice} USDT` }}
      </button>
    </view>
  </view>
</template>

<script>
import { mapStores } from 'pinia';
import useUserStore from '@/store/userStore.js';

export default {
  name: "mine-vip-purchase",
  data () {
    return {
      paymentPassword: '',
      purchaseLoading: false
    }
  },
  computed: {
    // 用户信息
    userInfo () {
      return this.userStore.userInfo;
    },

    // USDT余额
    usdtBalance () {
      return this.userInfo.balance || '0.00';
    },

    // VIP价格
    vipPrice () {
      return this.userInfo.vipAmount || 100;
    },

    // 支付后余额
    balanceAfterPay () {
      const balance = parseFloat(this.usdtBalance) || 0;
      return balance - this.vipPrice;
    },

    // 是否可以购买
    canPurchase () {
      const balance = parseFloat(this.usdtBalance) || 0;
      return this.vipPrice > 0 &&
        balance >= this.vipPrice &&
        this.paymentPassword.length === 6 &&
        !this.purchaseLoading;
    }
  },
  methods: {


    // 购买VIP
    purchaseVip () {
      if (!this.canPurchase) return;

      // 确认购买
      uni.showModal({
        title: '确认购买',
        content: `确认购买VIP服务？\n需要支付 ${this.vipPrice} USDT`,
        success: (res) => {
          if (res.confirm) {
            this.doPurchase();
          }
        }
      });
    },

    // 执行购买
    doPurchase () {
      this.purchaseLoading = true;

      // 构建请求参数
      const requestData = {
        userId: this.userInfo.id,
        vipType: 'permanent', // 永久VIP
        paymentMethod: 'usdt', // USDT支付
        password: this.paymentPassword
      };
      // 输出requestData
      console.log('requestData:', requestData);

      this.$http({
        url: '/user/purchaseVip',
        method: 'PUT',
        data: requestData,
        header: {
          'Content-Type': 'application/json'
        }
      }).then(() => {
        // 根据新接口文档处理响应 
        uni.showModal({
          title: '购买成功',
          content: `恭喜您成功购买VIP服务！\nVIP权限已激活`,
          showCancel: false,
          success: () => {
            // 输出成功信息
            console.log('购买成功');
			  
            // 清空密码
            this.paymentPassword = '';

            // 更新用户信息
            this.userStore.loadUser();

            // 返回 个人中心
            uni.switchTab({
              url: '/pages/mine/mine'
            });
          }
        });

      }).catch((err) => {
        console.error('购买失败:', err);
        let errorMessage = '购买失败';

        // 根据HTTP状态码处理错误
        if (err.statusCode === 400) {
          errorMessage = '参数错误，请检查输入信息';
        } else if (err.statusCode === 401) {
          errorMessage = '未授权，请重新登录';
        } else if (err.statusCode === 500) {
          errorMessage = '服务器错误，请稍后重试';
        } else if (err.message) {
          errorMessage = err.message;
        }

        uni.showToast({
          title: errorMessage,
          icon: 'none'
        });
      }).finally(() => {
        this.purchaseLoading = false;
      });
    }
  },
  ...mapStores(useUserStore),
  onLoad () {
  }
}
</script>

<style lang="scss" scoped>
.mine-vip-purchase {
  .vip-intro {
    padding: 30rpx;

    .vip-header {
      display: flex;
      align-items: center;
      margin-bottom: 30rpx;

      .vip-title {
        margin-left: 15rpx;
        font-size: $im-font-size-large;
        font-weight: 600;
        color: $im-text-color-dark;
      }
    }

    .privilege-list {
      .privilege-item {
        display: flex;
        align-items: center;
        margin-bottom: 20rpx;

        text {
          margin-left: 15rpx;
          font-size: $im-font-size;
          color: $im-text-color;
        }
      }
    }
  }

  .vip-price-info {
    padding: 30rpx;
    text-align: center;

    .price-title {
      font-size: $im-font-size;
      font-weight: 600;
      color: $im-text-color-dark;
      margin-bottom: 30rpx;
    }

    .price-display {
      display: flex;
      justify-content: center;
      align-items: baseline;
      margin-bottom: 20rpx;

      .price-amount {
        font-size: 80rpx;
        font-weight: 600;
        color: $im-color-primary;
        margin-right: 10rpx;
      }

      .price-unit {
        font-size: $im-font-size-large;
        color: $im-text-color-light;
      }
    }

    .price-desc {
      font-size: $im-font-size-small;
      color: $im-text-color-light;
    }
  }

  .balance-info {
    padding: 30rpx;

    .balance-item {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 20rpx 0;
      border-bottom: 1rpx solid #f0f0f0;

      &:last-child {
        border-bottom: none;
      }

      .balance-label {
        font-size: $im-font-size;
        color: $im-text-color;
      }

      .balance-amount {
        font-size: $im-font-size;
        font-weight: 600;
        color: $im-text-color-dark;

        &.pay-amount {
          color: $im-color-primary;
        }

        &.insufficient {
          color: #ff4d4f;
        }
      }
    }
  }

  .payment-form {
    padding: 30rpx;

    .form-item {
      .form-label {
        margin-bottom: 16rpx;
        font-size: $im-font-size;
        color: $im-text-color-dark;
        font-weight: 600;
      }

      .form-input {
        padding: 24rpx 20rpx;
        border: 1rpx solid #d9d9d9;
        border-radius: 8rpx;
        font-size: $im-font-size;
        background-color: white;

        &:focus {
          border-color: $im-color-primary;
        }
      }
    }
  }

  .purchase-notice {
    padding: 30rpx;

    .notice-title {
      display: flex;
      align-items: center;
      margin-bottom: 20rpx;

      text {
        margin-left: 10rpx;
        font-size: $im-font-size;
        font-weight: 600;
        color: $im-text-color-dark;
      }
    }

    .notice-content {
      text {
        display: block;
        font-size: $im-font-size-small;
        color: $im-text-color;
        line-height: 1.6;
        margin-bottom: 8rpx;
      }
    }
  }

  .purchase-wrapper {
    padding: 30rpx;

    .purchase-btn {
      width: 100%;
      padding: 32rpx;
      background-color: $im-color-primary;
      color: white;
      border: none;
      border-radius: 12rpx;
      font-size: $im-font-size-large;
      font-weight: 600;

      &.disabled {
        background-color: #d9d9d9;
        color: #999;
      }
    }
  }
}
</style>