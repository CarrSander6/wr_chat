<template>
	<el-tooltip 
		:content="content" 
		:placement="placement" 
		:effect="effect"
		:disabled="disabled"
		:open-delay="openDelay"
		:class="['enhanced-tooltip', customClass]"
	>
		<slot></slot>
	</el-tooltip>
</template>

<script>
export default {
	name: "EnhancedTooltip",
	props: {
		content: {
			type: String,
			required: true
		},
		placement: {
			type: String,
			default: "top"
		},
		effect: {
			type: String,
			default: "dark"
		},
		disabled: {
			type: Boolean,
			default: false
		},
		openDelay: {
			type: Number,
			default: 200
		},
		customClass: {
			type: String,
			default: ""
		}
	}
}
</script>

<style scoped lang="scss">
.enhanced-tooltip {
	::v-deep .el-tooltip__popper {
		max-width: 300px;
		font-size: 13px;
		padding: 8px 12px;
		border-radius: 6px;
		box-shadow: 0 2px 12px rgba(0, 0, 0, 0.15);
	}
}
</style>
