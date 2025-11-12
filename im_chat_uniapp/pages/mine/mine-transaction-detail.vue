<template>
  <view class="page mine-transaction-detail">
    <nav-bar title="交易详情" back></nav-bar>

    <!-- 加载状态 -->
    <view class="loading-container" v-if="loading">
      <uni-load-more status="loading"></uni-load-more>
    </view>

    <!-- 交易详情内容 -->
    <view class="detail-content" v-else-if="transactionDetail">
      <!-- 交易状态 -->
      <view class="status-section">
        <view class="status-icon" :class="getStatusIconClass(transactionDetail.transferFlag)">
          <uni-icons :type="getTransactionIcon(transactionDetail.transferFlag)" color="#ffffff" size="32"></uni-icons>
        </view>
        <view class="status-info">
          <text class="status-title">{{ transactionDetail.describes }}</text>
          <text class="status-amount" :class="getAmountClass(transactionDetail.transferFlag)">
            {{ getAmountText(transactionDetail) }} USDT
          </text>
        </view>
      </view>

      <!-- 交易信息 -->
      <view class="info-section">
        <view class="section-title">交易信息</view>
        
        <view class="info-item">
          <text class="info-label">交易时间</text>
          <text class="info-value">{{ formatDateTime(transactionDetail.txTime) }}</text>
        </view>
        
        <view class="info-item" v-if="transactionDetail.orderNo">
          <text class="info-label">订单号</text>
          <text class="info-value order-no">{{ transactionDetail.orderNo }}</text>
        </view>
        
        <view class="info-item">
          <text class="info-label">交易类型</text>
          <text class="info-value">{{ getTransactionType(transactionDetail.transferFlag) }}</text>
        </view>
        
        <view class="info-item">
          <text class="info-label">交易金额</text>
          <text class="info-value" :class="getAmountClass(transactionDetail.transferFlag)">
            {{ getAmountText(transactionDetail) }} USDT
          </text>
        </view>
        
        <view class="info-item" v-if="transactionDetail.fee">
          <text class="info-label">手续费</text>
          <text class="info-value">{{ transactionDetail.fee }} USDT</text>
        </view>
        
        <view class="info-item" v-if="transactionDetail.remark">
          <text class="info-label">备注</text>
          <text class="info-value">{{ transactionDetail.remark }}</text>
        </view>
      </view>

      <!-- 操作按钮 -->
      <view class="action-section">
        <button class="action-btn" @tap="copyOrderNo" v-if="transactionDetail.orderNo">
          复制订单号
        </button>
      </view>
    </view>

    <!-- 错误状态 -->
    <view class="error-state" v-else>
      <uni-icons type="info-filled" color="#ff4d4f" size="80"></uni-icons>
      <text class="error-text">交易详情获取失败</text>
      <text class="error-desc">数据传递异常，请返回重试</text>
    </view>
  </view>
</template>

<script>
export default {
  name: "mine-transaction-detail",
  data() {
    return {
      transactionDetail: null,
      loading: false
    }
  },
  
  methods: {
    
    // 获取交易图标
    getTransactionIcon(transferFlag) {
      return transferFlag === 1 ? 'arrowdown' : 'arrowup';
    },
    
    // 获取状态图标样式类
    getStatusIconClass(transferFlag) {
      return transferFlag === 1 ? 'icon-income' : 'icon-expense';
    },
    
    // 获取金额样式类
    getAmountClass(transferFlag) {
      return transferFlag === 1 ? 'positive' : 'negative';
    },
    
    // 获取金额文本
    getAmountText(item) {
      const prefix = item.transferFlag === 1 ? '+' : '-';
      return prefix + item.amount;
    },
    
    // 获取交易类型
    getTransactionType(transferFlag) {
      return transferFlag === 1 ? '收入' : '支出';
    },
    
    // 格式化完整日期时间
    formatDateTime(dateTimeStr) {
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
    },
    
    // 复制订单号
    copyOrderNo() {
      if (!this.transactionDetail.orderNo) return;
      
      uni.setClipboardData({
        data: this.transactionDetail.orderNo,
        success: () => {
          uni.showToast({
            title: '订单号已复制',
            icon: 'success'
          });
        }
      });
    }
  },
  
  onLoad(options) {
    try {
      if (options.data) {
        // 解码并解析传入的交易数据
        const transactionData = JSON.parse(decodeURIComponent(options.data));
        this.transactionDetail = transactionData;
      } else {
        uni.showToast({
          title: '参数错误',
          icon: 'none'
        });
        setTimeout(() => {
          uni.navigateBack();
        }, 1500);
      }
    } catch (error) {
      console.error('解析交易数据失败:', error);
      uni.showToast({
        title: '数据解析失败',
        icon: 'none'
      });
      setTimeout(() => {
        uni.navigateBack();
      }, 1500);
    }
  }
}
</script>

