<template>
	<view class="page group-violation-records">
		<nav-bar title="违规记录" back></nav-bar>
		
		<!-- 统计信息 -->
		<uni-card :is-shadow="false" is-full :border="false">
			<view class="violation-stats">
				<view class="stats-item">
					<text class="stats-number">{{ violationRecords.length }}</text>
					<text class="stats-label">违规次数</text>
				</view>
				<view class="stats-divider"></view>
				<view class="stats-item">
					<text class="stats-number" :class="{ 'danger': remainingCount <= 1 }">{{ remainingCount }}</text>
					<text class="stats-label">剩余机会</text>
				</view>
				<view class="stats-divider"></view>
				<view class="stats-item">
					<text class="stats-number">{{ uniqueViolators.length }}</text>
					<text class="stats-label">涉及成员</text>
				</view>
			</view>
		</uni-card>
		
		<!-- 警告提示 -->
		<uni-card :is-shadow="false" is-full :border="false" v-if="remainingCount <= 1">
			<view class="warning-notice">
				<view class="notice-icon">
					<uni-icons type="warning-filled" color="#ff4d4f" size="20"></uni-icons>
				</view>
				<view class="notice-content">
					<text class="notice-title">违规警告</text>
					<text class="notice-desc">群组违规次数已达{{ violationRecords.length }}次，再次违规将自动解散群组！</text>
				</view>
			</view>
		</uni-card>
		
		<!-- 违规记录列表 -->
		<view class="violation-list" v-if="violationRecords.length > 0">
			<view class="list-title">违规记录</view>
			
			<view 
				v-for="(record, index) in violationRecords" 
				:key="record.id"
				class="violation-item"
			>
				<view class="violation-icon">
					<uni-icons type="person-filled" color="#ff4d4f" size="20"></uni-icons>
				</view>
				
				<view class="violation-info">
					<view class="violation-title">成员互加好友</view>
					<view class="violation-desc">
						<text class="violator-names">{{ record.violatorName }} 和 {{ record.targetName }}</text>
						<text class="violation-time">{{ formatTime(record.createTime) }}</text>
					</view>
					<view class="violation-detail" v-if="record.detail">
						<text>{{ record.detail }}</text>
					</view>
				</view>
				
				<view class="violation-status">
					<view class="status-badge" :class="record.status">
						{{ getStatusText(record.status) }}
					</view>
					<view class="violation-actions" v-if="canManage && record.status === 'pending'">
						<button class="action-btn ignore" @tap="handleViolation(record, 'ignore')">
							忽略
						</button>
						<button class="action-btn confirm" @tap="handleViolation(record, 'confirm')">
							确认
						</button>
					</view>
				</view>
			</view>
		</view>
		
		<!-- 空状态 -->
		<view class="empty-state" v-if="violationRecords.length === 0">
			<uni-icons type="checkmarkempty" color="#52c41a" size="80"></uni-icons>
			<text class="empty-text">暂无违规记录</text>
			<text class="empty-desc">群组运行良好，请继续保持</text>
		</view>
		
		<!-- 规则说明 -->
		<uni-card :is-shadow="false" is-full :border="false">
			<view class="rules-section">
				<view class="rules-title">
					<uni-icons type="info" color="#1890ff" size="18"></uni-icons>
					<text>违规处理规则</text>
				</view>
				<view class="rules-content">
					<text class="rule-item">• 系统自动检测群内成员互加好友行为</text>
					<text class="rule-item">• 每次违规都会被记录并通知群主</text>
					<text class="rule-item">• 累计3次违规将自动解散群组</text>
					<text class="rule-item">• 群主可以选择忽略误报的违规记录</text>
				</view>
			</view>
		</uni-card>
		
		<popup-modal ref="modal"></popup-modal>
	</view>
</template>

