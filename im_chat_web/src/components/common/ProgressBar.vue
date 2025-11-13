<template>
	<div class="progress-bar" :class="{ 'show-text': showText }">
		<div class="progress-outer" :style="{ height: height }">
			<div class="progress-inner" :style="progressStyle">
				<div v-if="showText && textInside" class="progress-text-inside">{{ percentage }}%</div>
			</div>
		</div>
		<div v-if="showText && !textInside" class="progress-text">{{ percentage }}%</div>
	</div>
</template>

<script>
export default {
	name: "ProgressBar",
	props: {
		percentage: {
			type: Number,
			default: 0,
			validator: (val) => val >= 0 && val <= 100
		},
		type: {
			type: String,
			default: "primary",
			validator: (val) => ["primary", "success", "warning", "danger", "info"].includes(val)
		},
		height: {
			type: String,
			default: "8px"
		},
		showText: {
			type: Boolean,
			default: true
		},
		textInside: {
			type: Boolean,
			default: false
		},
		striped: {
			type: Boolean,
			default: false
		},
		animated: {
			type: Boolean,
			default: false
		}
	},
	computed: {
		progressStyle() {
			const colors = {
				primary: "#409EFF",
				success: "#67C23A",
				warning: "#E6A23C",
				danger: "#F56C6C",
				info: "#909399"
			};

			let style = {
				width: `${this.percentage}%`,
				backgroundColor: colors[this.type],
				transition: "width 0.3s ease"
			};

			if (this.striped) {
				style.backgroundImage = `linear-gradient(45deg, 
					rgba(255, 255, 255, 0.15) 25%, 
					transparent 25%, 
					transparent 50%, 
					rgba(255, 255, 255, 0.15) 50%, 
					rgba(255, 255, 255, 0.15) 75%, 
					transparent 75%, 
					transparent)`;
				style.backgroundSize = "1rem 1rem";
			}

			if (this.animated) {
				style.animation = "progress-stripes 1s linear infinite";
			}

			return style;
		}
	}
}
</script>

<style scoped lang="scss">
.progress-bar {
	display: flex;
	align-items: center;
	gap: 10px;

	.progress-outer {
		flex: 1;
		background-color: #EBEEF5;
		border-radius: 100px;
		overflow: hidden;
		position: relative;
	}

	.progress-inner {
		height: 100%;
		border-radius: 100px;
		position: relative;
		display: flex;
		align-items: center;
		justify-content: center;
	}

	.progress-text-inside {
		color: white;
		font-size: 12px;
		font-weight: 500;
		margin: 0 5px;
		white-space: nowrap;
	}

	.progress-text {
		font-size: 14px;
		color: #606266;
		font-weight: 500;
		min-width: 40px;
		text-align: right;
	}

	&.show-text {
		.progress-outer {
			margin-right: 0;
		}
	}
}

@keyframes progress-stripes {
	0% {
		background-position: 1rem 0;
	}
	100% {
		background-position: 0 0;
	}
}
</style>
