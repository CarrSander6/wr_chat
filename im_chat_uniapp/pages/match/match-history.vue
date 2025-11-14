<template>
	<view class="history-container">
		<view class="tabs">
			<view 
				class="tab" 
				:class="{ active: activeTab === 1 }" 
				@click="activeTab = 1"
			>
				喜欢
			</view>
			<view 
				class="tab" 
				:class="{ active: activeTab === 2 }" 
				@click="activeTab = 2"
			>
				不喜欢
			</view>
		</view>

		<scroll-view 
			scroll-y 
			class="list-container" 
			@scrolltolower="loadMore"
		>
			<view 
				v-for="item in historyList" 
				:key="item.id" 
				class="history-item"
				@click="viewUserInfo(item.targetUserId)"
			>
				<image 
					:src="item.headImage || '/static/default-avatar.png'" 
					class="avatar"
				></image>
				<view class="info">
					<view class="name">{{ item.nickName }}</view>
					<view class="time">{{ formatTime(item.createdTime) }}</view>
				</view>
			</view>

			<view v-if="historyList.length === 0" class="empty">
				<text>暂无记录</text>
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
			activeTab: 1,
			historyList: [],
			pageNum: 1,
			pageSize: 20,
			loading: false,
			hasMore: true
		}
	},
	watch: {
		activeTab() {
			this.historyList = [];
			this.pageNum = 1;
			this.hasMore = true;
			this.loadHistory();
		}
	},
	onLoad() {
		this.loadHistory();
	},
	methods: {
		async loadHistory() {
			if (this.loading || !this.hasMore) return;
			
			this.loading = true;
			try {
				const res = await this.$http({
					url: `/match/history?actionType=${this.activeTab}&pageNum=${this.pageNum}&pageSize=${this.pageSize}`,
					method: 'GET'
				});
				
				const newData = res || [];
				this.historyList.push(...newData);
				
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
				this.loadHistory();
			}
		},
		viewUserInfo(userId) {
			uni.navigateTo({
				url: `/pages/common/user-info?userId=${userId}`
			});
		},
		formatTime(time) {
			const date = new Date(time);
			const now = new Date();
			const diff = now - date;
			
			if (diff < 60000) {
				return '刚刚';
			} else if (diff < 3600000) {
				return Math.floor(diff / 60000) + '分钟前';
			} else if (diff < 86400000) {
				return Math.floor(diff / 3600000) + '小时前';
			} else {
				return Math.floor(diff / 86400000) + '天前';
			}
		}
	}
}
</script>

<style lang="scss" scoped>
.history-container {
	height: 100vh;
	display: flex;
	flex-direction: column;
	background: #f5f5f5;
}

.tabs {
	display: flex;
	background: #fff;
	border-bottom: 1px solid #eee;
	
	.tab {
		flex: 1;
		text-align: center;
		padding: 30rpx;
		font-size: 32rpx;
		color: #666;
		position: relative;
		
		&.active {
			color: #667eea;
			font-weight: bold;
			
			&::after {
				content: '';
				position: absolute;
				bottom: 0;
				left: 50%;
				transform: translateX(-50%);
				width: 60rpx;
				height: 4rpx;
				background: #667eea;
			}
		}
	}
}

.list-container {
	flex: 1;
	padding: 20rpx;
}

.history-item {
	background: #fff;
	border-radius: 10rpx;
	padding: 20rpx;
	margin-bottom: 20rpx;
	display: flex;
	align-items: center;
	
	.avatar {
		width: 100rpx;
		height: 100rpx;
		border-radius: 50%;
		margin-right: 20rpx;
	}
	
	.info {
		flex: 1;
		
		.name {
			font-size: 32rpx;
			margin-bottom: 10rpx;
		}
		
		.time {
			font-size: 24rpx;
			color: #999;
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
