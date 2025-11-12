<template>
	<div class="chat-message-item" :class="active ? 'active' : ''">
		<div class="message-tip" v-if="msgInfo.type == $enums.MESSAGE_TYPE.TIP_TEXT">
			{{ msgInfo.content }}
		</div>
		<div class="message-tip" v-else-if="msgInfo.type == $enums.MESSAGE_TYPE.TIP_TIME">
			{{ $date.toTimeText(msgInfo.sendTime) }}
		</div>
		<div class="message-normal " v-else-if="isNormal" :class="{ 'message-mine': mine }">
			<div class="avatar">
				<head-image :name="showName" :size="38" :url="headImage" :id="msgInfo.sendId"></head-image>
			</div>
			<div class="content">
				<div v-if="msgInfo.groupId && !msgInfo.selfSend" class="top">
					<div>{{ showName }}</div>
					<el-tag v-if="isGroupOwner(msgInfo.sendId)" class="tag" size="mini" type="danger">群主</el-tag>
					<el-tag v-if="isGroupManager(msgInfo.sendId)" class="tag" size="mini" type="primary">管理员</el-tag>
				</div>
				<div class="bottom" :class="{ fullscreen: configStore.fullScreen }"
					@contextmenu.prevent="showMessageMenu($event)">
					<div ref="chatMsgBox">
						<span class="message-text" v-if="msgInfo.type == $enums.MESSAGE_TYPE.TEXT"
							v-html="htmlText"></span>
						<div class="message-image" v-if="msgInfo.type == $enums.MESSAGE_TYPE.IMAGE">
							<div v-loading="loading" element-loading-text="上传中.."
								element-loading-background="rgba(0, 0, 0, 0.4)">
								<img class="send-image" :class="{ fullscreen: configStore.fullScreen }"
									:src="contentData.thumbUrl" @click="showFullImageBox()" loading="lazy" />
							</div>
							<span title="发送失败" v-show="loadFail" @click="onSendFail"
								class="send-fail el-icon-warning"></span>
						</div>
						<div class="message-video" v-if="msgInfo.type == $enums.MESSAGE_TYPE.VIDEO">
							<video class="send-video" :class="{ fullscreen: configStore.fullScreen }" controls
								preload="none" :poster="contentData.coverUrl" :src="contentData.videoUrl" />
							<span title="发送失败" v-show="loadFail" @click="onSendFail"
								class="send-fail el-icon-warning"></span>
						</div>
						<div class="message-file" v-if="msgInfo.type == $enums.MESSAGE_TYPE.FILE">
							<div class="file-box" v-loading="loading">
								<div class="file-info">
									<el-link class="file-name" :underline="true" target="_blank" type="primary"
										:href="contentData.url" :download="contentData.name">{{ contentData.name
										}}</el-link>
									<div class="file-size">{{ fileSize }}</div>
								</div>
								<div class="file-icon">
									<span type="primary" class="el-icon-document"></span>
								</div>
							</div>
							<span title="发送失败" v-show="loadFail" @click="onSendFail"
								class="send-fail el-icon-warning"></span>
						</div>
					</div>
					<div class="message-voice" v-if="msgInfo.type == $enums.MESSAGE_TYPE.AUDIO" @click="onPlayVoice()">
						<audio controls :src="contentData.url"></audio>
					</div>
					<chat-user-card v-if="msgInfo.type == $enums.MESSAGE_TYPE.USER_CARD"
						:cardInfo="contentData"></chat-user-card>
					<chat-group-card v-if="msgInfo.type == $enums.MESSAGE_TYPE.GROUP_CARD"
						:cardInfo="contentData"></chat-group-card>
					<div class="red-package-message" v-if="msgInfo.type == $enums.MESSAGE_TYPE.RED_PACKAGE" @click="onRedPackageClick">
						<div class="red-package-content">
							<div class="red-package-icon">🧧</div>
							<div class="red-package-text">
								<div class="red-package-title">恭喜发财，大吉大利</div>
								<div class="red-package-desc">点击领取红包</div>
							</div>
						</div>
					</div>
					<div class="chat-action message-text" v-if="isAction">
						<span v-if="msgInfo.type == $enums.MESSAGE_TYPE.ACT_RT_VOICE" title="重新呼叫"
							@click="$emit('call')" class="iconfont icon-chat-voice"></span>
						<span v-if="msgInfo.type == $enums.MESSAGE_TYPE.ACT_RT_VIDEO" title="重新呼叫"
							@click="$emit('call')" class="iconfont icon-chat-video"></span>
						<span>{{ msgInfo.content }}</span>
					</div>
					<div class="quote-message" v-if="msgInfo.quoteMessage"
						@contextmenu.prevent.stop="showQuoteMenu($event)">
						<chat-quote-message :msgInfo="msgInfo.quoteMessage"
							@click.native.stop="$emit('locateQuote', msgInfo)"
							:showName="quoteShowName"></chat-quote-message>
					</div>
					<div class="message-status" v-if="!isAction">
						<span class="chat-readed" v-show="msgInfo.selfSend && !msgInfo.groupId
							&& msgInfo.status == $enums.MESSAGE_STATUS.READED">已读</span>
						<span class="chat-unread" v-show="msgInfo.selfSend && !msgInfo.groupId
							&& msgInfo.status != $enums.MESSAGE_STATUS.READED">未读</span>
					</div>
					<div class="chat-receipt" v-if="msgInfo.receipt" @click="onShowReadedBox">
						<span v-if="msgInfo.receiptOk" class="icon iconfont icon-ok" title="全体已读"></span>
						<span v-else>{{ msgInfo.readedCount }}人已读</span>
					</div>
				</div>
			</div>
		</div>
		<right-menu ref="rightMenu" @select="onSelectMenu"></right-menu>
		<chat-group-readed ref="chatGroupReadedBox" :msgInfo="msgInfo" :group="group"
			:groupMembers="groupMembers"></chat-group-readed>
		
		<!-- 微信风格红包弹窗 -->
		<wechat-red-package-popup 
			ref="redPackagePopup"
			:red-package-id="redPackageId"
			:sender-name="senderName"
			:sender-avatar="senderAvatar"
			@receive="onReceiveRedPackage"
		></wechat-red-package-popup>
	</div>
