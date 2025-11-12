<template>
  <view class="page mine-transaction-history">
    <nav-bar title="交易记录" back></nav-bar>

    <!-- 交易记录列表 -->
    <view class="transaction-list">
      <view v-for="(item, index) in transactionList" :key="item.id" class="transaction-item" @tap="viewDetail(item)">
        <view class="transaction-icon" :class="getIconClass(item.transferFlag)">
          <uni-icons :type="getTransactionIcon(item.transferFlag)" color="#ffffff" size="20"></uni-icons>
        </view>

        <view class="transaction-info">
          <view class="transaction-title">{{ item.describes }}</view>
          <view class="transaction-desc">
            <text class="time">{{ formatTime(item.txTime) }}</text>
            <text v-if="item.orderNo" class="order-no">{{ formatOrderNo(item.orderNo) }}</text>
          </view>
        </view>

        <view class="transaction-amount">
          <text class="amount" :class="getAmountClass(item.transferFlag)">{{ getAmountText(item) }}</text>
          <text class="unit">USDT</text>
        </view>
      </view>

      <!-- 加载更多 -->
      <uni-load-more v-if="transactionList.length > 0" :status="loadMoreStatus"
        @clickLoadMore="loadMore"></uni-load-more>
    </view>

    <!-- 空状态 -->
    <view class="empty-state" v-if="transactionList.length === 0 && !loading">
      <uni-icons type="list" color="#d9d9d9" size="80"></uni-icons>
      <text class="empty-text">暂无交易记录</text>
      <text class="empty-desc">您的交易记录将显示在这里</text>
    </view>
  </view>
</template>

<script>
export default {
  name: "mine-transaction-history",
  data () {
    return {
      transactionList: [],
      loading: false,
      loadMoreStatus: 'more',
      pageNum: 1,
      pageSize: 20,
      hasMore: true,
      transferFlag: null, // 转账标志：1-收入，2-支出，null-全部
      describes: '' // 描述信息筛选
    }
  },

  methods: {
    // 加载交易记录
    loadTransactionList () {
      if (this.loading) return;

      this.loading = true;
      this.loadMoreStatus = 'loading';

      const params = {
        pageNum: this.pageNum,
        pageSize: this.pageSize
      };

      // 添加可选参数
      if (this.transferFlag !== null) {
        params.transferFlag = this.transferFlag;
      }
      if (this.describes) {
        params.describes = this.describes;
      }

      this.$http({
        url: '/user/queryUserFundDetail',
        method: 'GET',
        data: params
      }).then((res) => {
        // 输出response
        console.log('response:', res);
        // 根据实际响应数据结构处理
        // 响应直接返回数组数据，不是标准的{code, message, data}格式
        const newList = Array.isArray(res) ? res : (res.data || []);

        if (this.pageNum === 1) {
          this.transactionList = newList;
        } else {
          this.transactionList = [...this.transactionList, ...newList];
        }

        this.hasMore = newList.length === this.pageSize;
        this.loadMoreStatus = this.hasMore ? 'more' : 'noMore';

      }).catch((err) => {
        console.error('加载交易记录失败:', err);
        this.loadMoreStatus = 'more';
        if (this.pageNum === 1) {
          uni.showToast({
            title: '网络错误，请重试',
            icon: 'none'
          });
        }
      }).finally(() => {
        this.loading = false;
      });
    },

    // 加载更多
    loadMore () {
      if (!this.hasMore || this.loading) return;

      this.pageNum++;
      this.loadTransactionList();
    },

    // 查看详情
    viewDetail (item) {
      // 将交易数据编码后传递给详情页面
      const transactionData = encodeURIComponent(JSON.stringify(item));
      uni.navigateTo({
        url: `/pages/mine/mine-transaction-detail?data=${transactionData}`
      });
    },

    // 获取交易图标 (根据transferFlag: 1-收入, 2-支出)
    getTransactionIcon (transferFlag) {
      return transferFlag === 1 ? 'arrowdown' : 'arrowup';
    },

    // 获取交易颜色
    getTransactionColor (transferFlag) {
      return transferFlag === 1 ? '#52c41a' : '#ff4d4f';
    },

    // 获取图标样式类
    getIconClass (transferFlag) {
      return transferFlag === 1 ? 'icon-income' : 'icon-expense';
    },

    // 格式化订单号
    formatOrderNo (orderNo) {
      if (!orderNo) return '';
      // 只显示前6位和后4位，中间用...代替
      if (orderNo.length > 10) {
        return orderNo.substring(0, 6) + '...' + orderNo.substring(orderNo.length - 4);
      }
      return orderNo;
    },

    // 获取金额样式类
    getAmountClass (transferFlag) {
      return transferFlag === 1 ? 'positive' : 'negative';
    },

    // 获取金额文本
    getAmountText (item) {
      const prefix = item.transferFlag === 1 ? '+' : '-';
      return prefix + item.amount;
    },

    // 格式化时间
    formatTime (dateTimeStr) {
      if (!dateTimeStr) return '';

      const date = new Date(dateTimeStr);
      return date.toLocaleString('zh-CN', {
        year: 'numeric',
        month: '2-digit',
        day: '2-digit',
        hour: '2-digit',
        minute: '2-digit',
        second: '2-digit'
      });
    }
  },
  onLoad () {
    this.loadTransactionList();
  },
  onPullDownRefresh () {
    this.pageNum = 1;
    this.hasMore = true;
    this.transactionList = [];
    this.loadTransactionList();
    setTimeout(() => {
      uni.stopPullDownRefresh();
    }, 1000);
  },
  onReachBottom () {
    this.loadMore();
  }
}
</script>

