<template>
	<view class="mall-container">
		<scroll-view scroll-y class="product-list" @scrolltolower="loadMore">
			<view 
				v-for="product in productList" 
				:key="product.id" 
				class="product-item"
				@click="goToDetail(product.id)"
			>
				<image 
					:src="product.imageUrl || '/static/default-product.png'" 
					class="product-image"
					mode="aspectFill"
				></image>
				<view class="product-info">
					<view class="product-name">{{ product.productName }}</view>
					<view class="product-desc">{{ product.description }}</view>
					<view class="product-footer">
						<view class="price-section">
							<text class="current-price">¥{{ product.price }}</text>
							<text v-if="product.originalPrice" class="original-price">¥{{ product.originalPrice }}</text>
						</view>
						<view class="sales">已售{{ product.salesCount }}</view>
					</view>
					<view v-if="product.enableDistribution" class="distribution-badge">
						支持分销
					</view>
				</view>
			</view>

			<view v-if="productList.length === 0" class="empty">
				<text>暂无商品</text>
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
			productList: [],
			pageNum: 1,
			pageSize: 20,
			loading: false,
			hasMore: true
		}
	},
	onLoad() {
		this.loadProducts();
	},
	methods: {
		async loadProducts() {
			if (this.loading || !this.hasMore) return;
			
			this.loading = true;
			try {
				const res = await this.$http.get('/mall/product/list', {
					params: {
						pageNum: this.pageNum,
						pageSize: this.pageSize
					}
				});
				
				const newData = res.data || [];
				this.productList.push(...newData);
				
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
				this.loadProducts();
			}
		},
		goToDetail(productId) {
			uni.navigateTo({
				url: `/pages/mall/product-detail?id=${productId}`
			});
		}
	}
}
</script>

<style lang="scss" scoped>
.mall-container {
	height: 100vh;
	background: #f5f5f5;
}

.product-list {
	height: 100%;
	padding: 20rpx;
}

.product-item {
	background: #fff;
	border-radius: 10rpx;
	margin-bottom: 20rpx;
	overflow: hidden;
	display: flex;
	
	.product-image {
		width: 200rpx;
		height: 200rpx;
	}
	
	.product-info {
		flex: 1;
		padding: 20rpx;
		position: relative;
		
		.product-name {
			font-size: 32rpx;
			font-weight: bold;
			margin-bottom: 10rpx;
			overflow: hidden;
			text-overflow: ellipsis;
			white-space: nowrap;
		}
		
		.product-desc {
			font-size: 26rpx;
			color: #666;
			margin-bottom: 20rpx;
			overflow: hidden;
			text-overflow: ellipsis;
			display: -webkit-box;
			-webkit-line-clamp: 2;
			-webkit-box-orient: vertical;
		}
		
		.product-footer {
			display: flex;
			justify-content: space-between;
			align-items: center;
			
			.price-section {
				.current-price {
					font-size: 36rpx;
					font-weight: bold;
					color: #ff6b6b;
					margin-right: 10rpx;
				}
				
				.original-price {
					font-size: 24rpx;
					color: #999;
					text-decoration: line-through;
				}
			}
			
			.sales {
				font-size: 24rpx;
				color: #999;
			}
		}
		
		.distribution-badge {
			position: absolute;
			top: 20rpx;
			right: 20rpx;
			padding: 6rpx 15rpx;
			background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
			color: #fff;
			font-size: 22rpx;
			border-radius: 20rpx;
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
