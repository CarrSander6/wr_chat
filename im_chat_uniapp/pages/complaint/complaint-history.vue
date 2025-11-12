<template>
	<view class="page complaint-history">
		<nav-bar title="我的投诉" back></nav-bar>
		<view class="tab-control" id="tabCtrl">
			<tabs :items="items" @change="onChange" :current="tabIdx"></tabs>
		</view>
		<view v-if="tabIdx === 0" class="content">
			<scroll-view class="chat-message-list" :style="{height: scrollbarHeight+'px'}" scroll-y="true"
				upper-threshold="200" @scrolltolower="onScrollToBottom">
				<view v-if="curTabs.items.length>0" v-for="item in curTabs.items" :key="item.id">
					<view class="complaint-info" @click="onShowDetail(item)">
						<view class="header">
							<view class="title">{{item.targetName}}</view>
						</view>
						<view class="item">
							<view class="label">投诉原因:</view>
							<view class="value">{{complaintTypeText(item)}}</view>
						</view>
						<view class="item">
							<view class="label">投诉时间:</view>
							<view class="value">{{item.createTime}}</view>
						</view>
						<view class="item">
							<view class="label">投诉内容:</view>
							<view class="value">{{item.content}}</view>
						</view>
						<view class="tip">
							<view class="icon iconfont icon-wait"></view>
							<view class="content-tip">我们正在核实您的投诉，请耐心等待反馈结果，感谢您的反馈</view>
						</view>
					</view>
				</view>
				<no-data-tip v-else class="no-data-tip"></no-data-tip>
			</scroll-view>
		</view>
		<view v-if="tabIdx === 1" class="content">
			<scroll-view class="chat-message-list" :style="{height: scrollbarHeight+'px'}" scroll-y="true"
				upper-threshold="200" @scrolltolower="onScrollToBottom">
				<view v-if="curTabs.items.length>0" class="item" v-for="item in curTabs.items" :key="item.id">
					<view class="complaint-info" @click="onShowDetail(item)">
						<view class="header">
							<view>{{item.targetName}}</view>
						</view>
						<view class="item">
							<view class="label">投诉原因:</view>
							<view class="value">{{complaintTypeText(item)}}</view>
						</view>
						<view class="item">
							<view class="label">投诉时间:</view>
							<view class="value">{{item.createTime}}</view>
						</view>
						<view class="item">
							<view class="label">处理结果:</view>
							<view class="value">{{reslovedTypeText(item)}}</view>
						</view>
						<view class="tip">
							<view v-if="item.resolvedType == 1" class="icon iconfont icon-success"></view>
							<view v-else-if="item.resolvedType != 4" class="icon iconfont icon-error"></view>
							<view class="content-tip">{{item.resolvedSummary}}</view>
						</view>
					</view>
				</view>
				<no-data-tip v-else class="no-data-tip"></no-data-tip>
			</scroll-view>
		</view>
	</view>
</template>

<script>
export default {
	data() {
		return {
			tabIdx: 0,
			items: ["处理中", "已处理"],
			tabs: [{
				items: [],
				noMoreData: false,
			}, {
				items: [],
				noMoreData: false
			}],
			tabCtrlHeight: 50
		}
	},
	methods: {
		onChange(idx) {
			this.tabIdx = idx;
			if (!this.curTabs.noMoreData && this.curTabs.items.length == 0) {
				this.loadNextPage();
			}
		},
		onScrollToBottom() {
			if (this.curTabs.noMoreData) {
				uni.showToast({
					title: '没有更多数据了',
					icon: 'none'
				})
				return;
			}
			this.loadNextPage();
		},
		onShowDetail(item) {
			uni.navigateTo({
				url: '/pages/complaint/complaint-info?id=' + item.id
			})
		},
		loadNextPage() {
			const status = this.tabIdx + 1;
			const maxPageId = this.nextPageMaxId;
			this.$http({
				url: `/complaint/page?maxPageId=${maxPageId}&status=${status}`,
				method: 'GET'
			}).then((items) => {
				this.curTabs.items.push(...items);
				this.curTabs.noMoreData = items.length < 10;
			})
		},
		complaintTypeText(item) {
			const dict = this.$dict.COMPLAINT_TYPE;
			return this.$dict.covertToName(dict, item.type, '')
		},
		reslovedTypeText(item) {
			const dict = this.$dict.RESOLVED_TYPE;
			return this.$dict.covertToName(dict, item.resolvedType, '')
		}
	},
	computed: {
		nextPageMaxId() {
			if (this.curTabs.items.length > 0) {
				const idx = this.curTabs.items.length - 1;
				return this.curTabs.items[idx].id
			}
			return -1;
		},
		curTabs() {
			return this.tabs[this.tabIdx];
		},
		scrollbarHeight() {
			let h = uni.getSystemInfoSync().windowHeight;
			// 减去标题栏高度
			h -= 50;
			// 减去标签栏高度
			h -= this.tabCtrlHeight;
			// #ifndef H5
			// h5需要减去状态栏高度
			h -= uni.getSystemInfoSync().statusBarHeight;
			// #endif
			return h;
		},
	},
	onLoad() {
		this.loadNextPage();
	},
	mounted() {
		// 计算元素高度
		const query = uni.createSelectorQuery().in(this);
		query.select('#tabCtrl').boundingClientRect(rect => {
			this.tabCtrlHeight = Number(rect.height)
			console.log("this.tabCtrlHeight:", this.tabCtrlHeight)
		}).exec();

	}
}
</script>

<style lang="scss" scoped>
.complaint-history {
	display: flex;
	flex-direction: column;

	.tab-control {
		padding: 20rpx;
		background: white;
	}

	.content {
		position: relative;
		flex: 1;

		.complaint-info {
			position: relative;
			margin: 30rpx;
			background-color: white;
			border-radius: 20rpx;
			padding: 20rpx;

			.header {
				display: flex;
				padding: 5rpx;
				margin: 10rpx 0;
				font-size: $im-font-size;
				font-weight: bold;
			}

			.item {
				display: flex;
				font-size: $im-font-size-small;
				color: $im-text-color-light;
				padding: 5rpx;
				margin: 5rpx;

				.value {
					flex: 1;
					margin-left: 10rpx;
					word-break: break-all;
				}
			}

			.tip {
				display: flex;
				align-items: center;
				border-radius: 10rpx;
				background: $im-bg;
				padding: 10rpx 5rpx;

				.icon {
					font-size: 40rpx;
					border-radius: 50%;

					&.icon-wait {
						color: $im-color-primary;
					}

					&.icon-error {
						color: $im-color-danger;
					}

					&.icon-success {
						color: $im-color-success;
					}
				}

				.content-tip {
					font-size: $im-font-size-smaller;
					color: $im-text-color-light;
					margin-left: 10rpx;
				}
			}
		}

		.no-data-tip {
			height: 100%;
		}
	}
}
</style>