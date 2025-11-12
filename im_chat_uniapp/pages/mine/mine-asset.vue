<template>
  <view class="page mine-asset">
    <nav-bar title="我的资产" back></nav-bar>

    <!-- 设置交易密码弹窗 -->
    <uni-popup ref="passwordModal" type="center" :mask-click="false" :closeable="false">
      <view class="password-modal">
        <view class="modal-header">
          <text class="modal-title">设置交易密码</text>
          <text class="modal-subtitle">为了您的资产安全，必须设置6位数字交易密码后才能使用资产功能</text>
        </view>

        <view class="modal-content">
          <view class="input-group">
            <text class="input-label">请输入交易密码</text>
            <input class="password-input" type="number" maxlength="6" password v-model="firstPassword"
              placeholder="请输入6位数字密码" @input="onFirstPasswordInput" />
          </view>

          <view class="input-group">
            <text class="input-label">确认交易密码</text>
            <input class="password-input" type="number" maxlength="6" password v-model="confirmPassword"
              placeholder="请再次输入密码确认" @input="onConfirmPasswordInput" />
          </view>

          <view v-if="passwordError" class="error-tip">
            <text>{{ passwordError }}</text>
          </view>
        </view>

        <view class="modal-footer">
          <button class="btn-primary full-width" :class="{ disabled: !canSubmitPassword }"
            :disabled="!canSubmitPassword" @tap="onSetPassword">
            {{ passwordLoading ? '设置中...' : '确认设置' }}
          </button>
        </view>
      </view>
    </uni-popup>

    <!-- 钱包地址绑定弹窗 -->
    <uni-popup ref="walletModal" type="center" :mask-click="false" :closeable="false">
      <view class="wallet-modal">
        <view class="modal-header">
          <text class="modal-title">绑定钱包地址</text>
          <text class="modal-subtitle">请输入您的bsc链钱包地址，用于接收充值</text>
        </view>

        <view class="modal-content">
          <view class="input-group">
            <text class="input-label">钱包地址</text>
            <textarea class="wallet-input" v-model="walletAddress" placeholder="请输入钱包地址" auto-height maxlength="200" />
          </view>

          <view class="input-group">
            <text class="input-label">交易密码</text>
            <input class="password-input" type="number" maxlength="6" password v-model="walletTradePassword"
              placeholder="请输入6位交易密码" />
          </view>

          <view v-if="walletError" class="error-tip">
            <text>{{ walletError }}</text>
          </view>
        </view>

        <view class="modal-footer">
          <button class="btn-secondary" @tap="onCancelBindWallet" :disabled="walletLoading">
            取消
          </button>
          <button class="btn-primary" :class="{ disabled: !canSubmitWallet }" :disabled="!canSubmitWallet"
            @tap="onBindWallet">
            {{ walletLoading ? '绑定中...' : '确认绑定' }}
          </button>
        </view>
      </view>
    </uni-popup>

    <!-- 资产总览 -->
    <uni-card :is-shadow="false" is-full :border="false">
      <view class="asset-overview">
        <view class="asset-item">
          <view class="asset-info">
            <text class="asset-name">USDT</text>
            <text class="asset-desc">USDT</text>
          </view>
          <view class="asset-balance">
            <text class="balance-amount">{{ usdtBalance }}</text>
            <text class="balance-unit">USDT</text>
          </view>
        </view>

        <!-- <view class="asset-item">
          <view class="asset-info">
            <text class="asset-name">IM</text>
            <text class="asset-desc">IM</text>
          </view>
          <view class="asset-balance">
            <text class="balance-amount">{{ imBalance }}</text>
            <text class="balance-unit">IM</text>
          </view>
        </view> -->
      </view>
    </uni-card>

    <!-- 钱包地址信息 -->
    <bar-group v-if="userInfo.walletAddress">
      <view class="section-title">钱包信息</view>
      <arrow-bar title="已绑定钱包地址" icon="icon-wallet" icon-color="#52c41a">
        <text class="wallet-address">{{ formatWalletAddress(userInfo.walletAddress) }}</text>
      </arrow-bar>
    </bar-group>

    <!-- USDT操作 -->
    <bar-group>
      <view class="section-title">USDT操作</view>
      <arrow-bar title="获取充值地址" icon="icon-recharge" @tap="onGetDepositAddress()" icon-color="#52c41a">
        <text class="arrow-text"></text>
      </arrow-bar>
      <arrow-bar title="提现" icon="icon-withdraw" @tap="onWithdraw()" icon-color="#ff4d4f">
        <text class="arrow-text">转出到钱包</text>
      </arrow-bar>
      <arrow-bar title="交易记录" icon="icon-record" @tap="onTransactionHistory()" icon-color="#1890ff"></arrow-bar>
    </bar-group>

    <!-- 钱包管理 -->
    <bar-group>
      <view class="section-title">钱包管理</view>
      <arrow-bar title="绑定钱包地址" icon="icon-wallet" @tap="onShowBindWallet()" icon-color="#fa8c16">
        <text class="arrow-text">{{ userInfo.walletAddress ? '重新绑定' : '立即绑定' }}</text>
      </arrow-bar>
    </bar-group>

    <!-- 交易密码管理 -->
    <bar-group>
      <view class="section-title">安全设置</view>
      <arrow-bar title="交易密码" icon="icon-password" @tap="onTransactionPassword()" icon-color="#fa8c16">
        <text class="arrow-text">{{ hasTransactionPassword ? '修改' : '设置' }}</text>
      </arrow-bar>
    </bar-group>

    <!-- VIP功能 -->
    <bar-group v-if="userInfo.userType !== $enums.USER_TYPE.VIP">
      <view class="section-title">VIP特权</view>
      <arrow-bar title="购买VIP" icon="icon-vip" @tap="onPurchaseVip()" icon-color="#faad14">
        <text class="arrow-text">享受专属特权</text>
      </arrow-bar>
    </bar-group>

    <bar-group v-if="userInfo.userType === $enums.USER_TYPE.VIP">
      <view class="section-title">VIP管理</view>
      <arrow-bar title="我的群组" icon="icon-group" @tap="onMyGroups()" icon-color="#13c2c2">
        <text class="arrow-text">0/3</text>
      </arrow-bar>
      <arrow-bar title="VIP到期时间" icon="icon-time" icon-color="#eb2f96">
        <text class="arrow-text">未设置</text>
      </arrow-bar>
    </bar-group>
  </view>
