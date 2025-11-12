<template>
  <view class="page mine-withdraw">
    <nav-bar title="USDT提现" back></nav-bar>

    <!-- 余额显示 -->
    <uni-card :is-shadow="false" is-full :border="false">
      <view class="balance-info">
        <view class="balance-title">可用余额</view>
        <view class="balance-amount">{{ availableBalance }} USDT</view>
      </view>
    </uni-card>

    <!-- 提现表单 -->
    <uni-card :is-shadow="false" is-full :border="false">
      <view class="withdraw-form">
        <view class="form-item">
          <view class="form-label">提现地址</view>
          <view class="address-display">
            <text class="address-text">{{ withdrawAddress || '未设置提现地址' }}</text>
          </view>
        </view>

        <view class="form-item">
          <view class="form-label">
            <text>提现金额</text>
            <text class="min-amount">最低 {{ minWithdrawAmount }} USDT</text>
          </view>
          <view class="amount-input-wrapper">
            <input v-model="withdrawForm.amount" class="form-input" placeholder="请输入提现金额" type="digit"
              @input="onAmountInput" />
            <button class="all-btn" @tap="setAllAmount">全部</button>
          </view>
        </view>

        <view class="form-item">
          <view class="form-label">手续费</view>
          <view class="fee-info">
            <text class="fee-amount">{{ withdrawFee }} USDT</text>
            <text class="fee-desc">网络手续费</text>
          </view>
        </view>

        <view class="form-item">
          <view class="form-label">实际到账</view>
          <view class="receive-amount">{{ actualReceiveAmount }} USDT</view>
        </view>

        <!-- 交易密码 -->
        <view class="form-item">
          <view class="form-label">交易密码</view>
          <input v-model="withdrawForm.tradePassword" class="form-input" placeholder="请输入6位交易密码" type="number"
            maxlength="6" password />
        </view>

      </view>
    </uni-card>

    <!-- 提现说明 -->
    <uni-card :is-shadow="false" is-full :border="false">
      <view class="withdraw-notice">
        <view class="notice-title">
          <uni-icons type="info-filled" color="#1890ff" size="18"></uni-icons>
          <text>提现说明</text>
        </view>
        <view class="notice-content">
          <text>• 请使用USDT-BSC网络进行提现</text>
          <text>• 最小提现金额：{{ minWithdrawAmount }} USDT</text>
          <text>• 到账时间：1-3个网络确认</text>
          <text>• 请确保提现地址支持BSC网络</text>
        </view>
      </view>
    </uni-card>



    <!-- 提交按钮 -->
    <view class="submit-wrapper">
      <button class="submit-btn" :class="{ disabled: !canSubmit }" :disabled="!canSubmit" @tap="submitWithdraw">
        {{ submitLoading ? '提交中...' : '确认提现' }}
      </button>
    </view>
  </view>
</template>

<script>
import { mapStores } from 'pinia';
import useUserStore from '@/store/userStore.js';