<script>
export default {
	name: "group-violation-records",
	data() {
		return {
			groupId: '',
			violationRecords: [],
			groupInfo: {},
			loading: false
		}
	},
	methods: {
		// 加载违规记录
		loadViolationRecords() {
			if (this.loading) return;
			
			this.loading = true;
			this.$http({
				url: `/group/violation-records/${this.groupId}`,
				method: 'GET'
			}).then((res) => {
				this.violationRecords = res.records || [];
				this.groupInfo = res.groupInfo || {};
			}).catch((err) => {
				console.error('加载违规记录失败:', err);
				uni.showToast({
					title: '加载失败',
					icon: 'none'
				});
			}).finally(() => {
				this.loading = false;
			});
		},
		
		// 处理违规记录
		handleViolation(record, action) {
			const actionText = action === 'ignore' ? '忽略' : '确认';
			const content = `确定${actionText}这条违规记录吗？`;
			
			this.$refs.modal.open({
				title: `${actionText}违规记录`,
				content: content,
				success: () => {
					this.confirmHandleViolation(record.id, action);
				}
			});
		},
		
		// 确认处理违规记录
		confirmHandleViolation(recordId, action) {
			this.$http({
				url: `/group/violation-records/${recordId}/handle`,
				method: 'PUT',
				data: {
					action: action
				}
			}).then(() => {
				uni.showToast({
					title: action === 'ignore' ? '已忽略' : '已确认',
					icon: 'success'
				});
				this.loadViolationRecords();
			}).catch((err) => {
				console.error('处理违规记录失败:', err);
				uni.showToast({
					title: '处理失败',
					icon: 'none'
				});
			});
		},
		
		// 获取状态文本
		getStatusText(status) {
			const statusMap = {
				pending: '待处理',
				confirmed: '已确认',
				ignored: '已忽略',
				auto: '自动处理'
			};
			return statusMap[status] || '未知';
		},
		
		// 格式化时间
		formatTime(timestamp) {
			if (!timestamp) return '';
			
			const date = new Date(timestamp);
			const now = new Date();
			const diff = now - date;
			
			if (diff < 24 * 60 * 60 * 1000) {
				// 24小时内显示时间
				return date.toLocaleTimeString('zh-CN', {
					hour: '2-digit',
					minute: '2-digit'
				});
			} else if (diff < 7 * 24 * 60 * 60 * 1000) {
				// 7天内显示日期和时间
				return date.toLocaleDateString('zh-CN', {
					month: '2-digit',
					day: '2-digit',
					hour: '2-digit',
					minute: '2-digit'
				});
			} else {
				// 超过7天显示完整日期
				return date.toLocaleDateString('zh-CN', {
					year: 'numeric',
					month: '2-digit',
					day: '2-digit'
				});
			}
		}
	},
	computed: {
		// 剩余违规机会
		remainingCount() {
			const maxViolations = 3;
			const confirmedViolations = this.violationRecords.filter(r => r.status === 'confirmed' || r.status === 'auto').length;
			return Math.max(0, maxViolations - confirmedViolations);
		},
		
		// 涉及的违规成员（去重）
		uniqueViolators() {
			const violators = new Set();
			this.violationRecords.forEach(record => {
				violators.add(record.violatorId);
				violators.add(record.targetId);
			});
			return Array.from(violators);
		},
		
		// 是否为群主
		isOwner() {
			return this.userStore.userInfo.id === this.groupInfo.ownerId;
		},
		
		// 是否为管理员
		isManager() {
			return this.groupInfo.isManager || false;
		},
		
		// 是否可以管理
		canManage() {
			return this.isOwner || this.isManager;
		}
	},
	onLoad(options) {
		this.groupId = options.groupId;
		this.loadViolationRecords();
	},
	onShow() {
		// 页面显示时刷新数据
		if (this.groupId) {
			this.loadViolationRecords();
		}
	}
}
</script>

