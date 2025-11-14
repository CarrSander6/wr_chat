<template>
	<view class="matched-container">
		<scroll-view scroll-y class="list-container">
			<view 
				v-for="item in matchedList" 
				:key="item.matchId" 
				class="matched-item"
				@click="startChat(item.userId)"
			>
				<image 
					:src="item.headImage || '/static/default-avatar.png'" 
					class="avatar"
				></image>
				<view class="info">
					<view class="name">{{ item.nickName }}</view>
					<view class="signature">{{ item.signature || '这个人很懒，什么都没写~' }}</view>
					<view class="time">匹配于 {{ formatTime(item.matchTime) }}</view>
				</view>
				<view class="action">
					<text class="chat-btn">💬</text>
				</view>
			</view>

			<view v-if="matchedList.length === 0" class="empty">
				<text>暂无匹配用户</text>
				<button type="primary" @click="goToMatch">去匹配</button>
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
			matchedList: [],
			loading: false
		}
	},
	onLoad() {
		this.loadMatchedUsers();
	},
	methods: {
		async loadMatchedUsers() {
			this.loading = true;
			try {
				const res = await this.$http({
					url: '/match/matched',
					method: 'GET'
				});
				this.matchedList = res || [];
			} catch (e) {
				uni.showToast({
					title: '加载失败',
					icon: 'none'
				});
			} finally {
				this.loading = false;
			}
		},
		startChat(userId) {
			uni.navigateTo({
				url: `/pages/chat/chat-box?userId=${userId}`
			});
		},
		goToMatch() {
			uni.navigateTo({
				url: '/pages/match/match'
			});
		},
		formatTime(time) {
			const date = new Date(time);
			const year = date.getFullYear();
			const month = String(date.getMonth() + 1).padStart(2, '0');
			const day = String(date.getDate()).padStart(2, '0');
			return `${year}-${month}-${day}`;
		}
	}
}
</script>

<style lang="scss" scoped>
.matched-container {
	height: 100vh;
	background: #f5f5f5;
}

.list-container {
	height: 100%;
	padding: 20rpx;
}

.matched-item {
	background: #fff;
	border-radius: 10rpx;
	padding: 20rpx;
	margin-bottom: 20rpx;
	display: flex;
	align-items: center;
	
	.avatar {
		width: 120rpx;
		height: 120rpx;
		border-radius: 50%;
		margin-right: 20rpx;
	}
	
	.info {
		flex: 1;
		
		.name {
			font-size: 32rpx;
			font-weight: bold;
			margin-bottom: 10rpx;
		}
		
		.signature {
			font-size: 26rpx;
			color: #666;
			margin-bottom: 10rpx;
		}
		
		.time {
			font-size: 24rpx;
			color: #999;
		}
	}
	
	.action {
		.chat-btn {
			font-size: 48rpx;
		}
	}
}

.empty {
	text-align: center;
	padding: 100rpx 0;
	
	text {
		display: block;
		color: #999;
		font-size: 28rpx;
		margin-bottom: 40rpx;
	}
}

.loading {
	text-align: center;
	padding: 40rpx 0;
	color: #999;
	font-size: 28rpx;
}
</style>