</template>

<script>
import { mapStores } from 'pinia';
import useUserStore from '@/store/userStore.js';

export default {
  name: "mine-asset",
  data() {
    return {
      // 交易密码设置相关
      firstPassword: '',
      confirmPassword: '',
      passwordError: '',
      passwordLoading: false,
      // 是否已检查过首次进入
      hasCheckedFirstEntry: false,
      // 钱包地址绑定相关
      walletAddress: '',
      walletTradePassword: '',
      walletError: '',
      walletLoading: false
    }
  },
  methods: {
    // 检查是否需要弹出交易密码设置弹窗
    checkFirstEntryPasswordSetup() {
      if (this.hasCheckedFirstEntry) return;

      this.hasCheckedFirstEntry = true;

      // 如果用户还没有设置交易密码，弹出设置弹窗
      if (!this.userInfo.tradePassword) {
        setTimeout(() => {
          this.$refs.passwordModal.open();
        }, 500); // 延迟500ms确保页面完全加载
      }
    },

    // 第一个密码输入处理
    onFirstPasswordInput() {
      this.passwordError = '';
      if (this.firstPassword.length === 6 && this.confirmPassword.length === 6) {
        this.validatePasswords();
      }
    },

    // 确认密码输入处理
    onConfirmPasswordInput() {
      this.passwordError = '';
      if (this.firstPassword.length === 6 && this.confirmPassword.length === 6) {
        this.validatePasswords();
      }
    },

    // 验证密码
    validatePasswords() {
      if (this.firstPassword !== this.confirmPassword) {
        this.passwordError = '两次输入的密码不一致';
        return false;
      }
      return true;
    },

    // 设置交易密码
    onSetPassword() {
      if (!this.canSubmitPassword) return;

      if (!this.validatePasswords()) return;

      this.passwordLoading = true;

      this.$http({
        url: '/setTradePwd',
        method: 'PUT',
        header: {
          'Content-Type': 'application/json'
        },
        data: {
          tradePassword: this.firstPassword
        }
      }).then(() => {
        // 设置成功
        uni.showToast({
          title: '交易密码设置成功',
          icon: 'success'
        });

        // 关闭弹窗
        this.$refs.passwordModal.close();

        // 清空密码
        this.firstPassword = '';
        this.confirmPassword = '';
        this.passwordError = '';

        // 更新用户信息
        this.userStore.loadUser();

      }).catch((err) => {
        console.error('设置交易密码失败:', err);

        // 显示错误信息
        if (err.message) {
          this.passwordError = err.message;
        } else {
          uni.showToast({
            title: '设置失败，请重试',
            icon: 'none'
          });
        }
      }).finally(() => {
        this.passwordLoading = false;
      });
    },



    // 获取充值地址
    onGetDepositAddress() {
      // 检查是否已绑定钱包地址
      if (!this.userInfo.walletAddress) {
        uni.showToast({
          title: '请先绑定钱包地址才能获取充值地址',
          icon: 'none',
          duration: 2000
        });
        return;
      }

      // 跳转到充值页面
      uni.navigateTo({
        url: '/pages/mine/mine-deposit'
      });
    },

    // 显示绑定钱包地址弹窗
    onShowBindWallet() {
      // 清空之前的输入
      this.walletAddress = this.userInfo.walletAddress || '';
      this.walletError = '';
      // 显示弹窗
      this.$refs.walletModal.open();
    },

    // 取消绑定钱包地址
    onCancelBindWallet() {
      this.$refs.walletModal.close();
      this.walletAddress = '';
      this.walletTradePassword = '';
      this.walletError = '';
    },

    // 绑定钱包地址
    onBindWallet() {
      if (!this.canSubmitWallet) return;

      // 验证交易密码
      if (this.walletTradePassword.length !== 6) {
        this.walletError = '请输入6位交易密码';
        return;
      }

      this.walletLoading = true;
      this.walletError = '';

      this.$http({
        url: '/user/bindWalletAddress',
        method: 'PUT',
        header: {
          'Content-Type': 'application/json'
        },
        data: {
          walletAddress: this.walletAddress.trim(),
          tradePassword: this.walletTradePassword
        }
      }).then(() => {

        // 绑定成功
        uni.showToast({
          title: '钱包地址绑定成功',
          icon: 'success'
        });

        // 关闭弹窗
        this.$refs.walletModal.close();

        // 清空输入
        this.walletAddress = '';
        this.walletTradePassword = '';
        this.walletError = '';

        // 更新用户信息
        this.userStore.loadUser();

      }).catch((err) => {
        console.error('绑定钱包地址失败:', err);

        // 显示错误信息
        if (err.message) {
          this.walletError = err.message;
        } else {
          uni.showToast({
            title: '绑定失败，请重试',
            icon: 'none'
          });
        }
      }).finally(() => {
        this.walletLoading = false;
      });
    },

    // USDT提现
    onWithdraw() {
      if (!this.userInfo.tradePassword) {
        uni.showModal({
          title: '提示',
          content: '请先设置交易密码',
          success: (res) => {
            if (res.confirm) {
              this.onTransactionPassword();
            }
          }
        });
        return;
      }
      uni.navigateTo({
        url: '/pages/mine/mine-withdraw'
      });
    },

    // 交易记录
    onTransactionHistory() {
      uni.navigateTo({
        url: '/pages/mine/mine-transaction-history'
      });
    },

    // 交易密码管理
    onTransactionPassword() {
      uni.navigateTo({
        url: '/pages/mine/mine-transaction-password'
      });
    },

    // 购买VIP
    onPurchaseVip() {
      uni.navigateTo({
        url: '/pages/mine/mine-vip-purchase'
      });
    },

    // 我的群组
    onMyGroups() {
      uni.navigateTo({
        url: '/pages/mine/mine-vip-groups'
      });
    },
    // 格式化钱包地址显示
    formatWalletAddress(address) {
      console.log('格式化钱包地址显示 address', address);
      if (address) {
        return address.substring(0, 6) + '...' + address.substring(address.length - 6);
      }

    },
  },
  computed: {
    userInfo() {
      return this.userStore.userInfo;
    },
    usdtBalance() {
      return this.userInfo.balance || '0.00';
    },
    imBalance() {
      return this.userInfo.im || '0';
    },
    // 交易密码设置状态
    hasTransactionPassword() {
      return !!this.userInfo.tradePassword;
    },

    // 是否可以提交密码设置
    canSubmitPassword() {
      return this.firstPassword.length === 6 &&
        this.confirmPassword.length === 6 &&
        !this.passwordError &&
        !this.passwordLoading;
    },

    // 是否可以提交钱包地址绑定
    canSubmitWallet() {
      return this.walletAddress.trim().length > 0 &&
        this.walletTradePassword.length === 6 &&
        !this.walletError &&
        !this.walletLoading;
    }
  },
  ...mapStores(useUserStore),



  onLoad() {
    // 页面加载时检查是否需要设置交易密码
    this.$nextTick(() => {
      this.checkFirstEntryPasswordSetup();
    });
  },

  onShow() {
    // 页面显示时刷新数据和检查密码设置
    if (!this.hasCheckedFirstEntry) {
      this.$nextTick(() => {
        this.checkFirstEntryPasswordSetup();
      });
    }
  }
}
</script>

