<template>
	<div class="loading-spinner" :class="{ 'fullscreen': fullscreen }">
		<div class="spinner-container">
			<div class="spinner">
				<div class="double-bounce1"></div>
				<div class="double-bounce2"></div>
			</div>
			<div v-if="text" class="loading-text">{{ text }}</div>
		</div>
	</div>
</template>

<script>
export default {
	name: "LoadingSpinner",
	props: {
		text: {
			type: String,
			default: "加载中..."
		},
		fullscreen: {
			type: Boolean,
			default: false
		}
	}
}
</script>

<style scoped lang="scss">
.loading-spinner {
	display: flex;
	justify-content: center;
	align-items: center;
	padding: 20px;

	&.fullscreen {
		position: fixed;
		top: 0;
		left: 0;
		right: 0;
		bottom: 0;
		background: rgba(255, 255, 255, 0.9);
		z-index: 9999;
	}

	.spinner-container {
		display: flex;
		flex-direction: column;
		align-items: center;
		gap: 15px;
	}

	.spinner {
		width: 50px;
		height: 50px;
		position: relative;
	}

	.double-bounce1,
	.double-bounce2 {
		width: 100%;
		height: 100%;
		border-radius: 50%;
		background-color: #409EFF;
		opacity: 0.6;
		position: absolute;
		top: 0;
		left: 0;
		animation: bounce 2s infinite ease-in-out;
	}

	.double-bounce2 {
		animation-delay: -1s;
	}

	.loading-text {
		font-size: 14px;
		color: #606266;
		animation: fadeInOut 1.5s infinite;
	}
}

@keyframes bounce {
	0%,
	100% {
		transform: scale(0);
	}
	50% {
		transform: scale(1);
	}
}

@keyframes fadeInOut {
	0%,
	100% {
		opacity: 0.5;
	}
	50% {
		opacity: 1;
	}
}
</style>
