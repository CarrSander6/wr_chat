<template>
  <view class="page mine">
    <nav-bar title="我的"></nav-bar>
    <uni-card :is-shadow="false" is-full :border="false">
      <view class="content" @click="onModifyInfo()">
        <head-image :name="userInfo.nickName" :url="userInfo.headImage" :size="160"></head-image>
        <view class="info-item">
          <view class="info-primary">
            <text class="nick-name">{{ userInfo.nickName }}</text>
            <text v-show="userInfo.sex == 0" class="iconfont icon-man" color="darkblue"></text>
            <text v-show="userInfo.sex == 1" class="iconfont icon-girl" color="darkred"></text>
          </view>

          <view class="info-text">
            <text class="label-text">用户名:</text>
            <text class="content-text"> {{ userInfo.userName }}</text>
          </view>
          <view class="signature-text">
            <text v-if="userInfo.signature"> {{ userInfo.signature }}</text>
          </view>
          <view class="user-type-badge">
            <text class="user-type-text" :class="getUserTypeClass()">{{ getUserTypeText() }}</text>
          </view>

        </view>
        <view class="btn-wrap">
          <text class="icon iconfont icon-qrcode" @click.stop="onShowQrcode()"></text>
          <uni-icons class="info-arrow" type="right" size="16"></uni-icons>
        </view>
      </view>
    </uni-card>
    <bar-group>
      <arrow-bar title="我的资产" icon="icon-receipt" @tap="onAssetManagement()" icon-color="#1890ff"></arrow-bar>
    </bar-group>
    <bar-group>
      <arrow-bar title="修改密码" icon="icon-modify-pwd" @tap="onModifyPassword()" icon-color="#5daa31"></arrow-bar>
      <arrow-bar title="注销账号" icon="icon-un-register" @tap="onUnregister()" icon-color="#e43d33"></arrow-bar>
    </bar-group>
    <!-- <bar-group>
      <arrow-bar title="用户协议" icon="icon-user-protocol" @tap="onShowProtocol()" icon-color="#ef975d"></arrow-bar>
      <arrow-bar title="隐私政策" icon="icon-privacy-protocol" @tap="onShowPrivacy()" icon-color="#8575e8"></arrow-bar>
    </bar-group> -->
    <bar-group>
      <arrow-bar title="通用设置" icon="icon-setting" @tap="onSetting()" icon-color="#3d13c3"></arrow-bar>
    </bar-group>
    <bar-group>
      <arrow-bar title="我的投诉" icon="icon-complaint" @tap="onComplaintHistory()" icon-color="#3d13c3"></arrow-bar>
    </bar-group>
    <bar-group>
      <btn-bar title="退出登录" type="danger" @tap="onQuit()"></btn-bar>
    </bar-group>
    <popup-modal ref="modal"></popup-modal>
  </view>
</template>

