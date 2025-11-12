<template>
	<view class="product-detail-container">
		<scroll-view scroll-y class="content">
			<image 
				:src="product.imageUrl || '/static/default-product.png'" 
				class="product-image"
				mode="aspectFill"
			></image>
			
			<view class="product-info-card">
				<view class="price-section">
					<text class="current-price">¥{{ product.price }}</text>
					<text v-if="product.originalPrice" class="original-price">¥{{ product.originalPrice }}</text>
				</view>
				<view class="product-name">{{ product.productName }}</view>
				<view class="product-desc">{{ product.description }}</view>
				
				<view class="product-meta">
					<text>库存: {{ product.stock }}</text>
					<text>已售: {{ product.salesCount }}</text>
				</view>
				
				<view v-if="product.enableDistribution" class="distribution-info">
					<text class="distribution-title">🎁 分销佣金</text>
					<text class="distribution-text">直推佣金: {{ (product.level1CommissionRate * 100).toFixed(2) }}%</text>
					<text class="distribution-text">间推佣金: {{ (product.level2CommissionRate * 100).toFixed(2) }}%</text>
				</view>
			</view>
		</scroll-view>
		
		<view class="footer-bar">
			<view class="quantity-selector">
				<button class="quantity-btn" @click="decreaseQuantity">-</button>
				<text class="quantity">{{ quantity }}</text>
				<button class="quantity-btn" @click="increaseQuantity">+</button>
			</view>
			<button class="buy-btn" type="primary" @click="showPaymentModal = true">立即购买</button>
		</view>

		<!-- 支付方式选择弹窗 -->
		<view v-if="showPaymentModal" class="modal-mask" @click="showPaymentModal = false">
			<view class="modal-content" @click.stop>
				<view class="modal-title">选择支付方式</view>
				<view class="payment-options">
					<view 
						class="payment-option" 
						:class="{ active: paymentMethod === 1 }"
						@click="paymentMethod = 1"
					>
						<text>余额支付</text>
						<text class="check">✓</text>
					</view>
					<!-- #ifdef APP-PLUS -->
					<view 
						class="payment-option" 
						:class="{ active: paymentMethod === 2 }"
						@click="paymentMethod = 2"
					>
						<text>iOS内购</text>
						<text class="check">✓</text>
					</view>
					<!-- #endif -->
				</view>
				<view class="modal-actions">
					<button class="cancel-btn" @click="showPaymentModal = false">取消</button>
					<button class="confirm-btn" type="primary" @click="handlePurchase">确认支付</button>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
export default {
	data() {
		return {
			productId: null,
			product: {},
			quantity: 1,
			paymentMethod: 1,
			showPaymentModal: false
		}
	},
	onLoad(options) {
		this.productId = options.id;
		this.loadProductDetail();
	},
	methods: {
		async loadProductDetail() {
			try {
				const res = await this.$http.get(`/mall/product/${this.productId}`);
				this.product = res.data || {};
			} catch (e) {
				uni.showToast({
					title: '加载失败',
					icon: 'none'
				});
			}
		},
		increaseQuantity() {
			if (this.quantity < this.product.stock) {
				this.quantity++;
			}
		},
		decreaseQuantity() {
			if (this.quantity > 1) {
				this.quantity--;
			}
		},
		async handlePurchase() {
			try {
				const orderData = {
					productId: this.productId,
					quantity: this.quantity,
					paymentMethod: this.paymentMethod
				};
				
				// TODO: iOS IAP处理
				// #ifdef APP-PLUS
				if (this.paymentMethod === 2) {
					// 调用iOS内购SDK
					// orderData.iosReceipt = receipt;
				}
				// #endif
				
				const res = await this.$http.post('/mall/order/create', orderData);
				
				uni.showModal({
					title: '购买成功',
					content: '商品已购买成功',
					showCancel: false,
					success: () => {
						uni.navigateTo({
							url: '/pages/mall/order-list'
						});
					}
				});
			} catch (e) {
				uni.showToast({
					title: e.message || '购买失败',
					icon: 'none'
				});
			}
		}
	}
}
</script>

<style lang="scss" scoped>
.product-detail-container {
	height: 100vh;
	display: flex;
	flex-direction: column;
	background: #f5f5f5;
}

.content {
	flex: 1;
}

.product-image {
	width: 100%;
	height: 500rpx;
}

.product-info-card {
	background: #fff;
	padding: 30rpx;
	margin-bottom: 20rpx;
	
	.price-section {
		margin-bottom: 20rpx;
		
		.current-price {
			font-size: 48rpx;
			font-weight: bold;
			color: #ff6b6b;
			margin-right: 15rpx;
		}
		
		.original-price {
			font-size: 28rpx;
			color: #999;
			text-decoration: line-through;
		}
	}
	
	.product-name {
		font-size: 36rpx;
		font-weight: bold;
		margin-bottom: 15rpx;
	}
	
	.product-desc {
		font-size: 28rpx;
		color: #666;
		line-height: 1.6;
		margin-bottom: 20rpx;
	}
	
	.product-meta {
		display: flex;
		gap: 40rpx;
		font-size: 26rpx;
		color: #999;
		margin-bottom: 20rpx;
	}
	
	.distribution-info {
		background: linear-gradient(135deg, #667eea10 0%, #764ba210 100%);
		padding: 20rpx;
		border-radius: 10rpx;
		
		.distribution-title {
			display: block;
			font-size: 28rpx;
			font-weight: bold;
			margin-bottom: 10rpx;
		}
		
		.distribution-text {
			display: block;
			font-size: 26rpx;
			color: #666;
			margin-top: 5rpx;
		}
	}
}

.footer-bar {
	background: #fff;
	padding: 20rpx 30rpx;
	display: flex;
	align-items: center;
	gap: 20rpx;
	border-top: 1px solid #eee;
	
	.quantity-selector {
		display: flex;
		align-items: center;
		border: 1px solid #ddd;
		border-radius: 30rpx;
		overflow: hidden;
		
		.quantity-btn {
			width: 60rpx;
			height: 60rpx;
			line-height: 60rpx;
			text-align: center;
			background: #f5f5f5;
			border: none;
			font-size: 32rpx;
		}
		
		.quantity {
			width: 80rpx;
			text-align: center;
			font-size: 28rpx;
		}
	}
	
	.buy-btn {
		flex: 1;
		height: 80rpx;
		line-height: 80rpx;
		border-radius: 40rpx;
		font-size: 32rpx;
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
	
	.payment-options {
		margin-bottom: 40rpx;
		
		.payment-option {
			display: flex;
			justify-content: space-between;
			align-items: center;
			padding: 30rpx;
			border: 2px solid #ddd;
			border-radius: 10rpx;
			margin-bottom: 20rpx;
			font-size: 28rpx;
			
			&.active {
				border-color: #667eea;
				color: #667eea;
				
				.check {
					display: inline;
				}
			}
			
			.check {
				display: none;
				font-size: 32rpx;
			}
		}
	}
	
	.modal-actions {
		display: flex;
		gap: 20rpx;
		
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
