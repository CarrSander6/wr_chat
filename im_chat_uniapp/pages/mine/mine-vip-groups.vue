<template>
	<view class="page mine-vip-groups">
		<nav-bar title="我的群组" back></nav-bar>
		
		<!-- 群组统计 -->
		<uni-card :is-shadow="false" is-full :border="false">
			<view class="group-stats">
				<view class="stats-item">
					<text class="stats-number">{{ myGroups.length }}</text>
					<text class="stats-label">已创建</text>
				</view>
				<view class="stats-divider"></view>
				<view class="stats-item">
					<text class="stats-number">{{ 3 - myGroups.length }}</text>
					<text class="stats-label">可创建</text>
				</view>
				<view class="stats-divider"></view>
				<view class="stats-item">
					<text class="stats-number">{{ totalMembers }}</text>
					<text class="stats-label">总成员</text>
				</view>
			</view>
		</uni-card>
		
		<!-- 创建群组按钮 -->
		<view class="create-group-wrapper" v-if="myGroups.length < 3">
			<button class="create-btn" @tap="showCreateDialog">
				<uni-icons type="plus" color="white" size="18"></uni-icons>
				<text>创建新群组</text>
			</button>
		</view>
		
		<!-- 群组列表 -->
		<uni-card :is-shadow="false" is-full :border="false" v-if="myGroups.length > 0">
			<view class="group-list">
				<view class="list-title">我的群组</view>
				
				<view 
					v-for="(group, index) in myGroups" 
					:key="group.id"
					class="group-item"
					@tap="enterGroup(group)"
				>
					<view class="group-avatar">
						<image :src="group.avatar || '/static/images/default-group.png'" class="avatar-img"></image>
						<view class="group-status" :class="group.status"></view>
					</view>
					
					<view class="group-info">
						<view class="group-name">{{ group.name }}</view>
						<view class="group-desc">{{ group.memberCount }}人 · {{ formatTime(group.createTime) }}</view>
					</view>
					
					<view class="group-actions">
						<button class="action-btn manage" @tap.stop="manageGroup(group)">
							<uni-icons type="gear" size="16"></uni-icons>
						</button>
						<button class="action-btn delete" @tap.stop="deleteGroup(group)">
							<uni-icons type="trash" size="16"></uni-icons>
						</button>
					</view>
				</view>
			</view>
		</uni-card>
		
		<!-- 空状态 -->
		<view class="empty-state" v-if="myGroups.length === 0">
			<uni-icons type="chatboxes" color="#d9d9d9" size="80"></uni-icons>
			<text class="empty-text">还没有创建群组</text>
			<text class="empty-desc">VIP用户可创建最多3个专属群组</text>
		</view>
		
		<!-- 群组规则说明 -->
		<uni-card :is-shadow="false" is-full :border="false">
			<view class="group-rules">
				<view class="rules-title">
					<uni-icons type="info-filled" color="#ff4d4f" size="18"></uni-icons>
					<text>群组管理规则</text>
				</view>
				<view class="rules-content">
					<text>• VIP用户最多可创建3个群组</text>
					<text>• 严格禁止群内成员互加好友</text>
					<text>• 违规行为将立即解散群组</text>
					<text>• 群主有权踢出违规成员</text>
					<text>• 请遵守平台使用规范</text>
				</view>
			</view>
		</uni-card>
		
		<!-- 创建群组弹窗 -->
		<uni-popup ref="createPopup" type="dialog">
			<uni-popup-dialog 
				title="创建群组" 
				placeholder="请输入群组名称"
				v-model="newGroupName"
				@confirm="createGroup"
				@close="closeCreateDialog"
			>
			</uni-popup-dialog>
		</uni-popup>
	</view>
</template>

