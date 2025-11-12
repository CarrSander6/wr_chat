<template>
  <view class="page mine-transaction-password">
    <nav-bar title="修改交易密码" back></nav-bar>

    <!-- 密码设置说明 -->
    <uni-card :is-shadow="false" is-full :border="false">
      <view class="password-notice">
        <view class="notice-title">
          <uni-icons type="info-filled" color="#1890ff" size="18"></uni-icons>
          <text>密码要求</text>
        </view>
        <view class="notice-content">
          <text>• 交易密码必须为6位纯数字</text>
          <text>• 用于USDT提现等重要操作验证</text>
          <text>• 请勿与登录密码设置相同</text>
          <text>• 请妥善保管，遗忘后需联系客服</text>
        </view>
      </view>
    </uni-card>

    <!-- 密码设置表单 -->
    <uni-card :is-shadow="false" is-full :border="false">
      <view class="password-form">
        <!-- 原交易密码 -->
        <view class="form-item">
          <view class="form-label">原交易密码</view>
          <input v-model="passwordForm.oldPassword" class="form-input" placeholder="请输入原交易密码" type="number"
            maxlength="6" password />
        </view>

        <!-- 新交易密码 -->
        <view class="form-item">
          <view class="form-label">新交易密码</view>
          <input v-model="passwordForm.newPassword" class="form-input" placeholder="请输入6位数字交易密码" type="number"
            maxlength="6" password @input="onPasswordInput" />
          <view class="password-strength" v-if="passwordForm.newPassword">
            <text :class="passwordStrengthClass">{{ passwordStrengthText }}</text>
          </view>
        </view>

        <!-- 确认交易密码 -->
        <view class="form-item">
          <view class="form-label">确认交易密码</view>
          <input v-model="passwordForm.confirmPassword" class="form-input" placeholder="请再次输入交易密码" type="number"
            maxlength="6" password />
          <view class="password-match" v-if="passwordForm.confirmPassword">
            <text :class="passwordMatchClass">{{ passwordMatchText }}</text>
          </view>
        </view>
      </view>
    </uni-card>

    <!-- 提交按钮 -->
    <view class="submit-wrapper">
      <button class="submit-btn" :class="{ disabled: !canSubmit }" :disabled="!canSubmit" @tap="submitPassword">
        {{ submitLoading ? '提交中...' : '修改密码' }}
      </button>
    </view>
  </view>
</template>

<script>
import { mapStores } from 'pinia';
import useUserStore from '../../store/userStore.js';