<script>
import UNI_APP from '@/.env.js';
export default {
  data () {
    return {}
  },
  methods: {
    onModifyInfo () {
      uni.navigateTo({
        url: "/pages/mine/mine-edit"
      })
    },
    onAssetManagement () {
      uni.navigateTo({
        url: "/pages/mine/mine-asset"
      })
    },
    onModifyPassword () {
      uni.navigateTo({
        url: "/pages/mine/mine-password"
      })
    },
    onUnregister () {
      this.$refs.modal.open({
        title: '注销账号',
        content: '账号注销后将无法恢复，确认注销吗?',
        success: () => {
          this.$http({
            url: '/unregister',
            method: 'DELETE'
          })
        }
      });
    },
    onShowQrcode () {
      uni.navigateTo({
        url: '/pages/mine/mine-qrcode'
      })
    },
    onShowProtocol () {
      const linkUrl = encodeURIComponent(UNI_APP.PROTOCOL_URL);
      uni.navigateTo({
        url: '/pages/common/external-link?url=' + linkUrl
      });
    },
    onShowPrivacy () {
      const linkUrl = encodeURIComponent(UNI_APP.PRIVACY_URL);
      uni.navigateTo({
        url: '/pages/common/external-link?url=' + linkUrl
      });
    },
    onSetting () {
      uni.navigateTo({
        url: "/pages/mine/mine-setting"
      })
    },
    onComplaintHistory () {
      uni.navigateTo({
        url: "/pages/complaint/complaint-history"
      })
    },
    onQuit () {
      this.$refs.modal.open({
        title: '确认退出?',
        success: () => {
          // 主动退出后不再接收离线通知
          getApp().$vm.removeCid();
          getApp().$vm.exit()
        }
      });
    },
    getUserTypeText () {
      switch (this.userInfo.type) {
        case this.$enums.USER_TYPE.NORMAL:
          return '普通用户';
        case this.$enums.USER_TYPE.AUDIT:
          return '审核账户';
        case this.$enums.USER_TYPE.VIP:
          return 'VIP用户';
        case this.$enums.USER_TYPE.ADMIN:
          return '管理员';
        default:
          return '普通用户';
      }
    },
    getUserTypeClass () {
      switch (this.userInfo.type) {
        case this.$enums.USER_TYPE.NORMAL:
          return 'user-type-normal';
        case this.$enums.USER_TYPE.AUDIT:
          return 'user-type-audit';
        case this.$enums.USER_TYPE.VIP:
          return 'user-type-vip';
        case this.$enums.USER_TYPE.ADMIN:
          return 'user-type-admin';
        default:
          return 'user-type-normal';
      }
    }
  },
  computed: {
    userInfo () {
      return this.userStore.userInfo;
    }
  },
  onShow () {
    // 每个tab页都要更新一下角标数量
    this.$badge.refreshFriendBadge();
    this.$badge.refreshChatBadge();
  }
}
</script>

<style scoped lang="scss">
.mine {
  .content {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 10rpx;
    padding-right: 30rpx;
    overflow: hidden;

    .info-item {
      display: flex;
      align-items: flex-start;
      flex-direction: column;
      padding-left: 40rpx;
      flex: 1;

      .info-text {
        line-height: 1.5;
        font-size: $im-font-size-small;
        color: $im-text-color-light;
      }

      .content-text {
        margin-left: 10rpx;
        word-break: break-all;
        overflow: hidden;
      }

      .signature-text {
        color: $im-text-color-light;
        word-break: break-all;
        overflow: hidden;
      }

      .info-primary {
        display: flex;
        align-items: center;
        margin-bottom: 10rpx;

        .nick-name {
          font-size: $im-font-size-large;
          font-weight: 600;
        }

        .iconfont {
          font-size: $im-font-size;
          padding-left: 5rpx;
        }

        .icon-man {
          color: darkblue;
        }

        .icon-girl {
          color: darkred;
        }
      }

      .user-type-badge {
        margin-bottom: 8rpx;

        .user-type-text {
          font-size: 24rpx;
          font-weight: 500;
          padding: 4rpx 12rpx;
          border-radius: 12rpx;
          display: inline-block;
          line-height: 1.2;

          &.user-type-normal {
            color: #666666;
            background-color: #f5f5f5;
            border: 1rpx solid #d9d9d9;
          }

          &.user-type-audit {
            color: #fa8c16;
            background-color: #fff7e6;
            border: 1rpx solid #ffd591;
          }

          &.user-type-vip {
            color: #722ed1;
            background-color: #f9f0ff;
            border: 1rpx solid #d3adf7;
          }

          &.user-type-admin {
            color: #cf1322;
            background-color: #fff1f0;
            border: 1rpx solid #ffa39e;
          }
        }
      }
    }

    .btn-wrap {
      display: flex;
      flex-direction: column;
      width: 50rpx;
      position: relative;
      left: 20rpx;

      .icon-qrcode {
        font-size: 35rpx;
      }

      .info-arrow {
        font-size: 30rpx;
        margin-top: 30rpx;
      }

    }

  }
}
</style>