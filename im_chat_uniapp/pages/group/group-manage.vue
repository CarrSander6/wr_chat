<template>
	<view class="page group-manage">
		<nav-bar title="群组管理" back></nav-bar>
		
		<!-- 群组信息 -->
		<uni-card :is-shadow="false" is-full :border="false">
			<view class="group-info">
				<view class="group-avatar">
					<image :src="groupInfo.avatar || '/static/images/default-group.png'" mode="aspectFill"></image>
				</view>
				<view class="group-details">
					<text class="group-name">{{ groupInfo.name }}</text>
					<text class="group-desc">{{ groupInfo.description || '暂无群组描述' }}</text>
					<view class="group-meta">
						<text class="meta-item">创建时间：{{ formatTime(groupInfo.createTime) }}</text>
						<text class="meta-item">群组ID：{{ groupInfo.id }}</text>
					</view>
				</view>
			</view>
		</uni-card>
		
		<!-- 群组状态 -->
		<uni-card :is-shadow="false" is-full :border="false">
			<view class="group-status">
				<view class="status-item">
					<text class="status-label">群组状态</text>
					<view class="status-value" :class="groupInfo.status">
						{{ getStatusText(groupInfo.status) }}
					</view>
				</view>
				<view class="status-item">
					<text class="status-label">成员数量</text>
					<text class="status-value">{{ groupInfo.memberCount || 0 }}人</text>
				</view>
				<view class="status-item">
					<text class="status-label">违规次数</text>
					<text class="status-value" :class="{ 'danger': violationCount >= 2 }">{{ violationCount }}次</text>
				</view>
			</view>
		</uni-card>
		
		<!-- 群组操作 -->
		<uni-card :is-shadow="false" is-full :border="false">
			<view class="group-actions">
				<view class="action-item" @tap="editGroup">
					<view class="action-icon">
						<uni-icons type="compose" color="#1890ff" size="20"></uni-icons>
					</view>
					<text class="action-text">编辑群组</text>
					<uni-icons type="right" color="#c0c4cc" size="16"></uni-icons>
				</view>
				
				<view class="action-item" @tap="manageMembers">
					<view class="action-icon">
						<uni-icons type="person-filled" color="#52c41a" size="20"></uni-icons>
					</view>
					<text class="action-text">成员管理</text>
					<view class="member-count">{{ groupInfo.memberCount }}人</view>
					<uni-icons type="right" color="#c0c4cc" size="16"></uni-icons>
				</view>
				
				<view class="action-item" @tap="viewViolationRecords">
					<view class="action-icon">
						<uni-icons type="warning" :color="violationCount > 0 ? '#ff4d4f' : '#fa8c16'" size="20"></uni-icons>
					</view>
					<text class="action-text">违规记录</text>
					<view class="violation-badge" v-if="violationCount > 0" :class="{ 'danger': violationCount >= 2 }">
						{{ violationCount }}
					</view>
					<uni-icons type="right" color="#c0c4cc" size="16"></uni-icons>
				</view>
				
				<view class="action-item" @tap="groupSettings">
					<view class="action-icon">
						<uni-icons type="gear" color="#fa8c16" size="20"></uni-icons>
					</view>
					<text class="action-text">群组设置</text>
					<uni-icons type="right" color="#c0c4cc" size="16"></uni-icons>
				</view>
			</view>
		</uni-card>
		
		<!-- 群规提醒 -->
		<uni-card :is-shadow="false" is-full :border="false">
			<view class="group-rules">
				<view class="rules-title">
					<uni-icons type="info" color="#1890ff" size="18"></uni-icons>
					<text>群组规则</text>
				</view>
				<view class="rules-content">
					<text class="rule-item important">• 严格禁止群内成员互加好友</text>
					<text class="rule-item">• 违规行为将被系统自动检测并记录</text>
					<text class="rule-item">• 累计3次违规将自动解散群组</text>
					<text class="rule-item">• 请所有成员严格遵守群组规则</text>
				</view>
			</view>
		</uni-card>
		
		<!-- 危险操作 -->
		<uni-card :is-shadow="false" is-full :border="false" v-if="isOwner">
			<view class="danger-actions">
				<view class="action-item danger" @tap="dissolveGroup">
					<view class="action-icon">
						<uni-icons type="trash" color="#ff4d4f" size="20"></uni-icons>
					</view>
					<text class="action-text">解散群组</text>
					<uni-icons type="right" color="#c0c4cc" size="16"></uni-icons>
				</view>
			</view>
		</uni-card>
		
		<popup-modal ref="modal"></popup-modal>
	</view>
</template>

