<template>
	<view class="page group-settings">
		<nav-bar title="群组设置" back></nav-bar>
		
		<!-- 基础设置 -->
		<bar-group>
			<view class="section-title">基础设置</view>
			<switch-bar 
				title="全员禁言" 
				:checked="groupSettings.isMuted" 
				@change="onMutedChange"
				:disabled="!canManage"
			></switch-bar>
			<switch-bar 
				title="新成员需要验证" 
				:checked="groupSettings.needApproval" 
				@change="onApprovalChange"
				:disabled="!canManage"
			></switch-bar>
		</bar-group>
		
		<!-- VIP群组特殊规则 -->
		<bar-group v-if="isVipGroup">
			<view class="section-title">VIP群组规则</view>
			<switch-bar 
				title="禁止成员互加好友" 
				:checked="groupSettings.forbidAddFriend" 
				@change="onForbidAddFriendChange"
				:disabled="!canManage"
			></switch-bar>
			<view class="setting-desc">
				<text class="desc-text">开启后，群内成员将无法互相添加好友</text>
			</view>
		</bar-group>
		
		<!-- 违规处理 -->
		<bar-group v-if="isVipGroup">
			<view class="section-title">违规处理</view>
			<arrow-bar 
				title="违规记录" 
				icon="icon-warning" 
				@tap="viewViolationRecords"
				icon-color="#ff4d4f"
			>
				<text class="arrow-text">{{ violationCount }}条记录</text>
			</arrow-bar>
			<view class="setting-desc">
				<text class="desc-text">• 发现成员互加好友将自动记录违规</text>
				<text class="desc-text">• 累计3次违规将自动解散群组</text>
				<text class="desc-text">• 群主可查看详细违规记录</text>
			</view>
		</bar-group>
		
		<!-- 群组信息 -->
		<bar-group>
			<view class="section-title">群组信息</view>
			<view class="info-item">
				<text class="info-label">群组类型</text>
				<text class="info-value">{{ isVipGroup ? 'VIP专属群组' : '普通群组' }}</text>
			</view>
			<view class="info-item">
				<text class="info-label">创建时间</text>
				<text class="info-value">{{ formatTime(groupInfo.createTime) }}</text>
			</view>
			<view class="info-item">
				<text class="info-label">成员数量</text>
				<text class="info-value">{{ groupInfo.memberCount }}人</text>
			</view>
		</bar-group>
		
		<!-- 危险操作 -->
		<bar-group v-if="canManage">
			<view class="section-title">危险操作</view>
			<arrow-bar 
				title="重置群组设置" 
				icon="icon-refresh" 
				@tap="resetSettings"
				icon-color="#fa8c16"
			></arrow-bar>
			<arrow-bar 
				v-if="isOwner"
				title="解散群组" 
				icon="icon-delete" 
				@tap="dissolveGroup"
				icon-color="#ff4d4f"
			></arrow-bar>
		</bar-group>
		
		<popup-modal ref="modal"></popup-modal>
	</view>
</template>

