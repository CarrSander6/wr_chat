<template>
  <view class="red-package-item" @click="onClickRedPackage">
    <view class="red-package-bg" :class="{ 'received': isReceived, 'loading': loading }">
      <view class="red-package-header">
        <view class="icon">
          <text class="iconfont icon-hongbao">🧧</text>
        </view>
        <view class="info">
          <text class="title">{{ loading ? '处理中...' : (isReceived ? '已领取' : '恭喜发财，大吉大利') }}</text>
        </view>
      </view>

      <!-- 加载中的遮罩层 -->
      <view v-if="loading" class="loading-overlay">
        <view class="loading-spinner"></view>
      </view>
    </view>

    <!-- 微信风格红包弹窗 -->
    <wechat-red-package-popup ref="redPackagePopup" :red-package-id="redPackageId" :sender-name="senderName"
      :sender-avatar="senderAvatar" @receive="onReceiveRedPackage"></wechat-red-package-popup>

    <!-- 领取成功提示 -->
    <u-popup ref="successPopup" mode="center" v-model="showSuccessPopup">
      <view class="success-popup">
        <view class="success-icon">🎉</view>
        <text class="success-title">恭喜你</text>
        <text class="success-amount">获得 {{ receivedAmount }} USDT</text>
        <button class="success-btn" @click="closeSuccessPopup">确定</button>
      </view>
    </u-popup>
  </view>
</template>

<script>
import WechatRedPackagePopup from '../wechat-red-package-popup/wechat-red-package-popup.vue';

export default {
  name: 'RedPackageItem',
  components: {
    'wechat-red-package-popup': WechatRedPackagePopup
  },
  props: {
    msgInfo: {
      type: Object,
      required: true
    }
  },
  data () {
    return {
      receivedAmount: 0,
      loading: false,
      showSuccessPopup: false
    }
  },
  computed: {
    redPackageContent () {
      // 解析JSON格式的红包内容
      try {
        return JSON.parse(this.msgInfo.content);
      } catch (error) {
        // 兼容旧格式，直接返回ID
        return {
          id: this.msgInfo.content,
          rob: false,
          userId: null
        };
      }
    },
    redPackageId () {
      // 从解析的内容中获取红包ID
      return this.redPackageContent.id || '';
    },
    isReceived () {
      // 检查红包是否已被领取
      return this.redPackageContent.rob === true;
    },
    senderName () {
      // 获取发送者昵称，如果是自己发的显示"我"
      return this.msgInfo.selfSend ? '我' : (this.msgInfo.senderName || '群友');
    },
    senderAvatar () {
      // 获取发送者头像
      return this.msgInfo.senderAvatar || '/static/default-avatar.png';
    }
  },
  methods: {
    onClickRedPackage () {
      console.log('点击红包', this.redPackageId);
      // 检查是否已领取
      if (this.isReceived) {
        console.log('红包已被领取');
        uni.showToast({
          title: '红包已被领取',
          icon: 'none'
        });
        return;
      }

      if (this.loading || this.isReceived) {
        return;
      }

      // 打开微信风格的红包弹窗
      console.log('打开微信风格的红包弹窗');
      this.$nextTick(() => {
        console.log('redPackagePopup ref:', this.$refs.redPackagePopup);
        if (this.$refs.redPackagePopup) {
          console.log('调用 open 方法');
          this.$refs.redPackagePopup.open();
        } else {
          console.error('redPackagePopup 组件引用未找到');
        }
      });
    },
    async onReceiveRedPackage (redPackageId, resolve, reject) {
      if (this.loading) {
        return;
      }

      this.loading = true;

      try {
        // 直接在组件内处理红包领取逻辑
        await this.handleRedPackageClaim(redPackageId, resolve, reject);
      } catch (error) {
        console.error('领取红包失败:', error);
        this.loading = false;
        reject(error);
      }
    },

    // 处理红包领取的核心业务逻辑
    handleRedPackageClaim (redPackageId, resolve, reject) {
      // 参数验证
      if (!redPackageId) {
        const error = new Error('红包ID不能为空');
        this.handleClaimError(error, reject);
        return;
      }
      // 处理红包领取的核心业务逻辑
      console.log('处理红包领取的核心业务逻辑');

      // 调用红包领取API

      this.$http({
        url: '/redPackage/rob',
        method: 'POST',
        data: { redId: redPackageId },
        timeout: 10000,

      }).then((res) => {
        console.log('红包领取API响应:', res);
        this.handleClaimSuccess(redPackageId, res, resolve);
      }).catch((err) => {
        console.log('红包已被领取API响应:', err);
        this.handleClaimError(err, reject);
      });
    },

    // 处理红包领取成功
    handleClaimSuccess (redPackageId, amount, resolve) {
      try {
        // 重置loading状态
        this.loading = false;

        // 更新本地状态
        this.receivedAmount = amount;

        // 通过事件向上传递成功状态，让父组件更新消息缓存和用户余额
        this.$emit('claim-success', {
          redPackageId: redPackageId,
          amount: amount,
          msgInfo: this.msgInfo
        });

        // 显示成功提示
        uni.showToast({
          title: `恭喜您获得${amount}USDT`,
          icon: 'success',
          duration: 2000
        });

        // 调用成功回调，返回实际领取金额
        if (typeof resolve === 'function') {
          resolve(amount);
        }
      } catch (error) {
        console.error('处理红包成功回调失败:', error);
        // 即使回调失败，也要重置loading状态
        this.loading = false;
      }
    },

    // 处理红包领取错误
    handleClaimError (error, reject) {
      try {
        // 重置loading状态
        this.loading = false;

        // 解析错误信息
        let errorMessage = '领取失败，请重试';

        if (error && error.data) {
          // 处理后端返回的错误格式 {"code":500,"message":"红包已抢完","data":null}
          if (error.data.message) {
            errorMessage = error.data.message;
          } else if (typeof error.data === 'string') {
            try {
              const errorData = JSON.parse(error.data);
              if (errorData.message) {
                errorMessage = errorData.message;
              }
            } catch (parseError) {
              errorMessage = error.data;
            }
          }
        } else if (error && error.message) {
          errorMessage = error.message;
        } else if (typeof error === 'string') {
          errorMessage = error;
        }

        // 检查是否是"已领取"状态的错误
        const isAlreadyClaimed = errorMessage.includes('红包已抢完') ||
          errorMessage.includes('已领取') ||
          errorMessage.includes('已抢完');

        if (isAlreadyClaimed) {
          // 已领取状态：直接进入catch流程，不显示具体金额
          // 通过事件向上传递已领取状态
          this.$emit('claim-already-taken', {
            redPackageId: this.redPackageId,
            msgInfo: this.msgInfo
          });
        } else {
          // 其他错误：显示错误提示
          uni.showToast({
            title: errorMessage,
            icon: 'none',
            duration: 2000
          });
        }

        // 调用失败回调
        if (typeof reject === 'function') {
          reject(new Error(errorMessage));
        }
      } catch (processError) {
        console.error('处理红包错误回调失败:', processError);
        // 确保loading状态被重置
        this.loading = false;
        if (typeof reject === 'function') {
          reject(new Error('处理失败'));
        }
      }
    },
    closeSuccessPopup () {
      this.showSuccessPopup = false;
    }
  }
}
</script>