<style lang="scss" scoped>
.group-violation-records {
	.violation-stats {
		display: flex;
		align-items: center;
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
				
				&.danger {
					color: #ff4d4f;
				}
			}
			
			.stats-label {
				font-size: $im-font-size-small;
				color: $im-text-color-light;
			}
		}
		
		.stats-divider {
			width: 1rpx;
			height: 60rpx;
			background: #f0f0f0;
		}
	}
	
	.warning-notice {
		display: flex;
		align-items: flex-start;
		padding: 30rpx;
		background: #fff2f0;
		border: 1rpx solid #ffccc7;
		border-radius: 12rpx;
		margin: 0 30rpx;
		
		.notice-icon {
			margin-right: 15rpx;
			margin-top: 5rpx;
		}
		
		.notice-content {
			flex: 1;
			
			.notice-title {
				display: block;
				font-size: $im-font-size;
				font-weight: 600;
				color: #ff4d4f;
				margin-bottom: 8rpx;
			}
			
			.notice-desc {
				display: block;
				font-size: $im-font-size-small;
				color: #ff4d4f;
				line-height: 1.6;
			}
		}
	}
	
	.violation-list {
		.list-title {
			padding: 20rpx 30rpx 10rpx 30rpx;
			font-size: $im-font-size;
			color: $im-text-color-light;
			font-weight: 600;
		}
		
		.violation-item {
			display: flex;
			align-items: flex-start;
			padding: 30rpx;
			background: #ffffff;
			border-bottom: 1rpx solid #f0f0f0;
			
			.violation-icon {
				margin-right: 20rpx;
				margin-top: 5rpx;
			}
			
			.violation-info {
				flex: 1;
				min-width: 0;
				
				.violation-title {
					font-size: $im-font-size;
					font-weight: 600;
					color: $im-text-color-dark;
					margin-bottom: 8rpx;
				}
				
				.violation-desc {
					display: flex;
					flex-direction: column;
					gap: 4rpx;
					margin-bottom: 8rpx;
					
					.violator-names {
						font-size: $im-font-size-small;
						color: $im-text-color;
					}
					
					.violation-time {
						font-size: $im-font-size-small;
						color: $im-text-color-light;
					}
				}
				
				.violation-detail {
					font-size: $im-font-size-small;
					color: $im-text-color-light;
					line-height: 1.4;
				}
			}
			
			.violation-status {
				display: flex;
				flex-direction: column;
				align-items: flex-end;
				gap: 10rpx;
				
				.status-badge {
					padding: 8rpx 16rpx;
					border-radius: 20rpx;
					font-size: $im-font-size-small;
					
					&.pending {
						background: #fff7e6;
						color: #fa8c16;
						border: 1rpx solid #ffd591;
					}
					
					&.confirmed {
						background: #fff2f0;
						color: #ff4d4f;
						border: 1rpx solid #ffccc7;
					}
					
					&.ignored {
						background: #f6ffed;
						color: #52c41a;
						border: 1rpx solid #b7eb8f;
					}
					
					&.auto {
						background: #f0f0f0;
						color: #8c8c8c;
						border: 1rpx solid #d9d9d9;
					}
				}
				
				.violation-actions {
					display: flex;
					gap: 8rpx;
					
					.action-btn {
						padding: 8rpx 16rpx;
						border-radius: 6rpx;
						font-size: $im-font-size-small;
						border: none;
						
						&.ignore {
							background: #f0f0f0;
							color: #8c8c8c;
						}
						
						&.confirm {
							background: #ff4d4f;
							color: #ffffff;
						}
						
						&:active {
							opacity: 0.8;
						}
					}
				}
			}
		}
	}
	
	.empty-state {
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;
		padding: 100rpx 30rpx;
		
		.empty-text {
			font-size: $im-font-size-large;
			color: $im-text-color-light;
			margin: 30rpx 0 10rpx 0;
		}
		
		.empty-desc {
			font-size: $im-font-size-small;
			color: $im-text-color-lighter;
		}
	}
	
	.rules-section {
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
			}
		}
	}
}
</style>