<template>
	<view class="page complaint none-pointer-events ">
		<nav-bar title="投诉" back></nav-bar>
		<view v-if="!isSubmit" class="form">
			<view class="form-item">
				<view class="label">投诉对象</view>
				<view class="value">{{formData.targetName}}</view>
			</view>
			<view class="form-item" @click="showDictMenu()">
				<view class="label">投诉原因</view>
				<view class="value">{{complaintTypeText}}</view>
				<uni-icons type="right" size="16"></uni-icons>
			</view>
			<view class="form-item top-label">
				<view class="image-label-wrap">
					<view class="label">图片证据(选填)</view>
					<view class="value">{{images.length}}/{{maxUploadSize}}</view>
				</view>
				<view class="images">
					<view v-for="(img,idx) in images" :key="idx">
						<view class="image-wrap" @longpress.prevent.stop="showImageMenu(idx)"
							@click.stop="onShowFullImage(img.originUrl)">
							<image class="image" mode="aspectFill" :src="img.thumbUrl" lazy-load="true">
							</image>
							<loading v-if="img.status!='ok'" :show-icon="img.status == 'uploading'">
								<view class="fail-tip" v-if="img.status == 'fail'">上传失败</view>
							</loading>
						</view>
					</view>
					<image-upload v-if="uploadSize>0" :maxCount="uploadSize" sourceType="album"
						:onBefore="onUploadBefore" :onSuccess="onUploadSuccess" :onError="onUploadFail">
						<view class="upload-image">
							<uni-icons class="icon" type="plusempty" color="#888888" size="40"></uni-icons>
						</view>
					</image-upload>
				</view>
			</view>
			<view class="form-item">
				<uni-easyinput placeholder="请填写投诉内容" class="content" type="textarea" v-model="formData.content"
					maxlength="512" />
			</view>
			<button type="primary" class="bottom-btn" @click="submit()">提交</button>
		</view>
		<view v-else class="submit-tip">
			<view class="tip-wrap">
				<view class="icon iconfont icon-success"></view>
				<view class="title">感谢您的反馈，我们将尽快处理</view>
				<view class="tip">我们将在3个工作日内审核并反馈结果,感谢你监督与反馈
				</view>
			</view>
			<arrow-bar title="我的投诉" @tap="onShowHistory">
				<view class="history">查看历史记录</view>
			</arrow-bar>
			<button type="primary" class="bottom-btn" @click="onComplete()">完成</button>
		</view>
		<popup-menu ref="dictMenu" :items="dictItems" @select="onSelectDictItem"></popup-menu>
		<popup-menu ref="imageMenu" :items="imageItems" @select="onSelectImageItem"></popup-menu>
	</view>
</template>

<script>
export default {
	data() {
		return {
			maxImageId: 1,
			isSubmit: false,
			maxUploadSize: 9,
			targetName: '',
			menuImageIdx: -1, // 菜单选中的图片下标
			images: [], //上传的图片 
			formData: {}
		}
	},
	methods: {
		submit() {
			if (!this.formData.type) {
				uni.showToast({
					title: '请选择投诉原因',
					icon: 'none'
				})
				return;
			}
			if (!this.formData.content) {
				uni.showToast({
					title: '请填写投诉内容',
					icon: 'none'
				})
				return;
			}
			if (this.images.some(m => m.status == 'uploading')) {
				uni.showToast({
					title: '请等待图片上传完成',
					icon: 'none'
				})
				return;
			}
			this.formData.images = this.images.filter(m => m.status == 'ok');
			this.$http({
				url: '/complaint/initiate',
				method: 'post',
				data: this.formData
			}).then(() => {
				this.isSubmit = true;
			})
		},
		showDictMenu() {
			this.$refs.dictMenu.open();
		},
		onSelectDictItem(item) {
			this.formData.type = item.val;
		},
		showImageMenu(idx) {
			this.menuImageIdx = idx;
			this.$refs.imageMenu.open();
		},
		onSelectImageItem(item) {
			if (item.key == 'DELETE') {
				this.images.splice(this.menuImageIdx, 1);
			}
		},
		onUploadBefore(file) {
			let id = this.maxImageId++;
			const img = {
				id: id,
				originUrl: file.path,
				thumbUrl: file.path,
				status: 'uploading'
			}
			// 记录图片id
			file.id = id;
			this.images.push(img);
			return true;
		},
		onUploadSuccess(file, res) {
			let image = this.findImage(file.id);
			if(image){
				image.originUrl = res.data.originUrl;
				image.thumbUrl = res.data.thumbUrl;
				image.status = 'ok';
			}
		},
		onUploadFail(file) {
			let image = this.findImage(file.id);
			if(image){
				image.status = 'fail';
			}
		},
		onShowHistory() {
			uni.navigateTo({
				url: "/pages/complaint/complaint-history"
			})
		},
		onShowFullImage(url) {
			uni.previewImage({
				urls: [url]
			})
		},
		onComplete() {
			uni.navigateBack();
		},
		findImage(id) {
			return this.images.find(m => m.id == id);
		}
	},
	computed: {
		complaintTypeText() {
			const dict = this.$dict.COMPLAINT_TYPE;
			return this.$dict.covertToName(dict, this.formData.type, '请选择')
		},
		dictItems() {
			return this.$dict.COMPLAINT_TYPE;
		},
		imageItems() {
			return [{
				key: 'DELETE',
				name: '删除'
			}]
		},
		uploadSize() {
			return this.maxUploadSize - this.images.length
		}
	},
	onLoad(options) {
		this.formData.targetName = options.name;
		this.formData.targetType = options.type;
		this.formData.targetId = options.id
	}
}
</script>

<style lang="scss" scoped>
.complaint {
	.form {
		.form-item {
			padding: 0 40rpx;
			display: flex;
			background: white;
			align-items: center;
			margin-bottom: 2rpx;

			&.top-label {
				flex-direction: column;
				align-items: start;
			}

			.label {
				width: 220rpx;
				line-height: 100rpx;
				font-size: $im-font-size;
				white-space: nowrap;
			}

			.value {
				flex: 1;
				text-align: right;
				color: $im-text-color-lighter;
			}

			.image-label-wrap {
				display: flex;
				align-items: center;
				width: 100%;
			}

			.images {
				display: flex;
				flex-wrap: wrap;
				margin-bottom: 10rpx;

				.image-wrap {
					position: relative;
					width: 210rpx;
					height: 210rpx;
					border-radius: 10rpx;
					margin: 5rpx;

					.image {
						width: 210rpx;
						height: 210rpx;
					}

					.fail-tip {
						color: white;
						font-size: $im-font-size-small;
					}
				}


				.upload-image {
					margin: 5rpx;
					width: 210rpx;
					height: 210rpx;
					border-radius: 10rpx;
					background: $im-bg;
					display: flex;
					align-items: center;
					justify-content: center;
					font-size: 100rpx;
				}
			}

			.content {
				margin-top: 20rpx;
				font-size: 30rpx;
			}
		}
	}

	.submit-tip {

		.tip-wrap {
			display: flex;
			align-items: center;
			flex-direction: column;
			padding: 30rpx;
			background: white;

			.icon {
				font-size: 80rpx;
				color: $im-color-success;
				padding: 40rpx;
			}

			.title {
				font-size: $im-font-size;
				font-weight: bold;
				padding: 10rpx;
			}

			.tip {
				padding: 10rpx;
				font-size: $im-font-size-small;
				color: $im-text-color-lighter;
			}
		}

		.history {
			font-size: $im-font-size-small;
			color: $im-text-color-lighter;
		}


	}
}
</style>