<style scoped lang="scss">
.red-package-item {
  width: 500rpx;
  margin: 10rpx 0;

  .red-package-bg {
    background: linear-gradient(135deg, #ff6b6b, #ff8e8e);
    border-radius: 20rpx;
    padding: 30rpx;
    color: white;
    position: relative;
    overflow: hidden;

    &.received {
      background: linear-gradient(135deg, #999, #bbb);
      opacity: 0.7;
    }

    &.loading {
      opacity: 0.8;
      pointer-events: none;
    }

    &::before {
      content: '';
      position: absolute;
      top: -50%;
      right: -50%;
      width: 200%;
      height: 200%;
      background: radial-gradient(circle, rgba(255, 255, 255, 0.1) 0%, transparent 70%);
      pointer-events: none;
    }

    .red-package-header {
      display: flex;
      flex-direction: row;
      flex-wrap: nowrap;
      align-content: center;
      justify-content: flex-start;
      align-items: center;

      .icon {
        margin-right: 20rpx;

        .iconfont {
          font-size: 60rpx;
        }
      }

      .info {
        flex: 1;

        .title {
          display: block;
          font-size: 32rpx;
          font-weight: bold;
          margin-bottom: 8rpx;
        }

        .desc {
          display: block;
          font-size: 24rpx;
          opacity: 0.9;
        }
      }
    }

    .red-package-footer {
      display: flex;
      justify-content: space-between;
      align-items: center;

      .amount-info {
        .total-amount {
          display: block;
          font-size: 28rpx;
          font-weight: bold;
          margin-bottom: 4rpx;
        }

        .count-info {
          display: block;
          font-size: 22rpx;
          opacity: 0.8;
        }
      }

      .action-btn {
        padding: 12rpx 24rpx;
        background: rgba(255, 255, 255, 0.2);
        border-radius: 30rpx;
        border: 2rpx solid rgba(255, 255, 255, 0.3);

        text {
          font-size: 24rpx;
          color: white;
        }

        &.disabled {
          opacity: 0.6;
          background: rgba(0, 0, 0, 0.2);
        }
      }
    }

    .loading-overlay {
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      display: flex;
      align-items: center;
      justify-content: center;
      background: rgba(0, 0, 0, 0.1);
      border-radius: 20rpx;

      .loading-spinner {
        width: 40rpx;
        height: 40rpx;
        border: 4rpx solid rgba(255, 255, 255, 0.3);
        border-top: 4rpx solid white;
        border-radius: 50%;
        animation: spin 1s linear infinite;
      }
    }
  }
}

.success-popup {
  width: 500rpx;
  background: white;
  border-radius: 20rpx;
  padding: 60rpx 40rpx 40rpx;
  text-align: center;

  .success-icon {
    font-size: 80rpx;
    margin-bottom: 20rpx;
  }

  .success-title {
    display: block;
    font-size: 32rpx;
    color: #333;
    margin-bottom: 10rpx;
  }

  .success-amount {
    display: block;
    font-size: 48rpx;
    color: #ff6b6b;
    font-weight: bold;
    margin-bottom: 40rpx;
  }

  .success-btn {
    width: 200rpx;
    height: 70rpx;
    line-height: 70rpx;
    background: #ff6b6b;
    color: white;
    border: none;
    border-radius: 35rpx;
    font-size: 28rpx;
  }
}

@keyframes spin {
  0% {
    transform: rotate(0deg);
  }

  100% {
    transform: rotate(360deg);
  }
}
</style>