export default {
  name: "mine-transaction-password",
  data () {
    return {
      hasPassword: false,
      submitLoading: false,
      passwordForm: {
        oldPassword: '',
        newPassword: '',
        confirmPassword: ''
      }
    }
  },
  computed: {
    // 用户信息
    userInfo () {
      return this.userStore.userInfo || {};
    },
    // 密码强度
    passwordStrengthClass () {
      const password = this.passwordForm.newPassword;
      if (password.length < 6) return 'weak';

      // 检查是否为纯数字
      if (!/^\d{6}$/.test(password)) return 'invalid';

      // 检查是否为简单数字（如123456、111111等）
      if (this.isSimplePassword(password)) return 'weak';

      return 'strong';
    },

    passwordStrengthText () {
      const password = this.passwordForm.newPassword;
      if (password.length < 6) return '密码长度不足';
      if (!/^\d{6}$/.test(password)) return '必须为6位纯数字';
      if (this.isSimplePassword(password)) return '密码过于简单';
      return '密码强度良好';
    },

    // 密码匹配
    passwordMatchClass () {
      return this.passwordForm.newPassword === this.passwordForm.confirmPassword ? 'match' : 'mismatch';
    },

    passwordMatchText () {
      return this.passwordForm.newPassword === this.passwordForm.confirmPassword ? '密码匹配' : '密码不匹配';
    },

    // 是否可以提交
    canSubmit () {
      const { oldPassword, newPassword, confirmPassword } = this.passwordForm;

      // 基本验证
      if (!oldPassword || !newPassword || !confirmPassword) return false;

      // 新密码格式验证
      if (!/^\d{6}$/.test(newPassword)) return false;

      // 密码匹配验证
      if (newPassword !== confirmPassword) return false;

      // 新旧密码不能相同
      if (newPassword === oldPassword) return false;

      return !this.submitLoading;
    }
  },
  methods: {
    // 检查用户权限
    checkUserPermission () {
      // 检查用户是否已设置交易密码
      if (!this.userInfo.tradePassword) {
        uni.showModal({
          title: '提示',
          content: '请先设置交易密码',
          showCancel: false,
          success: () => {
            // 跳转到资产页面（会自动弹出密码设置弹窗）
            uni.redirectTo({
              url: '/pages/mine/mine-asset'
            });
          }
        });
        return false;
      }
      return true;
    },

    // 检查密码状态
    checkPasswordStatus () {
      // 从用户信息中获取密码状态
      this.hasPassword = !!this.userInfo.tradePassword;
    },

    // 密码输入处理
    onPasswordInput (e) {
      let value = e.detail.value;
      // 只允许数字
      value = value.replace(/\D/g, '');
      if (value.length > 6) {
        value = value.substring(0, 6);
      }
      this.passwordForm.newPassword = value;
    },

    // 检查是否为简单密码
    isSimplePassword (password) {
      // 连续数字
      const consecutive = ['123456', '654321', '012345', '543210'];
      if (consecutive.includes(password)) return true;

      // 重复数字
      if (/^(\d)\1{5}$/.test(password)) return true;

      // 常见弱密码
      const weakPasswords = ['000000', '111111', '222222', '333333', '444444', '555555', '666666', '777777', '888888', '999999'];
      if (weakPasswords.includes(password)) return true;

      return false;
    },

    // 提交密码
    submitPassword () {
      if (!this.canSubmit) return;

      // 最终验证
      if (this.passwordForm.newPassword === this.passwordForm.oldPassword) {
        uni.showToast({
          title: '新密码不能与原密码相同',
          icon: 'none'
        });
        return;
      }

      if (this.isSimplePassword(this.passwordForm.newPassword)) {
        uni.showModal({
          title: '密码安全提示',
          content: '您设置的密码过于简单，建议使用更复杂的数字组合，是否继续？',
          success: (res) => {
            if (res.confirm) {
              this.doSubmitPassword();
            }
          }
        });
      } else {
        this.doSubmitPassword();
      }
    },

    // 执行密码提交
    doSubmitPassword () {
      this.submitLoading = true;

      // 使用修改交易密码接口
      const data = {
        oldPassword: this.passwordForm.oldPassword,
        newPassword: this.passwordForm.newPassword
      };

      this.$http({
        url: '/modifyTradePassword',
        method: 'PUT',
        header: {
          'Content-Type': 'application/json'
        },
        data: data
      }).then((res) => {
        // 检查响应状态
        console.log('检查响应状态 res', res);
        uni.showToast({
          title: '密码修改成功',
          icon: 'success'
        });

        // 清空表单
        this.passwordForm = {
          oldPassword: '',
          newPassword: '',
          confirmPassword: ''
        };

        // 更新用户信息
        this.userStore.loadUser();

        // 返回上一页
        setTimeout(() => {
          uni.navigateBack();
        }, 1500);

      }).catch((err) => {
        console.error('密码修改失败:', err);
        uni.showToast({
          title: err.message || '修改失败，请重试',
          icon: 'none'
        });
      }).finally(() => {
        this.submitLoading = false;
      });
    }
  },
  ...mapStores(useUserStore),
  onLoad () {
    // 检查用户权限
    if (!this.checkUserPermission()) {
      return;
    }

    // 检查密码状态
    this.checkPasswordStatus();
  }
}
</script>

<style lang="scss" scoped>
.mine-transaction-password {
  .password-notice {
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

  .password-form {
    padding: 30rpx;

    .form-item {
      margin-bottom: 40rpx;

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

      .password-strength {
        margin-top: 12rpx;
        font-size: $im-font-size-small;

        .weak {
          color: #ff4d4f;
        }

        .invalid {
          color: #ff4d4f;
        }

        .strong {
          color: #52c41a;
        }
      }

      .password-match {
        margin-top: 12rpx;
        font-size: $im-font-size-small;

        .match {
          color: #52c41a;
        }

        .mismatch {
          color: #ff4d4f;
        }
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