<script>
export default {
	name: "group-manage",
	data() {
		return {
			groupId: '',
			groupInfo: {},
			violationCount: 0,
			loading: false
		}
	},
	methods: {
		// 加载群组信息
		loadGroupInfo() {
			if (this.loading) return;
			
			this.loading = true;
			this.$http({
				url: `/group/info/${this.groupId}`,
				method: 'GET'
			}).then((res) => {
				this.groupInfo = res.data || {};
				this.violationCount = res.data.violationCount || 0;
			}).catch((err) => {
				console.error('加载群组信息失败:', err);
				uni.showToast({
					title: '加载失败',
					icon: 'none'
				});
			}).finally(() => {
				this.loading = false;
			});
		},
		
		// 编辑群组
		editGroup() {
			uni.navigateTo({
				url: `/pages/group/group-edit?groupId=${this.groupId}`
			});
		},
		
		// 成员管理
		manageMembers() {
			uni.navigateTo({
				url: `/pages/group/group-members?groupId=${this.groupId}`
			});
		},
		
		// 查看违规记录
		viewViolationRecords() {
			uni.navigateTo({
				url: `/pages/group/group-violation-records?groupId=${this.groupId}`
			});
		},
		
		// 群组设置
		groupSettings() {
			uni.navigateTo({
				url: `/pages/group/group-settings?groupId=${this.groupId}`
			});
		},
		
		// 解散群组
		dissolveGroup() {
			this.$refs.modal.open({
				title: '解散群组',
				content: '解散后群组将被永久删除，所有成员将被移除，此操作不可恢复！',
				confirmText: '确认解散',
				confirmColor: '#ff4d4f',
				success: () => {
					this.confirmDissolveGroup();
				}
			});
		},
		
		// 确认解散群组
		confirmDissolveGroup() {
			this.$http({
				url: `/group/${this.groupId}/dissolve`,
				method: 'DELETE'
			}).then(() => {
				uni.showToast({
					title: '群组已解散',
					icon: 'success'
				});
				
				// 返回群组列表
				setTimeout(() => {
					uni.navigateBack({
						delta: 2
					});
				}, 1500);
			}).catch((err) => {
				console.error('解散群组失败:', err);
				uni.showToast({
					title: '解散失败',
					icon: 'none'
				});
			});
		},
		
		// 获取状态文本
		getStatusText(status) {
			const statusMap = {
				active: '正常',
				warning: '警告',
				suspended: '已暂停',
				dissolved: '已解散'
			};
			return statusMap[status] || '未知';
		},
		
		// 格式化时间
		formatTime(timestamp) {
			if (!timestamp) return '';
			
			const date = new Date(timestamp);
			return date.toLocaleDateString('zh-CN', {
				year: 'numeric',
				month: '2-digit',
				day: '2-digit'
			});
		}
	},
	computed: {
		// 是否为群主
		isOwner() {
			return this.userStore.userInfo.id === this.groupInfo.ownerId;
		}
	},
	onLoad(options) {
		this.groupId = options.groupId;
		this.loadGroupInfo();
	},
	onShow() {
		// 页面显示时刷新数据
		if (this.groupId) {
			this.loadGroupInfo();
		}
	}
}
</script>

<style lang="scss" scoped>
.group-manage {
	.group-info {
		display: flex;
		padding: 30rpx;
		
		.group-avatar {
			width: 120rpx;
			height: 120rpx;
			border-radius: 12rpx;
			overflow: hidden;
			margin-right: 30rpx;
			
			image {
				width: 100%;
				height: 100%;
			}
		}
		
		.group-details {
			flex: 1;
			display: flex;
			flex-direction: column;
			justify-content: center;
			
			.group-name {
				font-size: $im-font-size-large;
				font-weight: 600;
				color: $im-text-color-dark;
				margin-bottom: 8rpx;
			}
			
			.group-desc {
				font-size: $im-font-size-small;
				color: $im-text-color-light;
				margin-bottom: 15rpx;
				line-height: 1.4;
			}
			
			.group-meta {
				.meta-item {
					display: block;
					font-size: $im-font-size-small;
					color: $im-text-color-lighter;
					margin-bottom: 4rpx;
				}
			}
		}
	}
	
	.group-status {
		display: flex;
		padding: 30rpx;
		
		.status-item {
			flex: 1;
			display: flex;
			flex-direction: column;
			align-items: center;
			
			.status-label {
				font-size: $im-font-size-small;
				color: $im-text-color-light;
				margin-bottom: 8rpx;
			}
			
			.status-value {
				font-size: $im-font-size;
				font-weight: 600;
				color: $im-text-color-dark;
				
				&.active {
					color: #52c41a;
				}
				
				&.warning {
					color: #fa8c16;
				}
				
				&.suspended, &.danger {
					color: #ff4d4f;
				}
				
				&.dissolved {
					color: #8c8c8c;
				}
			}
		}
	}
	
	.group-actions, .danger-actions {
		padding: 0 30rpx;
		
		.action-item {
			display: flex;
			align-items: center;
			padding: 30rpx 0;
			border-bottom: 1rpx solid #f0f0f0;
			
			&:last-child {
				border-bottom: none;
			}
			
			&:active {
				background: #f8f8f8;
			}
			
			.action-icon {
				margin-right: 20rpx;
			}
			
			.action-text {
				flex: 1;
				font-size: $im-font-size;
				color: $im-text-color-dark;
				
				.danger & {
					color: #ff4d4f;
				}
			}
			
			.member-count {
				font-size: $im-font-size-small;
				color: $im-text-color-light;
				margin-right: 10rpx;
			}
			
			.violation-badge {
				min-width: 36rpx;
				height: 36rpx;
				line-height: 36rpx;
				text-align: center;
				font-size: $im-font-size-small;
				color: #ffffff;
				background: #fa8c16;
				border-radius: 18rpx;
				margin-right: 10rpx;
				
				&.danger {
					background: #ff4d4f;
				}
			}
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
			.rule-item {
				display: block;
				font-size: $im-font-size-small;
				color: $im-text-color;
				line-height: 1.6;
				margin-bottom: 8rpx;
				
				&.important {
					color: #ff4d4f;
					font-weight: 600;
				}
			}
		}
	}
}
</style>