<script>
export default {
	name: "mine-vip-groups",
	data() {
		return {
			myGroups: [],
			newGroupName: '',
			loading: false
		}
	},
	computed: {
		// 总成员数
		totalMembers() {
			return this.myGroups.reduce((total, group) => total + group.memberCount, 0);
		}
	},
	methods: {
		// 加载我的群组
		loadMyGroups() {
			this.loading = true;
			this.$http({
				url: '/group/my-groups',
				method: 'GET'
			}).then((res) => {
				this.myGroups = res.groups || [];
			}).catch((err) => {
				console.error('加载群组失败:', err);
				uni.showToast({
					title: '加载失败',
					icon: 'none'
				});
			}).finally(() => {
				this.loading = false;
			});
		},
		
		// 显示创建对话框
		showCreateDialog() {
			if (this.myGroups.length >= 3) {
				uni.showToast({
					title: '最多只能创建3个群组',
					icon: 'none'
				});
				return;
			}
			this.newGroupName = '';
			this.$refs.createPopup.open();
		},
		
		// 关闭创建对话框
		closeCreateDialog() {
			this.newGroupName = '';
		},
		
		// 创建群组
		createGroup() {
			if (!this.newGroupName.trim()) {
				uni.showToast({
					title: '请输入群组名称',
					icon: 'none'
				});
				return;
			}
			
			if (this.newGroupName.length > 20) {
				uni.showToast({
					title: '群组名称不能超过20个字符',
					icon: 'none'
				});
				return;
			}
			
			this.$http({
				url: '/group/create',
				method: 'POST',
				data: {
					name: this.newGroupName.trim()
				}
			}).then((res) => {
				uni.showToast({
					title: '群组创建成功',
					icon: 'success'
				});
				
				// 刷新群组列表
				this.loadMyGroups();
				
				// 关闭弹窗
				this.$refs.createPopup.close();
				
			}).catch((err) => {
				console.error('创建群组失败:', err);
				uni.showToast({
					title: err.message || '创建失败',
					icon: 'none'
				});
			});
		},
		
		// 进入群组
		enterGroup(group) {
			uni.navigateTo({
				url: `/pages/chat/chat?groupId=${group.id}&groupName=${group.name}`
			});
		},
		
		// 管理群组
		manageGroup(group) {
			uni.navigateTo({
				url: `/pages/group/group-manage?groupId=${group.id}`
			});
		},
		
		// 删除群组
		deleteGroup(group) {
			uni.showModal({
				title: '确认删除',
				content: `确定要解散群组"${group.name}"吗？此操作不可撤销！`,
				confirmColor: '#ff4d4f',
				success: (res) => {
					if (res.confirm) {
						this.doDeleteGroup(group);
					}
				}
			});
		},
		
		// 执行删除群组
		doDeleteGroup(group) {
			this.$http({
				url: `/group/${group.id}`,
				method: 'DELETE'
			}).then((res) => {
				uni.showToast({
					title: '群组已解散',
					icon: 'success'
				});
				
				// 刷新群组列表
				this.loadMyGroups();
				
			}).catch((err) => {
				console.error('删除群组失败:', err);
				uni.showToast({
					title: err.message || '删除失败',
					icon: 'none'
				});
			});
		},
		
		// 格式化时间
		formatTime(timestamp) {
			const date = new Date(timestamp);
			const now = new Date();
			const diff = now - date;
			
			if (diff < 24 * 60 * 60 * 1000) {
				// 24小时内显示时间
				return date.toLocaleTimeString('zh-CN', { hour: '2-digit', minute: '2-digit' });
			} else if (diff < 7 * 24 * 60 * 60 * 1000) {
				// 7天内显示星期
				const days = ['日', '一', '二', '三', '四', '五', '六'];
				return '星期' + days[date.getDay()];
			} else {
				// 超过7天显示日期
				return date.toLocaleDateString('zh-CN', { month: '2-digit', day: '2-digit' });
			}
		}
	},
	onLoad() {
		this.loadMyGroups();
	},
	onShow() {
		// 页面显示时刷新数据
		this.loadMyGroups();
	}
}
</script>

<style lang="scss" scoped>
.mine-vip-groups {
	.group-stats {
		display: flex;
		padding: 30rpx;
		
		.stats-item {
			flex: 1;
			display: flex;
			flex-direction: column;
			align-items: center;
			
			.stats-number {
				font-size: 48rpx;
				font-weight: 600;
				color: $im-color-primary;
				margin-bottom: 8rpx;
			}
			
			.stats-label {
				font-size: $im-font-size-small;
				color: $im-text-color-light;
			}
		}
		
		.stats-divider {
			width: 1rpx;
			height: 60rpx;
			background-color: #f0f0f0;
		}
	}
	
	.create-group-wrapper {
		padding: 20rpx 30rpx;
		
		.create-btn {
			width: 100%;
			display: flex;
			align-items: center;
			justify-content: center;
			gap: 10rpx;
			padding: 32rpx;
			background-color: $im-color-primary;
			color: white;
			border: none;
			border-radius: 12rpx;
			font-size: $im-font-size;
			font-weight: 600;
		}
	}
	
	.group-list {
		padding: 30rpx;
		
		.list-title {
			font-size: $im-font-size;
			font-weight: 600;
			color: $im-text-color-dark;
			margin-bottom: 30rpx;
		}
		
		.group-item {
			display: flex;
			align-items: center;
			padding: 30rpx 0;
			border-bottom: 1rpx solid #f0f0f0;
			
			&:last-child {
				border-bottom: none;
			}
			
			.group-avatar {
				position: relative;
				margin-right: 24rpx;
				
				.avatar-img {
					width: 100rpx;
					height: 100rpx;
					border-radius: 12rpx;
				}
				
				.group-status {
					position: absolute;
					bottom: -4rpx;
					right: -4rpx;
					width: 24rpx;
					height: 24rpx;
					border-radius: 50%;
					border: 2rpx solid white;
					
					&.active {
						background-color: #52c41a;
					}
					
					&.inactive {
						background-color: #d9d9d9;
					}
				}
			}
			
			.group-info {
				flex: 1;
				margin-right: 20rpx;
				
				.group-name {
					font-size: $im-font-size;
					font-weight: 600;
					color: $im-text-color-dark;
					margin-bottom: 8rpx;
					overflow: hidden;
					text-overflow: ellipsis;
					white-space: nowrap;
				}
				
				.group-desc {
					font-size: $im-font-size-small;
					color: $im-text-color-light;
				}
			}
			
			.group-actions {
				display: flex;
				gap: 16rpx;
				
				.action-btn {
					width: 60rpx;
					height: 60rpx;
					border-radius: 8rpx;
					border: none;
					display: flex;
					align-items: center;
					justify-content: center;
					
					&.manage {
						background-color: #f0f9ff;
						color: #1890ff;
					}
					
					&.delete {
						background-color: #fff2f0;
						color: #ff4d4f;
					}
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
	
	.group-rules {
		padding: 30rpx;
		
		.rules-title {
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
		
		.rules-content {
			text {
				display: block;
				font-size: $im-font-size-small;
				color: $im-text-color;
				line-height: 1.6;
				margin-bottom: 8rpx;
			}
		}
	}
}
</style>