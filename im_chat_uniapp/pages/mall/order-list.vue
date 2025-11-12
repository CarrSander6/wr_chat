<template>
	<view class="order-list-container">
		<scroll-view scroll-y class="list-container" @scrolltolower="loadMore">
			<view 
				v-for="order in orderList" 
				:key="order.id" 
				class="order-item"
				@click="goToDetail(order.id)"
			>
				<view class="order-header">
					<text class="order-no">订单号: {{ order.orderNo }}</text>
					<text class="order-status" :class="'status-' + order.status">
						{{ getStatusText(order.status) }}
					</text>
				</view>
				<view class="order-content">
					<view class="product-name">{{ order.productName }}</view>
					<view class="product-meta">
						<text>数量: {{ order.quantity }}</text>
						<text class="amount">¥{{ order.totalAmount }}</text>
					</view>
				</view>
				<view class="order-footer">
					<text class="time">{{ formatTime(order.createdTime) }}</text>
					<view class="actions">
						<button 
							v-if="order.status === 0" 
							class="action-btn" 
							size="mini"
							@click.stop="payOrder(order.id)"
						>
							去支付
						</button>
						<button 
							v-if="order.status === 0" 
							class="action-btn cancel"
							size="mini"
							@click.stop="cancelOrder(order.id)"
						>
							取消
						</button>
					</view>
				</view>
			</view>

			<view v-if="orderList.length === 0" class="empty">
				<text>暂无订单</text>
			</view>

			<view v-if="loading" class="loading">
				<text>加载中...</text>
			</view>
		</scroll-view>
	</view>
</template>

<script>
export default {
	data() {
		return {
			orderList: [],
			pageNum: 1,
			pageSize: 20,
			loading: false,
			hasMore: true
		}
	},
	onLoad() {
		this.loadOrderList();
	},
	methods: {
		async loadOrderList() {
			if (this.loading || !this.hasMore) return;
			
			this.loading = true;
			try {
				const res = await this.$http.get('/mall/order/list', {
					params: {
						pageNum: this.pageNum,
						pageSize: this.pageSize
					}
				});
				
				const newData = res.data || [];
				this.orderList.push(...newData);
				
				if (newData.length < this.pageSize) {
					this.hasMore = false;
				}
			} catch (e) {
				uni.showToast({
					title: '加载失败',
					icon: 'none'
				});
			} finally {
				this.loading = false;
			}
		},
		loadMore() {
			if (this.hasMore && !this.loading) {
				this.pageNum++;
				this.loadOrderList();
			}
		},
		goToDetail(orderId) {
			uni.navigateTo({
				url: `/pages/mall/order-detail?id=${orderId}`
			});
		},
		async payOrder(orderId) {
			uni.showModal({
				title: '确认支付',
				content: '确认支付该订单？',
				success: async (res) => {
					if (res.confirm) {
						try {
							await this.$http.post(`/mall/order/pay/${orderId}`);
							uni.showToast({
								title: '支付成功',
								icon: 'success'
							});
							this.refreshList();
						} catch (e) {
							uni.showToast({
								title: e.message || '支付失败',
								icon: 'none'
							});
						}
					}
				}
			});
		},
		async cancelOrder(orderId) {
			uni.showModal({
				title: '确认取消',
				content: '确认取消该订单？',
				success: async (res) => {
					if (res.confirm) {
						try {
							await this.$http.post(`/mall/order/cancel/${orderId}`);
							uni.showToast({
								title: '取消成功',
								icon: 'success'
							});
							this.refreshList();
						} catch (e) {
							uni.showToast({
								title: e.message || '取消失败',
								icon: 'none'
							});
						}
					}
				}
			});
		},
		refreshList() {
			this.orderList = [];
			this.pageNum = 1;
			this.hasMore = true;
			this.loadOrderList();
		},
		getStatusText(status) {
			const statusMap = {
				0: '待支付',
				1: '已支付',
				2: '已取消',
				3: '已完成'
			};
			return statusMap[status] || '未知';
		},
		formatTime(time) {
			const date = new Date(time);
			const year = date.getFullYear();
			const month = String(date.getMonth() + 1).padStart(2, '0');
			const day = String(date.getDate()).padStart(2, '0');
			const hours = String(date.getHours()).padStart(2, '0');
			const minutes = String(date.getMinutes()).padStart(2, '0');
			return `${year}-${month}-${day} ${hours}:${minutes}`;
		}
	}
}
</script>

<style lang="scss" scoped>
.order-list-container {
	height: 100vh;
	background: #f5f5f5;
}

.list-container {
	height: 100%;
	padding: 20rpx;
}

.order-item {
	background: #fff;
	border-radius: 10rpx;
	padding: 30rpx;
	margin-bottom: 20rpx;
	
	.order-header {
		display: flex;
		justify-content: space-between;
		align-items: center;
		margin-bottom: 20rpx;
		padding-bottom: 20rpx;
		border-bottom: 1px solid #f0f0f0;
		
		.order-no {
			font-size: 26rpx;
			color: #666;
		}
		
		.order-status {
			font-size: 26rpx;
			
			&.status-0 {
				color: #ff9800;
			}
			
			&.status-1 {
				color: #4cd964;
			}
			
			&.status-2 {
				color: #999;
			}
			
			&.status-3 {
				color: #666;
			}
		}
	}
	
	.order-content {
		margin-bottom: 20rpx;
		
		.product-name {
			font-size: 32rpx;
			font-weight: bold;
			margin-bottom: 15rpx;
		}
		
		.product-meta {
			display: flex;
			justify-content: space-between;
			font-size: 26rpx;
			color: #666;
			
			.amount {
				font-size: 32rpx;
				color: #ff6b6b;
				font-weight: bold;
			}
		}
	}
	
	.order-footer {
		display: flex;
		justify-content: space-between;
		align-items: center;
		
		.time {
			font-size: 24rpx;
			color: #999;
		}
		
		.actions {
			display: flex;
			gap: 15rpx;
			
			.action-btn {
				padding: 10rpx 30rpx;
				font-size: 24rpx;
				
				&.cancel {
					background: #f0f0f0;
					color: #666;
				}
			}
		}
	}
}

.empty,
.loading {
	text-align: center;
	padding: 100rpx 0;
	color: #999;
	font-size: 28rpx;
}
</style>