export default {
  name: "mine-withdraw",
  data () {
    return {
      minWithdrawAmount: 1,
      submitLoading: false,
      withdrawForm: {
        amount: '',
        tradePassword: ''
      }
    }
  },
  computed: {
    // 从userStore获取用户信息
    userInfo () {
      return this.userStore.userInfo;
    },

    // 可用余额
    availableBalance () {
      return this.userInfo.balance || '0.00';
    },

    // 提现地址
    withdrawAddress () {
      return this.userInfo.walletAddress || '';
    },

    // 提现费率
    withdrawFeeRate () {
      return this.userInfo.feeRatio || 0.02;
    },

    // 提现手续费
    withdrawFee () {
      const amount = parseFloat(this.withdrawForm.amount) || 0;
      return (amount * this.withdrawFeeRate).toFixed(2);
    },

    // 实际到账金额
    actualReceiveAmount () {
      const amount = parseFloat(this.withdrawForm.amount) || 0;
      const fee = parseFloat(this.withdrawFee) || 0;
      const receive = amount - fee;
      return receive > 0 ? receive.toFixed(2) : '0.00';
    },

    // 是否可以提交
    canSubmit () {
      const { amount, tradePassword } = this.withdrawForm;
      const amountNum = parseFloat(amount) || 0;

      return this.withdrawAddress.length > 0 &&
        amountNum >= this.minWithdrawAmount &&
        amountNum <= parseFloat(this.availableBalance) &&
        tradePassword.length === 6 &&
        !this.submitLoading;
    }
  },
  methods: {
    // 跳转到绑定地址页面
    goToBindAddress () {
      uni.navigateTo({
        url: '/pages/mine/mine-bind-address'
      });
    },

    // 金额输入处理
    onAmountInput (e) {
      let value = e.detail.value;
      // 限制小数点后两位
      if (value.includes('.')) {
        const parts = value.split('.');
        if (parts[1] && parts[1].length > 2) {
          value = parts[0] + '.' + parts[1].substring(0, 2);
          this.withdrawForm.amount = value;
        }
      }
    },

    // 设置全部金额
    setAllAmount () {
      const balance = parseFloat(this.availableBalance) || 0;
      const maxAmount = balance - this.withdrawFee;
      if (maxAmount > 0) {
        this.withdrawForm.amount = maxAmount.toFixed(2);
      } else {
        uni.showToast({
          title: '余额不足',
          icon: 'none'
        });
      }
    },

    // 提交提现申请
    submitWithdraw () {
      if (!this.canSubmit) return;

      // 检查是否有提现地址
      if (!this.withdrawAddress) {
        uni.showToast({
          title: '请先绑定提现地址',
          icon: 'none'
        });
        return;
      }

      // 验证金额
      const amount = parseFloat(this.withdrawForm.amount);
      if (amount < this.minWithdrawAmount) {
        uni.showToast({
          title: `最低提现金额为${this.minWithdrawAmount} USDT`,
          icon: 'none'
        });
        return;
      }

      if (amount > parseFloat(this.availableBalance)) {
        uni.showToast({
          title: '余额不足',
          icon: 'none'
        });
        return;
      }

      // 验证交易密码
      if (!this.withdrawForm.tradePassword || this.withdrawForm.tradePassword.length !== 6) {
        uni.showToast({
          title: '请输入6位交易密码',
          icon: 'none'
        });
        return;
      }

      // 确认提现
      uni.showModal({
        title: '确认提现',
        content: `确认向地址 ${this.withdrawAddress.substring(0, 10)}... 提现 ${amount} USDT？`,
        success: (res) => {
          if (res.confirm) {
            this.doWithdraw();
          }
        }
      });
    },

    // 执行提现
    doWithdraw () {
      this.submitLoading = true;

      this.$http({
        url: '/user/withdraw',
        method: 'POST',
        data: {
          amount: this.withdrawForm.amount,
          tradePassword: this.withdrawForm.tradePassword
        }
      }).then((res) => {
        uni.showToast({
          title: '提现申请已提交',
          icon: 'success'
        });

        // 清空表单
        this.withdrawForm.amount = '';
        this.withdrawForm.tradePassword = '';
        // 跳转到提现记录
        setTimeout(() => {
          uni.navigateTo({
            url: '/pages/mine/mine-transaction-history'
          });
        }, 1500);

      }).catch((err) => {
        console.error('提现失败:', err);
        uni.showToast({
          title: err.message || '提现失败',
          icon: 'none'
        });
      }).finally(() => {
        this.submitLoading = false;
      });
    },

    // 验证地址格式
    validateAddress (address) {
      // BSC地址验证：以0x开头，长度42位
      return /^0x[a-fA-F0-9]{40}$/.test(address);
    }
  },
  ...mapStores(useUserStore),
  onLoad () {
    // 数据从userStore中获取，无需单独请求
  }
}
</script>

<style lang="scss" scoped>
.mine-withdraw {
  .balance-info {
    padding: 30rpx;
    text-align: center;

    .balance-title {
      font-size: $im-font-size;
      color: $im-text-color-light;
      margin-bottom: 10rpx;
    }

    .balance-amount {
      font-size: 48rpx;
      font-weight: 600;
      color: $im-color-primary;
    }
  }

  .withdraw-form {
    padding: 30rpx;

    .form-item {
      margin-bottom: 40rpx;

      .form-label {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 16rpx;
        font-size: $im-font-size;
        color: $im-text-color-dark;
        font-weight: 600;

        .min-amount {
          font-size: $im-font-size-small;
          color: $im-text-color-light;
          font-weight: normal;
        }
      }

      .form-input {
        width: 100%;
        padding: 24rpx 20rpx;
        border: 1rpx solid #d9d9d9;
        border-radius: 8rpx;
        font-size: $im-font-size;
        background-color: white;

        &:focus {
          border-color: $im-color-primary;
        }
      }

      .address-display {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 24rpx 20rpx;
        border: 1rpx solid #d9d9d9;
        border-radius: 8rpx;
        background-color: #f8f9fa;

        .address-text {
          flex: 1;
          font-size: $im-font-size;
          color: $im-text-color-dark;
          word-break: break-all;
          margin-right: 20rpx;
        }

        .change-address-btn {
          padding: 16rpx 24rpx;
          border: 1rpx solid $im-color-primary;
          border-radius: 6rpx;
          background-color: white;
          color: $im-color-primary;
          font-size: $im-font-size-small;
          white-space: nowrap;
        }
      }

      .amount-input-wrapper {
        display: flex;
        align-items: center;
        gap: 20rpx;

        .form-input {
          flex: 1;
        }

        .all-btn {
          padding: 24rpx 30rpx;
          border: 1rpx solid $im-color-primary;
          border-radius: 8rpx;
          background-color: white;
          color: $im-color-primary;
          font-size: $im-font-size;
        }
      }

      .fee-info {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 24rpx 20rpx;
        background-color: #f8f9fa;
        border-radius: 8rpx;

        .fee-amount {
          font-size: $im-font-size;
          color: $im-text-color-dark;
          font-weight: 600;
        }

        .fee-desc {
          font-size: $im-font-size-small;
          color: $im-text-color-light;
        }
      }

      .receive-amount {
        padding: 24rpx 20rpx;
        background-color: #f6ffed;
        border: 1rpx solid #b7eb8f;
        border-radius: 8rpx;
        font-size: $im-font-size;
        color: #52c41a;
        font-weight: 600;
      }
    }
  }

  .withdraw-notice {
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

  .submit-wrapper {
    padding: 30rpx;

    .submit-btn {
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