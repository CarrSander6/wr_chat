<template>
	<div class="head-image" @click="showUserInfo($event)" :style="{ cursor: isShowUserInfo ? 'pointer' : null }">
		<img class="avatar-image" v-show="url" :src="url" :style="avatarImageStyle" loading="lazy" />
		<div class="avatar-text" v-show="!url" :style="avatarTextStyle">
			{{ name?.substring(0, 2).toUpperCase() }}</div>
		<div v-show="online" class="online" title="用户当前在线"></div>
		<slot></slot>
	</div>
</template>

<script>
export default {
	name: "headImage",
	data() {
		return {
			colors: ["#5daa31", "#c7515a", "#e03697", "#85029b",
				"#c9b455", "#326eb6"]
		}
	},
	props: {
		id: {
			type: Number
		},
		size: {
			type: Number,
			default: 42
		},
		width: {
			type: Number
		},
		height: {
			type: Number
		},
		radius: {
			type: String,
			default: "50%"
		},
		url: {
			type: String
		},
		name: {
			type: String,
			default: null
		},
		online: {
			type: Boolean,
			default: false
		},
		isShowUserInfo: {
			type: Boolean,
			default: true
		}
	},
	methods: {
		showUserInfo(e) {
			if (!this.isShowUserInfo) return;
			if (this.id && this.id > 0) {
				this.$http({
					url: `/user/find/${this.id}`,
					method: 'get'
				}).then((user) => {
					let pos = {
						x: e.x + 30,
						y: e.y
					}
					this.$eventBus.$emit("openUserInfo", user, pos);
				})
			}
		}
	},
	computed: {
		avatarImageStyle() {
			let w = this.width ? this.width : this.size;
			let h = this.height ? this.height : this.size;
			return `width:${w}px; height:${h}px;
					border-radius: ${this.radius};`
		},
		avatarTextStyle() {
			let w = this.width ? this.width : this.size;
			let h = this.height ? this.height : this.size;
			return `
				  width: ${w}px;height:${h}px;
					background-color: ${this.name ? this.textColor : '#fff'};
					font-size:${w * 0.35}px;
					border-radius: ${this.radius};
					`
		},
		textColor() {
			let hash = 0;
			for (var i = 0; i < this.name.length; i++) {
				hash += this.name.charCodeAt(i);
			}
			return this.colors[hash % this.colors.length];
		}
	}
}
</script>

<style scoped lang="scss">
.head-image {
	position: relative;
	transition: transform 0.2s ease;

	&:hover {
		transform: scale(1.05);
	}

	.avatar-image {
		position: relative;
		overflow: hidden;
		display: block;
		transition: all 0.2s ease;
		box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);

		&:hover {
			box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
		}
	}

	.avatar-text {
		color: white;
		display: flex;
		align-items: center;
		justify-content: center;
		font-weight: 500;
		transition: all 0.2s ease;
		box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);

		&:hover {
			box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
		}
	}

	.online {
		position: absolute;
		right: -5px;
		bottom: 0;
		width: 12px;
		height: 12px;
		background: limegreen;
		border-radius: 50%;
		border: 2px solid white;
		animation: pulse 2s infinite;
	}
}

@keyframes pulse {
	0%, 100% {
		box-shadow: 0 0 0 0 rgba(50, 205, 50, 0.7);
	}
	50% {
		box-shadow: 0 0 0 4px rgba(50, 205, 50, 0);
	}
}
</style>
