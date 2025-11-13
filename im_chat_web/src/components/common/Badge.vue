<template>
	<span class="custom-badge" :class="[`badge-${type}`, { 'is-dot': isDot }]">
		<slot></slot>
		<span v-if="!isDot && value" class="badge-content">{{ displayValue }}</span>
		<span v-if="isDot" class="badge-dot"></span>
	</span>
</template>

<script>
export default {
	name: "Badge",
	props: {
		value: {
			type: [String, Number],
			default: ""
		},
		max: {
			type: Number,
			default: 99
		},
		isDot: {
			type: Boolean,
			default: false
		},
		type: {
			type: String,
			default: "danger",
			validator: (value) => {
				return ["primary", "success", "warning", "danger", "info"].includes(value);
			}
		}
	},
	computed: {
		displayValue() {
			if (typeof this.value === "number" && typeof this.max === "number") {
				return this.value > this.max ? `${this.max}+` : this.value;
			}
			return this.value;
		}
	}
}
</script>

<style scoped lang="scss">
.custom-badge {
	position: relative;
	display: inline-flex;
	align-items: center;
	justify-content: center;

	.badge-content,
	.badge-dot {
		position: absolute;
		top: 0;
		right: 0;
		transform: translate(50%, -50%);
		border-radius: 10px;
		padding: 0 6px;
		height: 18px;
		line-height: 18px;
		font-size: 12px;
		color: white;
		white-space: nowrap;
		text-align: center;
		border: 2px solid white;
		box-shadow: 0 0 4px rgba(0, 0, 0, 0.2);
	}

	.badge-dot {
		width: 8px;
		height: 8px;
		border-radius: 50%;
		padding: 0;
	}

	&.badge-primary {
		.badge-content,
		.badge-dot {
			background-color: #409EFF;
		}
	}

	&.badge-success {
		.badge-content,
		.badge-dot {
			background-color: #67C23A;
		}
	}

	&.badge-warning {
		.badge-content,
		.badge-dot {
			background-color: #E6A23C;
		}
	}

	&.badge-danger {
		.badge-content,
		.badge-dot {
			background-color: #F56C6C;
		}
	}

	&.badge-info {
		.badge-content,
		.badge-dot {
			background-color: #909399;
		}
	}

	&.is-dot {
		.badge-dot {
			animation: pulse 2s infinite;
		}
	}
}

@keyframes pulse {
	0%,
	100% {
		box-shadow: 0 0 0 0 rgba(245, 108, 108, 0.7);
	}
	50% {
		box-shadow: 0 0 0 6px rgba(245, 108, 108, 0);
	}
}
</style>
