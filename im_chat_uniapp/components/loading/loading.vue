<template>
	<view class="loading-box" :style="loadingStyle">
		<view v-if="showIcon" class="rotate iconfont icon-loading" :style="icontStyle"></view>
		<slot></slot>
	</view>
</template>

<script>
import {
	computed
} from "vue"
export default {
	data() {
		return {}
	},
	props: {
		showIcon:{
			type: Boolean,
			default: true
		},
		size: {
			type: Number,
			default: 100
		},
		mask: {
			type: Boolean,
			default: true
		}
	},
	computed: {
		icontStyle() {
			return `font-size:${this.size}rpx`;
		},
		loadingStyle() {
			return this.mask ? "background: rgba(0, 0, 0, 0.6);" : "";
		}
	}
}
</script>

<style lang="scss" scoped>
.loading-box {
	width: 100%;
	height: 100%;
	position: absolute;
	left: 0;
	top: 0;
	z-index: 999;
	display: flex;
	justify-content: center;
	align-items: center;
}

.rotate {
	animation: rotate 2s ease-in-out infinite;

}

@keyframes rotate {
	from {
		transform: rotate(0deg)
	}

	to {
		transform: rotate(360deg)
	}
}
</style>