<style lang="scss" scoped>
.password-modal,
.wallet-modal {
  width: 600rpx;
  background: white;
  border-radius: 20rpx;
  padding: 40rpx;

  .modal-header {
    text-align: center;
    margin-bottom: 40rpx;

    .modal-title {
      font-size: 36rpx;
      font-weight: 600;
      color: #333;
      display: block;
      margin-bottom: 16rpx;
    }

    .modal-subtitle {
      font-size: 28rpx;
      color: #666;
      display: block;
      line-height: 1.4;
    }
  }

  .modal-content {
    margin-bottom: 40rpx;

    .input-group {
      margin-bottom: 30rpx;

      .input-label {
        font-size: 28rpx;
        color: #333;
        display: block;
        margin-bottom: 16rpx;
        font-weight: 500;
      }

      .password-input,
      .wallet-input {
        width: 100%;
        height: 80rpx;
        border: 2rpx solid #e0e0e0;
        border-radius: 12rpx;
        padding: 0 20rpx;
        font-size: 32rpx;
        box-sizing: border-box;

        &:focus {
          border-color: #1890ff;
        }
      }

      .wallet-input {
        min-height: 120rpx;
        padding: 20rpx;
        line-height: 1.4;
      }
    }

    .error-tip {
      padding: 16rpx 20rpx;
      background: #fff2f0;
      border: 1rpx solid #ffccc7;
      border-radius: 8rpx;
      margin-top: 20rpx;

      text {
        font-size: 26rpx;
        color: #ff4d4f;
      }
    }
  }

  .modal-footer {
    display: flex;
    gap: 20rpx;

    button {
      flex: 1;
      height: 80rpx;
      border-radius: 12rpx;
      font-size: 30rpx;
      font-weight: 500;
      border: none;

      &.btn-primary {
        background: #1890ff;
        color: white;

        &.disabled {
          background: #d9d9d9;
          color: #999;
        }
      }

      &.btn-secondary {
        background: #f5f5f5;
        color: #666;

        &:disabled {
          background: #f0f0f0;
          color: #ccc;
        }
      }
    }
  }
}

