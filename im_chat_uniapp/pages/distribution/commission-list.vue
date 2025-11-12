<template>
	<view class="commission-list-container">
		<scroll-view scroll-y class="list-container" @scrolltolower="loadMore">
			<view 
				v-for="item in commissionList" 
				:key="item.id" 
				class="commission-item"
			>
				<view class="item-header">
					<view class="type-badge" :class="'type-' + item.commissionType">
						{{ item.commissionType === 1 ? '直推' : '间推' }}
					</view>
					<view class="amount">+¥{{ item.commissionAmount }}</view>
				</view>
				<view class="item-info">
					<text class="info-text">订单金额: ¥{{ item.orderAmount }}</text>
					<text class="info-text">佣金比例: {{ (item.commissionRate * 100).toFixed(2) }}%</text>
				</view>
				<view class="item-footer">
					<text class="time">{{ formatTime(item.createdTime) }}</text>
					<text class="status" :class="'status-' + item.status">
						{{ getStatusText(item.status) }}
					</text>
				</view>
			</view>

			<view v-if="commissionList.length === 0" class="empty">
				<text>暂无佣金记录</text>
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
			commissionList: [],
			pageNum: 1,
			pageSize: 20,
			loading: false,
			hasMore: true
		}
	},
	onLoad() {
		this.loadCommissionList();
	},
	methods: {
		async loadCommissionList() {
			if (this.loading || !this.hasMore) return;
			
			this.loading = true;
			try {
				const res = await this.$http.get('/distribution/commission/list', {
					params: {
						pageNum: this.pageNum,
						pageSize: this.pageSize
					}
				});
				
				const newData = res.data || [];
				this.commissionList.push(...newData);
				
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
				this.loadCommissionList();
			}
		},
		getStatusText(status) {
			const statusMap = {
				0: '待结算',
				1: '已结算',
				2: '已取消'
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
.commission-list-container {
	height: 100vh;
	background: #f5f5f5;
}

.list-container {
	height: 100%;
	padding: 20rpx;
}

.commission-item {
	background: #fff;
	border-radius: 10rpx;
	padding: 30rpx;
	margin-bottom: 20rpx;
	
	.item-header {
		display: flex;
		justify-content: space-between;
		align-items: center;
		margin-bottom: 20rpx;
		
		.type-badge {
			padding: 8rpx 20rpx;
			border-radius: 20rpx;
			font-size: 24rpx;
			color: #fff;
			
			&.type-1 {
				background: #667eea;
			}
			
			&.type-2 {
				background: #764ba2;
			}
		}
		
		.amount {
			font-size: 36rpx;
			font-weight: bold;
			color: #4cd964;
		}
	}
	
	.item-info {
		display: flex;
		flex-direction: column;
		gap: 10rpx;
		margin-bottom: 20rpx;
		
		.info-text {
			font-size: 26rpx;
			color: #666;
		}
	}
	
	.item-footer {
		display: flex;
		justify-content: space-between;
		align-items: center;
		
		.time {
			font-size: 24rpx;
			color: #999;
		}
		
		.status {
			font-size: 24rpx;
			
			&.status-0 {
				color: #ff9800;
			}
			
			&.status-1 {
				color: #4cd964;
			}
			
			&.status-2 {
				color: #999;
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