<style lang="scss" scoped>
.mine-transaction-history {

  .transaction-list {
    padding: 0 30rpx;

    .transaction-item {
      display: flex;
      align-items: center;
      padding: 30rpx 0;
      border-bottom: 1rpx solid #f0f0f0;

      &:last-child {
        border-bottom: none;
      }

      .transaction-icon {
        width: 72rpx;
        height: 72rpx;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-right: 24rpx;
        box-shadow: 0 2rpx 8rpx rgba(0, 0, 0, 0.1);

        &.icon-income {
          background: linear-gradient(135deg, #52c41a, #73d13d);
        }

        &.icon-expense {
          background: linear-gradient(135deg, #ff4d4f, #ff7875);
        }
      }

      .transaction-info {
        flex: 1;
        margin-right: 20rpx;

        .transaction-title {
          font-size: $im-font-size;
          font-weight: 600;
          color: $im-text-color-dark;
          margin-bottom: 8rpx;
        }

        .transaction-desc {
          display: flex;
          flex-direction: column;
          gap: 6rpx;

          .time {
            font-size: $im-font-size-small;
            color: $im-text-color-light;
          }

          .order-no {
            padding: 4rpx 12rpx;
            border-radius: 12rpx;
            background-color: #e6f7ff;
            font-size: 22rpx;
            color: #1890ff;
            font-family: 'Courier New', monospace;
            max-width: 200rpx;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
          }
        }
      }

      .transaction-amount {
        display: flex;
        flex-direction: column;
        align-items: flex-end;

        .amount {
          font-size: $im-font-size;
          font-weight: 600;
          margin-bottom: 4rpx;

          &.positive {
            color: #52c41a;
          }

          &.negative {
            color: #ff4d4f;
          }
        }

        .unit {
          font-size: $im-font-size-small;
          color: $im-text-color-light;
        }
      }
    }
  }

  .empty-state {
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: 120rpx 30rpx;

    .empty-text {
      font-size: $im-font-size;
      color: $im-text-color;
      margin: 30rpx 0 10rpx 0;
    }

    .empty-desc {
      font-size: $im-font-size-small;
      color: $im-text-color-light;
    }
  }
}
</style>