.mine-asset {
  .asset-overview {
    padding: 30rpx;

    .asset-item {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 30rpx 0;
      border-bottom: 1rpx solid #f0f0f0;

      &:last-child {
        border-bottom: none;
      }

      .asset-info {
        display: flex;
        flex-direction: column;

        .asset-name {
          font-size: $im-font-size-large;
          font-weight: 600;
          color: $im-text-color-dark;
          margin-bottom: 8rpx;
        }

        .asset-desc {
          font-size: $im-font-size-small;
          color: $im-text-color-light;
        }
      }

      .asset-balance {
        display: flex;
        flex-direction: column;
        align-items: flex-end;

        .balance-amount {
          font-size: 48rpx;
          font-weight: 600;
          color: $im-color-primary;
          margin-bottom: 8rpx;
        }

        .balance-unit {
          font-size: $im-font-size-small;
          color: $im-text-color-light;
        }
      }
    }
  }

  .section-title {
    padding: 20rpx 30rpx 10rpx 30rpx;
    font-size: $im-font-size;
    color: $im-text-color-light;
    font-weight: 600;
  }

  .arrow-text {
    color: $im-text-color-lighter;
    font-size: $im-font-size-small;
  }

  .wallet-address {
    color: $im-text-color-light;
    font-size: $im-font-size-small;
    font-family: monospace;
  }
}
</style>