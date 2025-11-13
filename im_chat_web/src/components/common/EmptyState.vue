<template>
	<div class="empty-state">
		<div class="empty-icon">
			<i v-if="icon" :class="icon"></i>
			<span v-else class="default-icon">📭</span>
		</div>
		<div class="empty-text">
			<div class="empty-title">{{ title }}</div>
			<div v-if="description" class="empty-description">{{ description }}</div>
		</div>
		<div v-if="$slots.action" class="empty-action">
			<slot name="action"></slot>
		</div>
	</div>
</template>

<script>
export default {
	name: "EmptyState",
	props: {
		title: {
			type: String,
			default: "暂无数据"
		},
		description: {
			type: String,
			default: ""
		},
		icon: {
			type: String,
			default: ""
		}
	}
}
</script>

<style scoped lang="scss">
.empty-state {
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	padding: 60px 20px;
	text-align: center;
	color: #909399;

	.empty-icon {
		margin-bottom: 20px;

		i {
			font-size: 64px;
			color: #DCDFE6;
		}

		.default-icon {
			font-size: 64px;
			filter: grayscale(1);
			opacity: 0.5;
		}
	}

	.empty-text {
		margin-bottom: 20px;

		.empty-title {
			font-size: 16px;
			color: #606266;
			margin-bottom: 8px;
			font-weight: 500;
		}

		.empty-description {
			font-size: 14px;
			color: #909399;
			line-height: 1.5;
		}
	}

	.empty-action {
		margin-top: 10px;

		::v-deep .el-button {
			min-width: 120px;
		}
	}
}
</style>
