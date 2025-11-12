<template>
	<view class="distribution-container">
		<view class="header-card">
			<view class="balance-section">
				<view class="label">可提现佣金</view>
				<view class="amount">¥{{ distributorInfo.availableCommission || 0 }}</view>
				<button class="withdraw-btn" @click="showWithdrawModal = true">提现</button>
			</view>
			<view class="stats-section">
				<view class="stat-item">
					<view class="stat-value">¥{{ distributorInfo.totalCommission || 0 }}</view>
					<view class="stat-label">累计佣金</view>
				</view>
				<view class="stat-item">
					<view class="stat-value">{{ distributorInfo.level1Count || 0 }}</view>
					<view class="stat-label">直推人数</view>
				</view>
				<view class="stat-item">
					<view class="stat-value">{{ distributorInfo.level2Count || 0 }}</view>
					<view class="stat-label">间推人数</view>
				</view>
			</view>
		</view>

		<view class="code-card">
			<view class="code-title">我的推广码</view>
			<view class="code-value">{{ distributorInfo.referralCode || '未激活' }}</view>
			<button v-if="distributorInfo.status === 1" class="copy-btn" @click="copyCode">复制推广码</button>
			<button v-else class="activate-btn" type="primary" @click="activateDistributor">激活分销商</button>
		</view>

		<view class="menu-list">
			<view class="menu-item" @click="goToCommissionList">
				<text class="menu-label">佣金明细</text>
				<text class="menu-arrow">›</text>
			</view>
		</view>

		<!-- 提现弹窗 -->
		<view v-if="showWithdrawModal" class="modal-mask" @click="showWithdrawModal = false">
			<view class="modal-content" @click.stop>
				<view class="modal-title">佣金提现</view>
				<view class="form-item">
					<text class="form-label">提现金额</text>
					<input 
						v-model="withdrawAmount" 
						type="digit" 
						placeholder="请输入提现金额"
						class="form-input"
					/>
				</view>
				<view class="form-item">
					<text class="form-label">交易密码</text>
					<input 
						v-model="tradePassword" 
						type="password" 
						placeholder="请输入交易密码"
						class="form-input"
					/>
				</view>
				<view class="modal-actions">
					<button class="cancel-btn" @click="showWithdrawModal = false">取消</button>
					<button class="confirm-btn" type="primary" @click="handleWithdraw">确认</button>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
export default {
	data() {
		return {
			distributorInfo: {},
			showWithdrawModal: false,
			withdrawAmount: '',
			tradePassword: ''
		}
	},
	onShow() {
		this.loadDistributorInfo();
	},
	methods: {
		async loadDistributorInfo() {
			try {
				const res = await this.$http.get('/distribution/info');
				this.distributorInfo = res.data || {};
			} catch (e) {
				// 如果还不是分销商，显示激活按钮
				console.log('Not a distributor yet');
			}
		},
		async activateDistributor() {
			uni.showModal({
				title: '激活分销商',
				content: '是否激活成为分销商？',
				success: async (res) => {
					if (res.confirm) {
						try {
							const result = await this.$http.post('/distribution/activate', {});
							uni.showToast({
								title: '激活成功',
								icon: 'success'
							});
							this.loadDistributorInfo();
						} catch (e) {
							uni.showToast({
								title: e.message || '激活失败',
								icon: 'none'
							});
						}
					}
				}
			});
		},
		copyCode() {
			uni.setClipboardData({
				data: this.distributorInfo.referralCode,
				success: () => {
					uni.showToast({
						title: '复制成功',
						icon: 'success'
					});
				}
			});
		},
		async handleWithdraw() {
			if (!this.withdrawAmount || parseFloat(this.withdrawAmount) <= 0) {
				uni.showToast({
					title: '请输入有效金额',
					icon: 'none'
				});
				return;
			}
			
			if (!this.tradePassword) {
				uni.showToast({
					title: '请输入交易密码',
					icon: 'none'
				});
				return;
			}
			
			try {
				await this.$http.post('/distribution/commission/withdraw', {
					amount: parseFloat(this.withdrawAmount),
					tradePassword: this.tradePassword
				});
				
				uni.showToast({
					title: '提现成功',
					icon: 'success'
				});
				
				this.showWithdrawModal = false;
				this.withdrawAmount = '';
				this.tradePassword = '';
				this.loadDistributorInfo();
			} catch (e) {
				uni.showToast({
					title: e.message || '提现失败',
					icon: 'none'
				});
			}
		},
		goToCommissionList() {
			uni.navigateTo({
				url: '/pages/distribution/commission-list'
			});
		}
	}
}
</script>