<script>
export default {
	name: "group-settings",
	data() {
		return {
			groupId: '',
			groupInfo: {},
			groupSettings: {
				isMuted: false,
				needApproval: false,
				forbidAddFriend: false
			},
			violationCount: 0,
			loading: false
		}
	},
	methods: {
		// 加载群组信息
		loadGroupInfo() {
			this.$http({
				url: `/group/find/${this.groupId}`,
				method: 'GET'
			}).then((res) => {
				this.groupInfo = res;
				this.loadGroupSettings();
			}).catch((err) => {
				console.error('加载群组信息失败:', err);
			});
		},
		
		// 加载群组设置
		loadGroupSettings() {
			this.$http({
				url: `/group/settings/${this.groupId}`,
				method: 'GET'
			}).then((res) => {
				this.groupSettings = {
					isMuted: res.isMuted || false,
					needApproval: res.needApproval || false,
					forbidAddFriend: res.forbidAddFriend || false
				};
				this.violationCount = res.violationCount || 0;
			}).catch((err) => {
				console.error('加载群组设置失败:', err);
			});
		},
		
		// 全员禁言设置
		onMutedChange(e) {
			this.updateGroupSetting('isMuted', e.detail.value);
		},
		
		// 新成员验证设置
		onApprovalChange(e) {
			this.updateGroupSetting('needApproval', e.detail.value);
		},
		
		// 禁止互加好友设置
		onForbidAddFriendChange(e) {
			const newValue = e.detail.value;
			
			if (newValue) {
				// 开启禁止互加好友时给出警告
				this.$refs.modal.open({
					title: '重要提醒',
					content: '开启此功能后，群内成员将无法互相添加好友。如发现违规行为，系统将自动记录并可能解散群组。确认开启吗？',
					success: () => {
						this.updateGroupSetting('forbidAddFriend', newValue);
					},
					cancel: () => {
						// 取消时恢复原状态
						this.groupSettings.forbidAddFriend = false;
					}
				});
			} else {
				this.updateGroupSetting('forbidAddFriend', newValue);
			}
		},
		
		// 更新群组设置
		updateGroupSetting(key, value) {
			if (this.loading) return;
			
			this.loading = true;
			this.$http({
				url: `/group/settings/${this.groupId}`,
				method: 'PUT',
				data: {
					[key]: value
				}
			}).then(() => {
				this.groupSettings[key] = value;
				uni.showToast({
					title: '设置已更新',
					icon: 'success'
				});
			}).catch((err) => {
				console.error('更新设置失败:', err);
				uni.showToast({
					title: '设置失败',
					icon: 'none'
				});
				// 恢复原状态
				this.groupSettings[key] = !value;
			}).finally(() => {
				this.loading = false;
			});
		},
		
		// 查看违规记录
		viewViolationRecords() {
			uni.navigateTo({
				url: `/pages/group/group-violation-records?groupId=${this.groupId}`
			});
		},
		
		// 重置群组设置
		resetSettings() {
			this.$refs.modal.open({
				title: '重置设置',
				content: '确认将群组设置重置为默认状态吗？',
				success: () => {
					this.$http({
						url: `/group/settings/${this.groupId}/reset`,
						method: 'POST'
					}).then(() => {
						uni.showToast({
							title: '设置已重置',
							icon: 'success'
						});
						this.loadGroupSettings();
					}).catch((err) => {
						console.error('重置设置失败:', err);
						uni.showToast({
							title: '重置失败',
							icon: 'none'
						});
					});
				}
			});
		},
		
		// 解散群组
		dissolveGroup() {
			this.$refs.modal.open({
				title: '解散群组',
				content: `确认解散群组"${this.groupInfo.name}"吗？解散后无法恢复。`,
				success: () => {
					this.$http({
						url: `/group/${this.groupId}`,
						method: 'DELETE'
					}).then(() => {
						uni.showToast({
							title: '群组已解散',
							icon: 'success'
						});
						// 返回群组列表
						uni.navigateBack({
							delta: 2
						});
					}).catch((err) => {
						console.error('解散群组失败:', err);
						uni.showToast({
							title: '解散失败',
							icon: 'none'
						});
					});
				}
			});
		},
		
		// 格式化时间
		formatTime(timestamp) {
			if (!timestamp) return '';
			
			const date = new Date(timestamp);
			return date.toLocaleDateString('zh-CN', {
				year: 'numeric',
				month: '2-digit',
				day: '2-digit',
				hour: '2-digit',
				minute: '2-digit'
			});
		}
	},
	computed: {
		// 是否为VIP群组
		isVipGroup() {
			return this.groupInfo.isVipGroup || false;
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
		this.loadGroupInfo();
	},
	onShow() {
		// 页面显示时刷新数据
		if (this.groupId) {
			this.loadGroupSettings();
		}
	}
}
</script>

<style lang="scss" scoped>
.group-settings {
	.section-title {
		padding: 20rpx 30rpx 10rpx 30rpx;
		font-size: $im-font-size;
		color: $im-text-color-light;
		font-weight: 600;
	}
	
	.setting-desc {
		padding: 20rpx 30rpx;
		background: #ffffff;
		border-top: 1rpx solid #f0f0f0;
		
		.desc-text {
			display: block;
			font-size: $im-font-size-small;
			color: $im-text-color-light;
			line-height: 1.6;
			margin-bottom: 8rpx;
			
			&:last-child {
				margin-bottom: 0;
			}
		}
	}
	
	.info-item {
		display: flex;
		justify-content: space-between;
		align-items: center;
		padding: 30rpx;
		background: #ffffff;
		border-bottom: 1rpx solid #f0f0f0;
		
		&:last-child {
			border-bottom: none;
		}
		
		.info-label {
			font-size: $im-font-size;
			color: $im-text-color-dark;
		}
		
		.info-value {
			font-size: $im-font-size;
			color: $im-text-color-light;
		}
	}
	
	.arrow-text {
		color: $im-text-color-lighter;
		font-size: $im-font-size-small;
	}
}
</style>