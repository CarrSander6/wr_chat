<template>
  <uni-popup ref="popup" type="center" :mask-click="false">
    <view class="red-package-send">
      <view class="header">
        <text class="title">发红包</text>
        <uni-icons type="clear" size="20" color="#666" @click="close"></uni-icons>
      </view>

      <view class="content">
        <view class="form-item">
          <text class="label">红包金额</text>
          <input class="input" type="digit" v-model="amount" placeholder="请输入红包总金额" />
        </view>

        <view class="form-item">
          <text class="label">红包个数</text>
          <input class="input" type="number" v-model="total" placeholder="请输入红包个数" />
        </view>

        <view class="form-item">
          <text class="label">交易密码</text>
          <input class="input" type="password" v-model="tradePassword" placeholder="请输入交易密码" />
        </view>

        <view class="tip">
          <text>平均每个红包: {{ averageAmount }}USDT</text>
        </view>
      </view>

      <view class="footer">
        <button class="btn-cancel" @click="close">取消</button>
        <button class="btn-send" type="primary" @click="sendRedPackage" :disabled="!canSend">发送红包</button>
      </view>
    </view>
  </uni-popup>
</template>

<script>
export default {
  name: 'RedPackageSend',
  data () {
    return {
      amount: '',
      total: '1',
      tradePassword: '',
      loading: false
    }
  },
  computed: {
    averageAmount () {
      if (!this.amount || !this.total || this.total <= 0) {
        return '0.00';
      }
      return (parseFloat(this.amount) / parseInt(this.total)).toFixed(4);
    },
    canSend () {
      return this.amount && this.total && this.tradePassword &&
        parseFloat(this.amount) > 0 && parseInt(this.total) > 0 &&
        !this.loading;
    }
  },
  methods: {
    open () {
      this.$refs.popup.open();
    },
    close () {
      this.$refs.popup.close();
      this.reset();
    },
    reset () {
      this.amount = '';
      this.total = '1';
      this.tradePassword = '';
      this.loading = false;
    },
    async sendRedPackage () {
      if (!this.canSend) return;

      // 验证输入
      if (parseFloat(this.amount) <= 0) {
        uni.showToast({ title: '红包金额必须大于0', icon: 'none' });
        return;
      }

      if (parseInt(this.total) <= 0) {
        uni.showToast({ title: '红包个数必须大于0', icon: 'none' });
        return;
      }

      if (parseFloat(this.averageAmount) < 0.0001) {
        uni.showToast({ title: '每个红包金额不能低于0.0001USDT', icon: 'none' });
        return;
      }

      this.loading = true;

      try {
        const data = {
          amount: parseFloat(this.amount),
          total: parseInt(this.total),
          tradePassword: this.tradePassword
        };

        // 触发发送红包事件
        this.$emit('send', data);
        this.close();
      } catch (error) {
        console.error('发送红包失败:', error);
        uni.showToast({ title: '发送失败，请重试', icon: 'none' });
      } finally {
        this.loading = false;
      }
    }
  }
}
</script>

<style scoped lang="scss">
.red-package-send {
  width: 600rpx;
  background: #fff;
  border-radius: 20rpx;
  padding: 40rpx;

  .header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 40rpx;

    .title {
      font-size: 36rpx;
      font-weight: bold;
      color: #333;
    }
  }

  .content {
    margin-bottom: 40rpx;

    .form-item {
      margin-bottom: 30rpx;

      .label {
        display: block;
        font-size: 28rpx;
        color: #666;
        margin-bottom: 10rpx;
      }

      .input {
        width: 100%;
        height: 80rpx;
        border: 2rpx solid #e5e5e5;
        border-radius: 10rpx;
        padding: 0 20rpx;
        font-size: 28rpx;
        box-sizing: border-box;

        &:focus {
          border-color: #007aff;
        }
      }
    }

    .tip {
      padding: 20rpx;
      background: #f8f8f8;
      border-radius: 10rpx;
      text-align: center;

      text {
        font-size: 24rpx;
        color: #999;
      }
    }
  }

  .footer {
    display: flex;
    gap: 20rpx;

    .btn-cancel {
      flex: 1;
      height: 80rpx;
      line-height: 80rpx;
      background: #f5f5f5;
      color: #666;
      border: none;
      border-radius: 10rpx;
      font-size: 28rpx;
    }

    .btn-send {
      flex: 2;
      height: 80rpx;
      line-height: 80rpx;
      border-radius: 10rpx;
      font-size: 28rpx;

      &[disabled] {
        opacity: 0.6;
      }
    }
  }
}
</style>