</template>

<script>
import HeadImage from "../common/HeadImage.vue";
import RightMenu from '../common/RightMenu.vue';
import ChatGroupReaded from './ChatGroupReaded.vue';
import ChatQuoteMessage from "./ChatQuoteMessage.vue";
import ChatUserCard from "./ChatUserCard.vue";
import ChatGroupCard from "./ChatGroupCard.vue";
import WechatRedPackagePopup from "./WechatRedPackagePopup.vue";
export default {
	name: "messageItem",
	components: {
		HeadImage,
		RightMenu,
		ChatGroupReaded,
		ChatQuoteMessage,
		ChatUserCard,
		ChatGroupCard,
		WechatRedPackagePopup
	},
	props: {
		mode: {
			type: Number,
			default: 1
		},
		active: {
			type: Boolean,
			default: false
		},
		mine: {
			type: Boolean,
			required: true
		},
		headImage: {
			type: String,
			default: ''
		},
		showName: {
			type: String,
			required: true
		},
		quoteShowName: {
			type: String,
			default: ''
		},
		msgInfo: {
			type: Object,
			required: true
		},
		group: {
			type: Object,
		},
		groupMembers: {
			type: Array
		}
	},
	data() {
		return {}
	},
	methods: {
		onSendFail() {
			this.$message.error("该文件已发送失败，目前不支持自动重新发送，建议手动重新发送")
		},
		showFullImageBox() {
			let imageUrl = this.contentData.originUrl;
			if (imageUrl) {
				this.$eventBus.$emit("openFullImage", imageUrl);
			}
		},
		onPlayVoice() {
			if (!this.audio) {
				this.audio = new Audio();
			}
			this.audio.src = this.contentData.url;
			this.audio.play();
			this.onPlayVoice = 'RUNNING';
		},
		showMessageMenu(e) {
			let menuItems = [];
			menuItems.push({
				key: 'DELETE',
				name: '删除'
			});
			if (this.msgInfo.id) {
				if (this.msgInfo.selfSend) {
					menuItems.push({
						key: 'RECALL',
						name: '撤回',
					});
				}
				if (this.$msgType.isNormal(this.msgInfo.type)) {
					menuItems.push({
						key: 'QUOTE',
						name: '引用'
					});
					menuItems.push({
						key: 'FORWARD',
						name: '转发'
					});
				}
				if ((this.isOwner || this.isManager) && this.$msgType.isNormal(this.msgInfo.type)) {
					menuItems.push({
						key: 'TOP',
						name: '置顶'
					});
				}
			}
			this.$refs.rightMenu.open(e, menuItems);
		},
		showQuoteMenu(e) {
			let menuItems = [];
			if (this.msgInfo.quoteMessage &&
				this.msgInfo.quoteMessage.status != this.$enums.MESSAGE_STATUS.RECALL) {
				menuItems.push({
					key: 'LOCATE_QUOTE',
					name: '定位到原消息'
				});
			}
			this.$refs.rightMenu.open(e, menuItems);
		},
		onSelectMenu(item) {
			// 菜单id转驼峰作为事件key
			let eventKey = item.key.toLowerCase().replace(/_([a-z])/g, (g) => g[1].toUpperCase());
			this.$emit(eventKey, this.msgInfo);
		},
		onShowReadedBox() {
			let rect = this.$refs.chatMsgBox.getBoundingClientRect();
			this.$refs.chatGroupReadedBox.open(rect);
		},
		isGroupOwner(userId) {
			return this.group.ownerId == userId;
		},
		isGroupManager(userId) {
			let m = this.groupMembers.find(m => m.userId == userId);
			return m && m.isManager
		},
		onRedPackageClick() {
			// 打开微信风格的红包弹窗
			this.$refs.redPackagePopup.open();
		},
		onReceiveRedPackage(redPackageId) {
			// 触发领取红包事件
			this.$emit('grabRedPackage', redPackageId);
		}
	},
	computed: {
		loading() {
			return this.msgInfo.loadStatus && this.msgInfo.loadStatus === "loading";
		},
		loadFail() {
			return this.msgInfo.loadStatus && this.msgInfo.loadStatus === "fail";
		},
		contentData() {
			return JSON.parse(this.msgInfo.content)
		},
		fileSize() {
			let size = this.contentData.size;
			if (size > 1024 * 1024) {
				return Math.round(size / 1024 / 1024) + "M";
			}
			if (size > 1024) {
				return Math.round(size / 1024) + "KB";
			}
			return size + "B";
		},
		isAction() {
			return this.$msgType.isAction(this.msgInfo.type);
		},
		isNormal() {
			const type = this.msgInfo.type;
			return this.$msgType.isNormal(type) || this.$msgType.isAction(type)
		},
		isOwner() {
			let userId = this.userStore.userInfo.id;
			return this.group && userId == this.group.ownerId
		},
		isManager() {
			let userId = this.userStore.userInfo.id;
			let m = this.groupMembers.find((m) => m.userId == userId);
			return m && m.isManager;
		},
		htmlText() {
			let color = this.msgInfo.selfSend ? 'white' : '';
			let text = this.$url.replaceURLWithHTMLLinks(this.msgInfo.content, color)
			return this.$emo.transform(text, 'emoji-normal')
		},
		redPackageData() {
			if (this.msgInfo.type !== this.$enums.MESSAGE_TYPE.RED_PACKAGE) {
				return {};
			}
			// 对于红包消息，content字段直接是红包ID，不需要JSON解析
			// 这里返回默认的红包显示数据
			return {
				id: this.msgInfo.content,
				title: '恭喜发财，大吉大利',
				amount: '随机金额',
				status: null // null表示可以领取，'received'表示已领取，'expired'表示已过期
			};
		},
		redPackageId() {
			// 直接使用content作为红包ID
			return this.msgInfo.content || '';
		},
		senderName() {
			// 获取发送者昵称，如果是自己发的显示"我"
			return this.msgInfo.selfSend ? '我' : (this.showName || '群友');
		},
		senderAvatar() {
			// 获取发送者头像
			return this.headImage || '/static/default-avatar.png';
		}
	}
}
</script>

