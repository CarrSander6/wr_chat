<template>
	<view class="page complaint-info">
		<nav-bar title="投诉详情" back></nav-bar>
		<up-steps class="card-info" direction="column" current="0" dot>
			<view class='card-title'>投诉进度</view>
			<up-steps-item>
				<template #content>
					<view class="step">
						<view v-if="complaint.status ==1">
							<view class="step-header active">
								<text class="title">审核中</text>
								<text class="time">{{complaint.createTime}}</text>
							</view>
							<view class="content">
								我们正在核实您的投诉，请耐心等待反馈结果，感谢您的监督和反馈
							</view>
						</view>
						<view v-else>
							<view class="step-header active">
								<text class="title">{{reslovedTypeText}}</text>
								<text class="time">{{complaint.resolvedTime}}</text>
							</view>
							<view class="content" v-if="complaint.resolvedSummary">
								{{complaint.resolvedSummary}}
							</view>
						</view>
					</view>
				</template>
			</up-steps-item>
			<up-steps-item>
				<template #content>
					<view class="step">
						<view class="step-header">
							<text class="title">发起投诉</text>
							<text class="time">{{complaint.createTime}}</text>
						</view>
						<view class="content">
							{{complaint.content}}
						</view>
						<view class="images">
							<view v-for="(img,idx) in complaint.images" :key="idx">
								<image class="image" mode="aspectFill" :src="img.thumbUrl" lazy-load="true"
									@click.stop="onShowFullImage(img.originUrl)">
								</image>
							</view>
						</view>
					</view>
				</template>
			</up-steps-item>
		</up-steps>
		<view class="card-info">
			<view class="card-title">投诉详情</view>
			<view class="item">
				<view class="label">投诉对象</view>
				<view class="value">{{complaint.targetName}}</view>
			</view>
			<view class="item">
				<view class="label">投诉原因</view>
				<view class="value">{{complaintTypeText}}</view>
			</view>
			<view class="item">
				<view class="label">投诉时间</view>
				<view class="value">{{complaint.createTime}}</view>
			</view>
		</view>
	</view>
</template>

<script>
export default {
	data() {
		return {
			complaint: []
		}
	},
	methods: {
		loadComplaintInfo(id) {
			this.$http({
				url: '/complaint/info?id=' + id,
				method: 'GET'
			}).then((data) => {
				this.complaint = data;
			})
		},
		onShowFullImage(url) {
			uni.previewImage({
				urls: [url]
			})
		}
	},
	computed: {
		reslovedTypeText() {
			const dict = this.$dict.RESOLVED_TYPE;
			return this.$dict.covertToName(dict, this.complaint.resolvedType, '')
		},
		complaintTypeText() {
			const dict = this.$dict.COMPLAINT_TYPE;
			return this.$dict.covertToName(dict, this.complaint.type, '')
		}
	},
	onLoad(options) {
		this.loadComplaintInfo(options.id)
	}
}
</script>

<style lang="scss">
.complaint-info {


	.card-info {
		padding: 20rpx;
		margin: 20rpx;
		background: white;
		border-radius: 20rpx;

		.card-title {
			margin: 20rpx 0;
			font-weight: bold;
		}

		.step {
			margin-bottom: 20rpx;

			.step-header {
				display: flex;
				align-items: center;

				&.active {
					color: $im-color-primary;
				}

				.title {
					flex: 1;
					font-size: $im-font-size;
					font-weight: bold;
				}

				.time {
					font-size: $im-font-size-small;
					color: $im-text-color-light;
				}
			}

			.content {
				background: $im-bg;
				margin: 5rpx 0;
				padding: 10rpx;
				border-radius: 10rpx;
				color: $im-text-color-lighter;
				font-size: $im-font-size-small;
			}

			.images {
				display: flex;
				flex-wrap: wrap;
						
				.image {
					margin-right: 5rpx;
					width: 150rpx;
					height: 150rpx;
					border-radius: 10rpx;
					background: $im-bg;
				}
			}
		}
		
		.item {
			display: flex;
			font-size: $im-font-size-small;
			margin-top: 10rpx;
			padding: 5rpx;
			
			.value {
				flex: 1;
				margin-left: 10rpx;
				text-align: right;
				color: $im-text-color-light;
				word-break: break-all;
			}
		}
	}
}
</style>