<style lang="scss" scoped>
.distribution-container {
	min-height: 100vh;
	background: #f5f5f5;
	padding: 20rpx;
}

.header-card {
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	border-radius: 20rpx;
	padding: 40rpx;
	margin-bottom: 20rpx;
	color: #fff;
	
	.balance-section {
		text-align: center;
		margin-bottom: 40rpx;
		
		.label {
			font-size: 28rpx;
			margin-bottom: 20rpx;
		}
		
		.amount {
			font-size: 60rpx;
			font-weight: bold;
			margin-bottom: 30rpx;
		}
		
		.withdraw-btn {
			width: 200rpx;
			height: 60rpx;
			line-height: 60rpx;
			background: #fff;
			color: #667eea;
			border-radius: 30rpx;
			font-size: 28rpx;
			border: none;
		}
	}
	
	.stats-section {
		display: flex;
		justify-content: space-around;
		
		.stat-item {
			text-align: center;
			
			.stat-value {
				font-size: 36rpx;
				font-weight: bold;
				margin-bottom: 10rpx;
			}
			
			.stat-label {
				font-size: 24rpx;
				opacity: 0.8;
			}
		}
	}
}

.code-card {
	background: #fff;
	border-radius: 20rpx;
	padding: 40rpx;
	margin-bottom: 20rpx;
	text-align: center;
	
	.code-title {
		font-size: 28rpx;
		color: #666;
		margin-bottom: 20rpx;
	}
	
	.code-value {
		font-size: 48rpx;
		font-weight: bold;
		color: #667eea;
		margin-bottom: 30rpx;
		letter-spacing: 4rpx;
	}
	
	.copy-btn,
	.activate-btn {
		width: 300rpx;
		height: 70rpx;
		line-height: 70rpx;
		border-radius: 35rpx;
		font-size: 28rpx;
	}
	
	.copy-btn {
		background: #f0f0f0;
		color: #333;
		border: none;
	}
}

.menu-list {
	background: #fff;
	border-radius: 20rpx;
	
	.menu-item {
		display: flex;
		justify-content: space-between;
		align-items: center;
		padding: 30rpx 40rpx;
		border-bottom: 1px solid #f0f0f0;
		
		&:last-child {
			border-bottom: none;
		}
		
		.menu-label {
			font-size: 32rpx;
		}
		
		.menu-arrow {
			font-size: 40rpx;
			color: #ccc;
		}
	}
}

.modal-mask {
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background: rgba(0, 0, 0, 0.5);
	display: flex;
	justify-content: center;
	align-items: center;
	z-index: 9999;
}

.modal-content {
	width: 600rpx;
	background: #fff;
	border-radius: 20rpx;
	padding: 40rpx;
	
	.modal-title {
		font-size: 36rpx;
		font-weight: bold;
		text-align: center;
		margin-bottom: 40rpx;
	}
	
	.form-item {
		margin-bottom: 30rpx;
		
		.form-label {
			display: block;
			font-size: 28rpx;
			margin-bottom: 15rpx;
		}
		
		.form-input {
			width: 100%;
			height: 80rpx;
			padding: 0 20rpx;
			border: 1px solid #ddd;
			border-radius: 10rpx;
			font-size: 28rpx;
		}
	}
	
	.modal-actions {
		display: flex;
		gap: 20rpx;
		margin-top: 40rpx;
		
		button {
			flex: 1;
			height: 80rpx;
			line-height: 80rpx;
			border-radius: 40rpx;
			font-size: 28rpx;
		}
		
		.cancel-btn {
			background: #f0f0f0;
			color: #333;
			border: none;
		}
	}
}
</style>