<style lang="scss" scoped>
.mine-transaction-detail {
  
  .loading-container {
    padding: 100rpx 0;
    text-align: center;
  }
  
  .detail-content {
    
    .status-section {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      padding: 60rpx 30rpx;
      display: flex;
      flex-direction: column;
      align-items: center;
      color: white;
      
      .status-icon {
        width: 120rpx;
        height: 120rpx;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-bottom: 30rpx;
        background: rgba(255, 255, 255, 0.2);
        
        &.icon-income {
          background: rgba(82, 196, 26, 0.3);
        }
        
        &.icon-expense {
          background: rgba(255, 77, 79, 0.3);
        }
      }
      
      .status-info {
        text-align: center;
        
        .status-title {
          display: block;
          font-size: $im-font-size;
          margin-bottom: 16rpx;
          opacity: 0.9;
        }
        
        .status-amount {
          display: block;
          font-size: 48rpx;
          font-weight: 600;
          
          &.positive {
            color: #52c41a;
          }
          
          &.negative {
            color: #ff4d4f;
          }
        }
      }
    }
    
    .info-section {
      margin: 30rpx;
      background: white;
      border-radius: 16rpx;
      overflow: hidden;
      box-shadow: 0 2rpx 12rpx rgba(0, 0, 0, 0.1);
      
      .section-title {
        padding: 30rpx;
        font-size: $im-font-size;
        font-weight: 600;
        color: $im-text-color-dark;
        border-bottom: 1rpx solid #f0f0f0;
      }
      
      .info-item {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 30rpx;
        border-bottom: 1rpx solid #f0f0f0;
        
        &:last-child {
          border-bottom: none;
        }
        
        .info-label {
          font-size: $im-font-size;
          color: $im-text-color-light;
          flex-shrink: 0;
        }
        
        .info-value {
          font-size: $im-font-size;
          color: $im-text-color-dark;
          text-align: right;
          flex: 1;
          margin-left: 20rpx;
          
          &.order-no {
            font-family: 'Courier New', monospace;
            word-break: break-all;
          }
          
          &.positive {
            color: #52c41a;
            font-weight: 600;
          }
          
          &.negative {
            color: #ff4d4f;
            font-weight: 600;
          }
        }
      }
    }
    
    .action-section {
      padding: 30rpx;
      
      .action-btn {
        width: 100%;
        height: 88rpx;
        background: $im-color-primary;
        color: white;
        border: none;
        border-radius: 12rpx;
        font-size: $im-font-size;
        font-weight: 600;
        
        &:active {
          opacity: 0.8;
        }
      }
    }
  }
  
  .error-state {
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: 120rpx 30rpx;
    
    .error-text {
      font-size: $im-font-size;
      color: $im-text-color;
      margin: 30rpx 0 10rpx 0;
    }
    
    .error-desc {
      font-size: $im-font-size-small;
      color: $im-text-color-light;
    }
  }
}
</style>