<style lang="scss">
.chat-message-item {
	padding: 2px 10px;
	border-radius: 10px;

	&.active {
		background: #E1EAF7;
	}

	.message-tip {
		line-height: 50px;
		font-size: var(--im-font-size-small);
		color: var(--im-text-color-light);
		word-break: break-all;
	}

	.message-normal {
		position: relative;
		font-size: 0;
		padding-left: 53px;
		min-height: 50px;
		margin: 5px 0;

		.avatar {
			position: absolute;
			width: 40px;
			height: 40px;
			top: 0;
			left: 0;
		}

		.content {
			text-align: left;

			.send-fail {
				color: #e60c0c;
				font-size: 30px;
				cursor: pointer;
				margin: 0 20px;
			}

			.top {
				display: flex;
				flex-wrap: nowrap;
				color: #888;
				font-size: var(--im-font-size);
				line-height: 20px;
				align-items: center;

				.tag {
					margin: 0 5px;
					padding: 0 5px;
					font-size: 10px;
					border: 0;
					border-radius: 3px;
				}
			}

			.bottom {
				display: inline-block;
				padding-right: 30px;
				margin-top: 2px;

				&.fullscreen {
					padding-right: 240px;
				}

				.message-text {
					display: inline-block;
					position: relative;
					line-height: 26px;
					padding: 6px 10px;
					background: var(--im-background);
					border-radius: 10px;
					font-size: var(--im-font-size);
					text-align: left;
					white-space: pre-wrap;
					word-break: break-all;

					&:after {
						content: "";
						position: absolute;
						left: -10px;
						top: 13px;
						width: 0;
						height: 0;
						border-style: solid dashed dashed;
						border-color: #eee transparent transparent;
						overflow: hidden;
						border-width: 10px;
					}
				}

				.message-image {
					display: flex;
					flex-wrap: nowrap;
					flex-direction: row;
					align-items: center;

					.send-image {
						min-width: 100px;
						max-width: 250px;
						border-radius: 8px;
						cursor: pointer;

						&.fullscreen {
							max-width: 400px;
						}
					}
				}
				
				.message-video {
					display: flex;
					flex-wrap: nowrap;
					flex-direction: row;
					align-items: center;

					.send-video {
						min-width: 150px;
						max-width: 250px;
						max-height: 250px;
						border-radius: 10px;
						overflow: hidden;
						cursor: pointer;
						object-fit: contain;

						&.fullscreen {
							max-width: 400px;
							max-height: 400px;
						}
					}
				}


				.message-file {
					display: flex;
					flex-wrap: nowrap;
					flex-direction: row;
					align-items: center;
					cursor: pointer;
					margin-bottom: 2px;

					.file-box {
						display: flex;
						flex-wrap: nowrap;
						align-items: center;
						min-height: 60px;
						box-shadow: var(--im-box-shadow-light);
						border-radius: 4px;
						padding: 10px 15px;

						.file-info {
							flex: 1;
							height: 100%;
							text-align: left;
							font-size: 14px;
							margin-right: 10px;

							.file-name {
								display: inline-block;
								min-width: 160px;
								max-width: 200px;
								font-size: 14px;
								margin-bottom: 4px;
								white-space: pre-wrap;
								word-break: break-all;
							}

							.file-size {
								font-size: var(--im-font-size-smaller);
								color: var(--im-text-color-light);
							}
						}

						.file-icon {
							font-size: 44px;
							color: #d42e07;
						}
					}

					.send-fail {
						color: #e60c0c;
						font-size: 30px;
						cursor: pointer;
						margin: 0 20px;
					}
				}

				.message-voice audio {
					height: 45px;
					cursor: pointer;
				}

				.chat-action {
					display: flex;
					align-items: center;

					.iconfont {
						cursor: pointer;
						font-size: 22px;
						padding-right: 8px;
					}
				}

				.quote-message {
					display: block;
					margin-top: 3px;
					cursor: pointer;
				}

				.message-status {
					display: block;

					.chat-readed {
						font-size: 12px;
						color: var(--im-text-color-light);
					}

					.chat-unread {
						font-size: var(--im-font-size-smaller);
						color: var(--im-color-danger);
					}
				}

				.chat-receipt {
					font-size: var(--im-font-size-smaller);
					cursor: pointer;
					color: var(--im-text-color-light);

					.icon-ok {
						font-size: 20px;
						color: var(--im-color-sucess);
					}
				}

				.chat-at-user {
					padding: 2px 5px;
					border-radius: 3px;
					cursor: pointer;
				}
			}
		}

		&.message-mine {
			text-align: right;
			padding-left: 0;
			padding-right: 53px;

			.avatar {
				left: auto;
				right: 0;
			}

			.content {
				text-align: right;

				.top {
					flex-direction: row-reverse;
				}

				.bottom {
					padding-left: 30px;
					padding-right: 0;

					&.fullscreen {
						padding-left: 240px;
					}

					.message-text {
						margin-left: 10px;
						background-color: var(--im-color-primary-light-2);
						color: #fff;

						&:after {
							left: auto;
							right: -10px;
							border-top-color: var(--im-color-primary-light-2);
						}
					}

					.message-image {
						flex-direction: row-reverse;
					}

					.message-video {
						flex-direction: row-reverse;
					}

					.message-file {
						flex-direction: row-reverse;
					}

					.chat-action {
						flex-direction: row-reverse;

						.iconfont {
							transform: rotateY(180deg);
						}
					}
				}
			}
		}
	}

	// 红包消息样式
	.red-package-message {
		background: linear-gradient(135deg, #ff6b6b, #ee5a24);
		border-radius: 8px;
		padding: 12px;
		margin: 8px 0;
		color: white;
		cursor: pointer;
		transition: all 0.3s ease;
		max-width: 200px;
		box-shadow: 0 2px 8px rgba(238, 90, 36, 0.3);

		&:hover {
			transform: translateY(-2px);
			box-shadow: 0 4px 12px rgba(238, 90, 36, 0.4);
		}

		.red-package-content {
			display: flex;
			align-items: center;
			gap: 10px;

			.red-package-icon {
				font-size: 24px;
				line-height: 1;
			}

			.red-package-text {
					flex: 1;

					.red-package-title {
						font-size: 14px;
						font-weight: 500;
						margin-bottom: 4px;
					}

					.red-package-desc {
						font-size: 12px;
						opacity: 0.9;
					}
				}
			}

		&.received, &.expired {
			background: linear-gradient(135deg, #95a5a6, #7f8c8d);
			cursor: not-allowed;

			&:hover {
				transform: none;
				box-shadow: 0 2px 8px rgba(127, 140, 141, 0.3);
			}
		}
	}
}
</style>