<template>
  <view class="page chat-box" id="chatBox">
    <nav-bar :title="title" back more @more="onShowMore"></nav-bar>
    <view class="chat-main-box" :style="{ height: chatMainHeight + 'px' }">
      <view v-if="chat.type == 'GROUP' && group.topMessage">
        <chat-top-message :group="group" :groupMembers="groupMembers" :msgInfo="group.topMessage"
          :headImage="headImage(group.topMessage)" :showName="showName(group.topMessage)" @locate="locateMessage">
        </chat-top-message>
      </view>
      <view class="chat-msg" @click="switchChatTabBox('none')" @touchstart="onTouchChat">
        <scroll-view class="scroll-box" scroll-y="true" :upper-threshold="upperThreshold" @scrolltoupper="onScrollToTop"
          @scrolltolower="onScrollToBottom" @scroll="onScroll" :scroll-into-view="'chat-item-' + scrollMsgIdx"
          :scroll-top="scrollTop">
          <view v-if="chat" class="chat-wrap">
            <view v-if="chat" v-for="(msgInfo, idx) in showMessages" :key="showMinIdx + idx">
              <chat-message-item :ref="'message' + msgInfo.id" :active="showMinIdx + idx == activeMessageIdx"
                :headImage="headImage(msgInfo)" @call="onRtCall(msgInfo)" :showName="showName(msgInfo)"
                :quoteShowName="showName(msgInfo.quoteMessage)" :group="group" @recall="onRecallMessage"
                @delete="onDeleteMessage" @copy="onCopyMessage" @quote="onQuoteMessage"
                @locateQuote="onLocateQuoteMessage" @forward="onForwardMessage"
                @longPressHead="onLongPressHead(msgInfo)" @download="onDownloadFile"
                @audioStateChange="onAudioStateChange" @top="onTopMessage" @claimSuccess="onRedPackageClaimSuccess"
                @claimAlreadyTaken="onRedPackageClaimAlreadyTaken" @updateBalance="onUpdateBalance"
                :id="'chat-item-' + (showMinIdx + idx)" :msgInfo="msgInfo" :groupMembers="groupMembers">
              </chat-message-item>
            </view>
          </view>
        </scroll-view>
        <view v-if="!isInBottom" class="scroll-to-bottom" @click="onClickToBottom">
          {{ newMessageSize > 0 ? newMessageSize + '条新消息' : '回到底部' }}
        </view>
      </view>
      <view v-if="atUserIds.length > 0" class="chat-at-bar" @click="openAtBox()">
        <view class="iconfont icon-at">&nbsp;</view>
        <scroll-view v-if="atUserIds.length > 0" class="chat-at-scroll-box" scroll-x="true" scroll-left="120">
          <view class="chat-at-items">
            <view v-for="m in atUserItems" class="chat-at-item" :key="m.userId">
              <head-image :name="m.showNickName" :url="m.headImage" size="minier"></head-image>
            </view>
          </view>
        </scroll-view>
      </view>
      <view class="send-bar">
        <view v-if="!showRecord" class="iconfont icon-voice-circle" @click="onRecorderInput()"></view>
        <view v-else class="iconfont icon-keyboard" @click="onKeyboardInput()"></view>
        <chat-record v-if="showRecord" class="chat-record" @send="onSendRecord"></chat-record>
        <view v-else class="send-text">
          <editor id="editor" class="send-text-area" :placeholder="isReceipt ? '[回执消息]' : ''" :read-only="isReadOnly"
            @focus="onEditorFocus" @blur="onEditorBlur" @ready="onEditorReady" :adjust-position="false"
            @input="onTextInput">
          </editor>
          <!-- <textarea class="send-text-area" v-model="sendText" 
						auto-height :show-confirm-bar="false"
						:placeholder="isReceipt ? '[回执消息]' : ''" 
						:adjust-position="true" 
						@focus="onEditorFocus" 
						@blur="onEditorBlur"
						@confirm="sendTextMessage()"
						confirm-type="send" confirm-hold
						:hold-keyboard="true"></textarea> -->
          <view v-if="quoteMessage" class="quote-message">
            <view class="quote-text">{{ quoteMessageText }}</view>
            <uni-icons class="quote-remove" type="clear" size="20" color="#888"
              @click="onQuoteMessage(null)"></uni-icons>
          </view>
        </view>
        <view v-if="chat && chat.type == 'GROUP'" class="iconfont icon-at" @click="openAtBox()"></view>
        <view class="iconfont icon-icon_emoji" @click="onShowEmoChatTab()"></view>
        <view v-if="isEmpty" class="iconfont icon-add" @click="onShowToolsChatTab()">
        </view>
        <button v-if="!isEmpty || atUserIds.length" class="btn-send" type="primary"
          @touchend.prevent="sendTextMessage()" size="mini">发送</button>
      </view>
    </view>
    <view class="chat-tab-bar">
      <view v-if="chatTabBox == 'tools'" class="chat-tools" :style="{ height: keyboardHeight + 'px' }">
        <view class="chat-tools-item">
          <file-upload ref="fileUpload" :onBefore="onUploadFileBefore" :onSuccess="onUploadFileSuccess"
            :onError="onUploadFileFail">
            <view class="tool-icon iconfont icon-folder"></view>
          </file-upload>
          <view class="tool-name">文件</view>
        </view>
        <view class="chat-tools-item">
          <image-upload :maxCount="9" sourceType="album" :onBefore="onUploadImageBefore"
            :onSuccess="onUploadImageSuccess" :onError="onUploadImageFail">
            <view class="tool-icon iconfont icon-picture"></view>
          </image-upload>
          <view class="tool-name">相册</view>
        </view>
        <view class="chat-tools-item">
          <image-upload sourceType="camera" :onBefore="onUploadImageBefore" :onSuccess="onUploadImageSuccess"
            :onError="onUploadImageFail">
            <view class="tool-icon iconfont icon-camera"></view>
          </image-upload>
          <view class="tool-name">拍摄</view>
        </view>
        <view class="chat-tools-item">
          <video-upload :onBefore="onUploadVideoBefore" :onSuccess="onUploadVideoSuccess" :onError="onUploadVideoFail">
            <view class="tool-icon iconfont icon-film"></view>
          </video-upload>
          <view class="tool-name">视频</view>
        </view>
        <view class="chat-tools-item" @click="onRecorderInput()">
          <view class="tool-icon iconfont icon-microphone"></view>
          <view class="tool-name">语音消息</view>
        </view>
        <view v-if="chat.type == 'GROUP'" class="chat-tools-item" @click="onShowRedPackageSend()">
          <view class="tool-icon">🧧</view>
          <view class="tool-name">红包</view>
        </view>
        <view v-if="chat.type == 'GROUP'" class="chat-tools-item" @click="switchReceipt()">
          <view class="tool-icon iconfont icon-receipt" :class="isReceipt ? 'active' : ''"></view>
          <view class="tool-name">回执消息</view>
        </view>
        <!-- #ifndef MP-WEIXIN -->
        <!-- 音视频不支持小程序 -->
        <view v-if="chat.type == 'PRIVATE'" class="chat-tools-item" @click="onPriviteVideo()">
          <view class="tool-icon iconfont icon-video"></view>
          <view class="tool-name">视频通话</view>
        </view>
        <view v-if="chat.type == 'PRIVATE'" class="chat-tools-item" @click="onPriviteVoice()">
          <view class="tool-icon iconfont icon-call"></view>
          <view class="tool-name">语音通话</view>
        </view>
        <view v-if="chat.type == 'GROUP'" class="chat-tools-item" @click="onGroupVideo()">
          <view class="tool-icon iconfont icon-call"></view>
          <view class="tool-name">语音通话</view>
        </view>
        <!-- #endif -->
      </view>
      <scroll-view v-if="chatTabBox === 'emo'" class="chat-emotion" scroll-y="true"
        :style="{ height: keyboardHeight + 'px' }">
        <view class="emotion-item-list">
          <image class="emotion-item emoji-large" :title="emoText" :src="$emo.textToPath(emoText)"
            v-for="(emoText, i) in $emo.emoTextList" :key="i" @click="selectEmoji(emoText)" mode="aspectFit"
            lazy-load="true"></image>
        </view>
      </scroll-view>
    </view>
    <!-- @用户时选择成员 -->
    <chat-at-box ref="atBox" v-if="this.chat.type == 'GROUP'" :ownerId="group.ownerId" :members="groupMembers"
      @complete="onAtComplete"></chat-at-box>
    <!-- 转发消息是选择最近联系人 -->
    <chat-selector ref="chatSel" title="转发给"></chat-selector>
    <!-- 群语音通话时选择成员 -->
    <!-- #ifndef MP-WEIXIN -->
    <group-member-selector v-if="this.chat.type == 'GROUP'" ref="rtcSel" :members="groupMembers"
      :maxSize="configStore.webrtc.maxChannel" :group="group" @complete="onInviteOk"></group-member-selector>
    <group-rtc-join v-if="this.chat.type == 'GROUP'" ref="rtcJoin" :groupId="group.id"></group-rtc-join>
    <!-- #endif -->
    <!-- 红包发送弹窗 -->
    <red-package-send ref="redPackageSend" @send="onSendRedPackage"></red-package-send>
  </view>
</template>
<script>
import UNI_APP from '@/.env.js';
import RedPackageSend from '../../components/red-package-send/red-package-send.vue';
export default {
  components: {
    RedPackageSend
  },
  data () {
    return {
      chat: {},
      userInfo: {},
      groupId: null,
      groupMembers: [],
      isReceipt: false, // 是否回执消息
      scrollMsgIdx: 0, // 滚动条定位为到哪条消息
      chatTabBox: 'none',
      showRecord: false,
      chatMainHeight: 800, // 聊天窗口高度
      keyboardHeight: 290,
      windowHeight: 1000, // 窗口高度
      initHeight: 1000, // h5初始高度
      atUserIds: [],
      showMinIdx: 0, // 下标小于showMinIdx的消息不显示，否则可能很卡
      showMaxIdx: -1, // 下标大于showMaxIdx的消息不显示，否则可能很卡，-1表示不限制
      reqQueue: [], // 请求队列
      isSending: false, // 是否正在发送请求
      isShowKeyBoard: false, // 键盘是否正在弹起 
      editorCtx: null, // 编辑器上下文
      isEmpty: true, // 编辑器是否为空
      isFocus: false, // 编辑器是否焦点
      isReadOnly: false, // 编辑器是否只读
      playingAudio: null, // 当前正在播放的录音消息,
      quoteMessage: null, // 被引用的消息
      activeMessageIdx: -1, // 选中消息idx,
      isInBottom: true, // 滚动条是否在底部
      newMessageSize: 0, // 滚动条不在底部时新的消息数量
      scrollTop: 0, // 用于ios h5定位滚动条
      scrollViewHeight: 0, // 滚动条总长度
      isReceivingRedPackage: false // 防止重复领取红包
    }
  },
  methods: {
    async onRecorderInput () {
      if (!await this.$permission.micro()) {
        console.log("录音权限未获得")
        return;
      }
      this.showRecord = true;
      this.switchChatTabBox('none');
    },
    onKeyboardInput () {
      this.showRecord = false;
      this.switchChatTabBox('none');
    },
    onSendRecord (data) {
      // 检查是否被封禁
      if (this.isBanned) {
        this.showBannedTip();
        return;
      }
      let msgInfo = {
        content: JSON.stringify(data),
        type: this.$enums.MESSAGE_TYPE.AUDIO,
        receipt: this.isReceipt
      }
      // 填充对方id
      this.fillTargetId(msgInfo, this.chat.targetId);
      this.sendMessageRequest(msgInfo).then((m) => {
        m.selfSend = true;
        this.chatStore.insertMessage(m, this.chat);
        // 会话置顶
        this.moveChatToTop();
        // 滚动到底部
        this.scrollToBottom();
        this.isReceipt = false;
      })
    },
    onRtCall (msgInfo) {
      if (msgInfo.type == this.$enums.MESSAGE_TYPE.ACT_RT_VOICE) {
        this.onPriviteVoice();
      } else if (msgInfo.type == this.$enums.MESSAGE_TYPE.ACT_RT_VIDEO) {
        this.onPriviteVideo();
      }
    },
    onPriviteVideo () {
      if (!this.isFriend) {
        uni.showToast({
          title: "对方已不是您的好友，无法呼叫",
          icon: 'none'
        })
        return;
      }
      // 检查是否被封禁
      if (this.isBanned) {
        this.showBannedTip();
        return;
      }
      const friendInfo = encodeURIComponent(JSON.stringify(this.friend));
      uni.navigateTo({
        url: `/pages/chat/chat-private-video?mode=video&friend=${friendInfo}&isHost=true`
      })
    },
    onPriviteVoice () {
      if (!this.isFriend) {
        uni.showToast({
          title: "对方已不是您的好友，无法呼叫",
          icon: 'none'
        })
        return;
      }
      // 检查是否被封禁
      if (this.isBanned) {
        this.showBannedTip();
        return;
      }
      const friendInfo = encodeURIComponent(JSON.stringify(this.friend));
      uni.navigateTo({
        url: `/pages/chat/chat-private-video?mode=voice&friend=${friendInfo}&isHost=true`
      })
    },
    onGroupVideo () {
      // 检查是否被封禁
      if (this.isBanned) {
        this.showBannedTip();
        return;
      }
      this.$http({
        url: "/webrtc/group/info?groupId=" + this.group.id,
        method: 'GET'
      }).then((rtcInfo) => {
        if (rtcInfo.isChating) {
          // 已在通话中，可以直接加入通话
          this.$refs.rtcJoin.open(rtcInfo);
        } else {
          // 邀请成员发起通话
          let ids = [this.mine.id];
          this.$refs.rtcSel.init(ids, ids, []);
          this.$refs.rtcSel.open();
        }
      })
    },
    onInviteOk (ids) {
      if (ids.length < 2) {
        return;
      }
      let users = [];
      ids.forEach(id => {
        let m = this.groupMembers.find(m => m.userId == id);
        // 只取部分字段,压缩url长度
        users.push({
          id: m.userId,
          nickName: m.showNickName,
          headImage: m.headImage,
          isCamera: false,
          isMicroPhone: true
        })
      })
      const groupId = this.group.id;
      const inviterId = this.mine.id;
      const userInfos = encodeURIComponent(JSON.stringify(users));
      uni.navigateTo({
        url: `/pages/chat/chat-group-video?groupId=${groupId}&isHost=true
						&inviterId=${inviterId}&userInfos=${userInfos}`
      })
    },
    moveChatToTop () {
      let chatIdx = this.chatStore.findChatIdx(this.chat);
      this.chatStore.moveTop(chatIdx);
    },
    switchReceipt () {
      this.isReceipt = !this.isReceipt;
    },
    openAtBox () {
      this.$refs.atBox.init(this.atUserIds);
      this.$refs.atBox.open();
    },
    onAtComplete (atUserIds) {
      this.atUserIds = atUserIds;
    },
    onLongPressHead (msgInfo) {
      if (!msgInfo.selfSend && this.chat.type == "GROUP" && this.atUserIds.indexOf(msgInfo.sendId) < 0) {
        this.atUserIds.push(msgInfo.sendId);
      }
    },
    onTouchChat () {
      this.activeMessageIdx = -1;
      this.lockScrollEvent = false;
    },
    // 显示红包发送弹窗
    onShowRedPackageSend () {
      // 检查是否被封禁
      if (this.isBanned) {
        this.showBannedTip();
        return;
      }
      this.$refs.redPackageSend.open();
    },
    // 处理红包发送
    async onSendRedPackage (redPackageData) {
      try {
        // 调用红包发送API
        const response = await this.$http({
          url: '/redPackage/handout',
          method: 'POST',
          data: {
            total: redPackageData.total,
            amount: redPackageData.amount,
            tradePassword: redPackageData.tradePassword
          }
        });
        // 输出response
        console.log('调用红包发送API response', response);
        if (response) {
          // 立即调用消息发送接口，消息类型为300，内容包含红包ID
          // 分析response，提取红包ID
          let redId = response;
          // 构建标准红包消息格式
          let redPackageContent = {
            id: redId, // 保留原始红包ID
            rob: false, // false表示用户未领取，true表示已领取
            userId: this.mine.id // 红包发送者的用户ID
          };
          let msgInfo = {
            content: JSON.stringify(redPackageContent), // 使用标准格式的JSON字符串
            type: 300, // 消息类型设置为300
            receipt: false
          };
          // 填充对方id
          this.fillTargetId(msgInfo, this.chat.targetId);
          // 发送消息
          const message = await this.sendMessageRequest(msgInfo);
          message.selfSend = true;
          this.chatStore.insertMessage(message, this.chat);
          // 会话置顶
          this.moveChatToTop();
          // 滚动到底部
          this.scrollToBottom();
          uni.showToast({
            title: '红包发送成功',
            icon: 'success'
          });
        }
      } catch (error) {
        console.error('发送红包失败:', error);
        uni.showToast({
          title: error.message || '发送红包失败，请重试',
          icon: 'none'
        });
      }
    },
    // 处理红包领取成功事件
    onRedPackageClaimSuccess (eventData) {
      try {
        const { redPackageId, amount, msgInfo } = eventData;

        // 更新用户余额
        this.onUpdateBalance(amount);

        // 更新消息状态为已领取
        this.updateRedPackageStatus(redPackageId, true);

        console.log('红包领取成功，金额:', amount);
      } catch (error) {
        console.error('处理红包领取成功事件失败:', error);
      }
    },

    // 处理红包已领取事件
    onRedPackageClaimAlreadyTaken (eventData) {
      try {
        const { redPackageId, msgInfo } = eventData;

        // 更新消息状态为已领取
        this.updateRedPackageStatus(redPackageId, true);

        console.log('红包已被领取:', redPackageId);
      } catch (error) {
        console.error('处理红包已领取事件失败:', error);
      }
    },


    // 更新用户余额
    onUpdateBalance (amount) {
      // 更新用户余额信息
      if (this.userStore && this.userStore.userInfo) {
        this.userStore.userInfo.balance = (parseFloat(this.userStore.userInfo.balance || 0) + parseFloat(
          amount)).toFixed(4);
      }
    },
    // 更新红包消息状态
    updateRedPackageStatus (redId, robStatus) {
      try {
        // 查找对应的红包消息
        const message = this.chat.messages.find(msg => {
          if (msg.type === 300) { // 红包消息类型
            try {
              const content = JSON.parse(msg.content);
              return content.id === redId;
            } catch (error) {
              // 兼容旧格式
              return msg.content === redId;
            }
          }
          return false;
        });
        if (message) {
          // 解析并更新消息内容
          let content;
          try {
            content = JSON.parse(message.content);
          } catch (error) {
            // 兼容旧格式，转换为新格式
            content = {
              id: message.content,
              rob: false,
              userId: message.sendId
            };
          }
          // 更新rob状态
          content.rob = robStatus;
          // 更新消息内容
          message.content = JSON.stringify(content);
          // 同步更新chatStore中的消息缓存
          this.chatStore.updateMessage(message, this.chat);
        }
      } catch (error) {
        console.error('更新红包状态失败:', error);
      }
    },
    setLockScrollEvent (duration) {
      this.lockScrollEvent = true;
      setTimeout(() => this.lockScrollEvent = false, duration)
    },
    headImage (msgInfo) {
      if (this.chat.type == 'GROUP') {
        let member = this.groupMembers.find((m) => m.userId == msgInfo.sendId);
        return member ? member.headImage : "";
      } else {
        return msgInfo.selfSend ? this.mine.headImageThumb : this.chat.headImage
      }
    },
    showName (msgInfo) {
      if (!msgInfo) {
        return "";
      }
      if (this.chat.type == 'GROUP') {
        let member = this.groupMembers.find((m) => m.userId == msgInfo.sendId);
        return member ? member.showNickName : "";
      } else {
        return msgInfo.selfSend ? this.mine.nickName : this.chat.showName
      }
    },
    sendTextMessage () {
      this.editorCtx.getContents({
        success: (e) => {
          // 清空编辑框数据
          this.editorCtx.clear();
          // 检查是否被封禁
          if (this.isBanned) {
            this.showBannedTip();
            return;
          }
          let sendText = "";
          e.delta.ops.forEach((op) => {
            if (op.insert.image) {
              // emo表情
              sendText += `#${op.attributes.alt};`
            } else {
              // 文字，处理换行符
              let text = op.insert;
              // 将编辑器中的换行符正确处理
              if (typeof text === 'string') {
                sendText += text;
              }
            }
          })
          if (!sendText.trim() && this.atUserIds.length == 0) {
            return uni.showToast({
              title: "不能发送空白信息",
              icon: "none"
            });
          }
          let receiptText = this.isReceipt ? "[回执消息] " : "";
          let atText = this.createAtText();
          let msgInfo = {
            content: receiptText + this.html2Escape(sendText) + atText,
            atUserIds: this.atUserIds,
            receipt: this.isReceipt,
            type: 0
          }
          if (this.quoteMessage) {
            msgInfo.quoteMessageId = this.quoteMessage.id;
          }
          // 清空@成员列表、回执标记、引用消息
          this.atUserIds = [];
          this.isReceipt = false;
          this.quoteMessage = null;
          // 填充对方id
          this.fillTargetId(msgInfo, this.chat.targetId);
          this.sendMessageRequest(msgInfo).then((m) => {
            m.selfSend = true;
            this.chatStore.insertMessage(m, this.chat);
            // 会话置顶
            this.moveChatToTop();
          }).finally(() => {
            // 滚动到底部
            this.scrollToBottom();
          });
        }
      })
    },
    createAtText () {
      let atText = "";
      this.atUserIds.forEach((id) => {
        if (id == -1) {
          atText += ` @全体成员`;
        } else {
          let member = this.groupMembers.find((m) => m.userId == id);
          if (member) {
            atText += ` @${member.showNickName}`;
          }
        }
      })
      return atText;
    },
    fillTargetId (msgInfo, targetId) {
      if (this.chat.type == "GROUP") {
        msgInfo.groupId = targetId;
      } else {
        msgInfo.recvId = targetId;
      }
    },
    scrollToBottom () {
      // 复位消息窗口,保证最后一条消息是可见的
      this.resetShowMessages();
      let size = this.messageSize;
      if (size > 0) {
        this.scrollToMsgIdx(size - 1);
      }
    },
    scrollToMsgIdx (idx) {
      // 如果scrollMsgIdx值没变化，滚动条不会移动
      if (idx == this.scrollMsgIdx && idx > 0) {
        this.$nextTick(() => {
          // 先滚动到上一条
          this.scrollMsgIdx = idx - 1;
          // 再滚动目标位置
          this.scrollToMsgIdx(idx);
        });
        return;
      }
      this.$nextTick(() => {
        this.scrollMsgIdx = idx;
      });
    },
    onShowEmoChatTab () {
      this.showRecord = false;
      this.switchChatTabBox('emo')
    },
    onShowToolsChatTab () {
      this.showRecord = false;
      this.switchChatTabBox('tools')
    },
    switchChatTabBox (chatTabBox) {
      this.chatTabBox = chatTabBox;
      if (chatTabBox != 'tools' && this.$refs.fileUpload) {
        this.$refs.fileUpload.hide()
      }
      setTimeout(() => this.reCalChatMainHeight(), 30);
    },
    selectEmoji (emoText) {
      let path = this.$emo.textToPath(emoText)
      // 先把键盘禁用了，否则会重新弹出键盘
      this.isReadOnly = true;
      this.isEmpty = false;
      this.$nextTick(() => {
        this.editorCtx.insertImage({
          src: path,
          alt: emoText,
          extClass: 'emoji-small',
          nowrap: true,
          complete: () => {
            this.isReadOnly = false;
            this.editorCtx.blur();
          }
        });
      })
    },
    onUploadImageBefore (file) {
      // 检查是否被封禁
      if (this.isBanned) {
        this.showBannedTip();
        return;
      }
      let data = {
        originUrl: file.path,
        thumbUrl: file.path
      }
      let msgInfo = {
        id: 0,
        tmpId: this.generateId(),
        fileId: file.uid,
        sendId: this.mine.id,
        content: JSON.stringify(data),
        sendTime: new Date().getTime(),
        selfSend: true,
        type: this.$enums.MESSAGE_TYPE.IMAGE,
        readedCount: 0,
        loadStatus: "loading",
        status: this.$enums.MESSAGE_STATUS.UNSEND
      }
      // 填充对方id
      this.fillTargetId(msgInfo, this.chat.targetId);
      // 插入消息
      this.chatStore.insertMessage(msgInfo, this.chat);
      // 会话置顶
      this.moveChatToTop();
      // 借助file对象保存
      file.msgInfo = msgInfo;
      file.chat = this.chat;
      // 滚到最低部
      this.scrollToBottom();
      return true;
    },
    onUploadImageSuccess (file, res) {
      let msgInfo = JSON.parse(JSON.stringify(file.msgInfo));
      msgInfo.content = JSON.stringify(res.data);
      msgInfo.receipt = this.isReceipt
      this.sendMessageRequest(msgInfo).then((m) => {
        msgInfo.loadStatus = 'ok';
        msgInfo.id = m.id;
        this.isReceipt = false;
        this.chatStore.insertMessage(msgInfo, file.chat);
      })
    },
    onUploadImageFail (file, err) {
      let msgInfo = JSON.parse(JSON.stringify(file.msgInfo));
      msgInfo.loadStatus = 'fail';
      this.chatStore.insertMessage(msgInfo, file.chat);
    },
    onUploadVideoBefore (file) {
      // 检查是否被封禁
      if (this.isBanned) {
        this.showBannedTip();
        return;
      }
      let data = {
        videoUrl: file.tempFilePath,
        coverUrl: ""
      }
      let msgInfo = {
        id: 0,
        tmpId: this.generateId(),
        fileId: file.uid,
        sendId: this.mine.id,
        content: JSON.stringify(data),
        sendTime: new Date().getTime(),
        selfSend: true,
        type: this.$enums.MESSAGE_TYPE.VIDEO,
        readedCount: 0,
        loadStatus: "loading",
        status: this.$enums.MESSAGE_STATUS.UNSEND
      }
      // 填充对方id
      this.fillTargetId(msgInfo, this.chat.targetId);
      // 插入消息
      this.chatStore.insertMessage(msgInfo, this.chat);
      // 会话置顶
      this.moveChatToTop();
      // 借助file对象保存
      file.msgInfo = msgInfo;
      file.chat = this.chat;
      // 滚到最低部
      this.scrollToBottom();
      return true;
    },
    onUploadVideoSuccess (file, res) {
      let msgInfo = JSON.parse(JSON.stringify(file.msgInfo));
      msgInfo.content = JSON.stringify(res.data);
      msgInfo.receipt = this.isReceipt
      this.sendMessageRequest(msgInfo).then((m) => {
        msgInfo.loadStatus = 'ok';
        msgInfo.id = m.id;
        this.isReceipt = false;
        this.chatStore.insertMessage(msgInfo, file.chat);
      })
    },
    onUploadVideoFail (file, err) {
      let msgInfo = JSON.parse(JSON.stringify(file.msgInfo));
      msgInfo.loadStatus = 'fail';
      this.chatStore.insertMessage(msgInfo, file.chat);
    },
    onUploadFileBefore (file) {
      // 检查是否被封禁
      if (this.isBanned) {
        this.showBannedTip();
        return;
      }
      let data = {
        name: file.name,
        size: file.size,
        url: file.path
      }
      let msgInfo = {
        id: 0,
        tmpId: this.generateId(),
        sendId: this.mine.id,
        content: JSON.stringify(data),
        sendTime: new Date().getTime(),
        selfSend: true,
        type: this.$enums.MESSAGE_TYPE.FILE,
        readedCount: 0,
        loadStatus: "loading",
        status: this.$enums.MESSAGE_STATUS.UNSEND
      }
      // 填充对方id
      this.fillTargetId(msgInfo, this.chat.targetId);
      // 插入消息
      this.chatStore.insertMessage(msgInfo, this.chat);
      // 会话置顶
      this.moveChatToTop();
      // 借助file对象保存
      file.msgInfo = msgInfo;
      file.chat = this.chat;
      // 滚到最低部
      this.scrollToBottom();
      return true;
    },
    onUploadFileSuccess (file, res) {
      let data = {
        name: file.name,
        size: file.size,
        url: res.data
      }
      let msgInfo = JSON.parse(JSON.stringify(file.msgInfo));
      msgInfo.content = JSON.stringify(data);
      msgInfo.receipt = this.isReceipt
      this.sendMessageRequest(msgInfo).then((m) => {
        msgInfo.loadStatus = 'ok';
        msgInfo.id = m.id;
        this.isReceipt = false;
        this.chatStore.insertMessage(msgInfo, file.chat);
      })
    },
    onUploadFileFail (file, res) {
      let msgInfo = JSON.parse(JSON.stringify(file.msgInfo));
      msgInfo.loadStatus = 'fail';
      this.chatStore.insertMessage(msgInfo, file.chat);
    },
    onDeleteMessage (msgInfo) {
      uni.showModal({
        title: '删除消息',
        content: '确认删除消息?',
        success: (res) => {
          if (!res.cancel) {
            this.chatStore.deleteMessage(msgInfo, this.chat);
            uni.showToast({
              title: "删除成功",
              icon: "none"
            })
          }
        }
      })
    },
    onRecallMessage (msgInfo) {
      uni.showModal({
        title: '撤回消息',
        content: '确认撤回消息?',
        success: (res) => {
          if (!res.cancel) {
            let url = `/message/${this.chat.type.toLowerCase()}/recall/${msgInfo.id}`
            this.$http({
              url: url,
              method: 'DELETE'
            }).then((m) => {
              m.selfSend = true;
              this.chatStore.recallMessage(m, this.chat);
            })
          }
        }
      })
    },
    onQuoteMessage (msgInfo) {
      this.quoteMessage = msgInfo;
      this.onKeyboardInput();
    },
    onTopMessage (msgInfo) {
      if (!msgInfo.id) {
        uni.showToast({
          title: "请等待该消息发送成功后操作",
          icon: 'none'
        })
        return;
      }
      this.$http({
        url: `/group/setTopMessage/${msgInfo.groupId}?messageId=${msgInfo.id}`,
        method: 'POST'
      }).then(() => { })
    },
    onCopyMessage (msgInfo) {
      uni.setClipboardData({
        data: msgInfo.content,
        success: () => {
          uni.showToast({
            title: '复制成功'
          });
        },
        fail: () => {
          uni.showToast({
            title: '复制失败',
            icon: 'none'
          });
        }
      });
    },
    onForwardMessage (msgInfo) {
      this.$refs.chatSel.open(chats => {
        // 逐个会话发送消息
        let idx = 0;
        chats.forEach(chat => {
          let message = {
            content: msgInfo.content,
            type: msgInfo.type
          }
          if (chat.type == 'GROUP') {
            message.groupId = chat.targetId
          } else {
            message.recvId = chat.targetId;
          }
          this.$http({
            url: `/message/${chat.type.toLowerCase()}/send`,
            method: 'POST',
            data: message
          }).then((m) => {
            m.selfSend = true;
            this.chatStore.openChat(chat);
            this.chatStore.insertMessage(m, chat);
            if (++idx == chats.length) {
              uni.showToast({
                title: "转发成功",
                icon: 'none'
              })
            }
          })
        })
      })
    },
    onLocateQuoteMessage (msgInfo) {
      this.locateMessage(msgInfo.quoteMessage);
    },
    locateMessage (msgInfo) {
      // 寻找消息位置
      const idx = this.findMessageIdx(msgInfo);
      if (idx < 0) {
        uni.showToast({
          title: "无法定位原消息",
          icon: 'none'
        })
        return;
      }
      // 要定位到消息，首先要显示这条消息
      this.showMinIdx = Math.min(idx - 5, this.messageSize - 20)
      this.showMinIdx = Math.max(this.showMinIdx, 0);
      this.showMaxIdx = this.showMinIdx + 20;
      // 底部标志
      this.isInBottom = this.showMaxIdx >= this.messageSize;
      // 滚动至引用消息，-2是将引用消息定位到第3行
      this.scrollToMsgIdx(Math.max(this.showMinIdx, idx));
      // 高亮消息2秒,提醒用户
      this.activeMessageIdx = idx;
      // 锁定滚动事件,避免干扰
      this.lockScrollEvent = true;
      // 2s后自动恢复正常
      setTimeout(() => {
        this.activeMessageIdx = -1;
        this.lockScrollEvent = false;
      }, 2000)
    },
    findMessageIdx (msgInfo) {
      for (let idx in this.chat.messages) {
        const message = this.chat.messages[idx];
        // 通过id判断
        if (msgInfo.id && message.id && message.id == msgInfo.id) {
          return idx;
        }
        // 正在发送中的消息可能没有id,只有tmpId
        if (msgInfo.tmpId && message.tmpId && message.tmpId == msgInfo.tmpId) {
          return idx;
        }
      }
      return -1;
    },
    onDownloadFile (msgInfo) {
      let url = JSON.parse(msgInfo.content).url;
      uni.downloadFile({
        url: url,
        success (res) {
          if (res.statusCode === 200) {
            var filePath = encodeURI(res.tempFilePath);
            uni.openDocument({
              filePath: filePath,
              showMenu: true
            });
          }
        },
        fail (e) {
          uni.showToast({
            title: "文件下载失败",
            icon: "none"
          })
        }
      });
    },
    onClickToBottom () {
      this.scrollToBottom();
      // 有些设备滚到底部时会莫名触发滚动到顶部的事件
      // 所以这里延迟100s保证能准确设置底部标志
      setTimeout(() => {
        this.isInBottom = true;
        this.newMessageSize = 0;
      }, 100)
    },
    onScroll (e) {
      console.log("this.scrollViewHeight:", this.scrollViewHeight)
      // 记录当前滚动条高度
      this.scrollViewHeight = e.detail.scrollHeight;
    },
    onScrollToTop (e) {
      if (this.lockScrollEvent) {
        return;
      }
      if (this.showMinIdx > 0) {
        //  #ifndef H5
        // 防止滚动条定格在顶部，不能一直往上滚(app采用scroll-top定位)
        this.scrollToMsgIdx(this.showMinIdx);
        // #endif
        // #ifdef H5
        // 防止滚动条定格在顶部，不能一直往上滚(h5采用scroll-top定位)
        this.holdingScrollBar(this.scrollViewHeight);
        // #endif
        // 多展示20条信息
        this.showMinIdx = this.showMinIdx > 20 ? this.showMinIdx - 20 : 0;
        // 锁定500ms,防止重复触发
        this.setLockScrollEvent(500)
      }
      // 清除底部标识
      this.isInBottom = false;
    },
    onScrollToBottom (e) {
      if (this.lockScrollEvent) {
        return;
      }
      if (this.showMaxIdx >= 0) {
        // 多展示20条信息
        this.showMaxIdx += 20;
        // 锁定500ms,防止重复触发
        this.setLockScrollEvent(500)
      }
      // 设置底部标识
      if (this.showMaxIdx < 0 || this.showMaxIdx >= this.messageSize) {
        this.isInBottom = true;
        this.newMessageSize = 0;
        this.resetShowMessages();
      }
    },
    holdingScrollBar (scrollViewHeight) {
      // 内容高度
      const query = uni.createSelectorQuery().in(this);
      setTimeout(() => {
        query.select('.chat-wrap').boundingClientRect();
        query.exec(data => {
          this.scrollTop = data[0].height - scrollViewHeight;
          if (this.scrollTop < 10) {
            // 未渲染完成，重试一次
            this.holdingScrollBar();
          }
        });
      }, 50)
    },
    onShowMore () {
      if (this.chat.type == "GROUP") {
        uni.navigateTo({
          url: "/pages/group/group-info?id=" + this.group.id
        })
      } else {
        uni.navigateTo({
          url: "/pages/common/user-info?id=" + this.userInfo.id
        })
      }
    },
    onTextInput (e) {
      this.isEmpty = e.detail.html == '<p><br></p>'
    },
    onEditorReady () {
      this.$nextTick(() => {
        const query = uni.createSelectorQuery().in(this);
        query.select('#editor').context((res) => {
          this.editorCtx = res.context
        }).exec()
      })
    },
    onEditorFocus (e) {
      this.isFocus = true;
      this.scrollToBottom()
      this.switchChatTabBox('none')
    },
    onEditorBlur (e) {
      this.isFocus = false;
    },
    onAudioStateChange (state, msgInfo) {
      const playingAudio = this.$refs['message' + msgInfo.id][0]
      if (state == 'PLAYING' && playingAudio != this.playingAudio) {
        // 停止之前的录音
        this.playingAudio && this.playingAudio.stopPlayAudio();
        // 记录当前正在播放的消息
        this.playingAudio = playingAudio;
      }
    },
    resetShowMessages () {
      // 初始状态仅渲染最后20条数据
      this.showMinIdx = this.messageSize > 20 ? this.messageSize - 20 : 0;
      this.showMaxIdx = -1;
    },
    loadReaded (fid) {
      this.$http({
        url: `/message/private/maxReadedId?friendId=${fid}`,
        method: 'get'
      }).then((id) => {
        this.chatStore.readedMessage({
          friendId: fid,
          maxId: id
        });
      });
    },
    readedMessage () {
      if (this.unreadCount == 0 && !this.chat.atMe) {
        return;
      }
      let url = ""
      if (this.chat.type == "GROUP") {
        url = `/message/group/readed?groupId=${this.chat.targetId}`
      } else {
        url = `/message/private/readed?friendId=${this.chat.targetId}`
      }
      this.$http({
        url: url,
        method: 'PUT'
      }).then(() => {
        this.chatStore.resetUnreadCount(this.chat)
      })
    },
    loadGroup (groupId) {
      this.groupId = groupId;
      this.$http({
        url: `/group/find/${groupId}`,
        method: 'GET'
      }).then((group) => {
        this.chatStore.updateChatFromGroup(group);
        this.groupStore.updateGroup(group);
      });
      this.$http({
        url: `/group/members/${groupId}`,
        method: 'GET'
      }).then((groupMembers) => {
        this.groupMembers = groupMembers;
      });
    },
    updateFriendInfo () {
      if (this.isFriend) {
        // store的数据不能直接修改，深拷贝一份store的数据
        let friend = JSON.parse(JSON.stringify(this.friend));
        friend.headImage = this.userInfo.headImageThumb;
        friend.nickName = this.userInfo.nickName;
        friend.showNickName = friend.remarkNickName ? friend.remarkNickName : friend.nickName;
        // 更新好友列表中的昵称和头像
        this.friendStore.updateFriend(friend);
        // 更新会话中的头像和昵称
        this.chatStore.updateChatFromFriend(friend);
      } else {
        this.chatStore.updateChatFromUser(this.userInfo);
      }
    },
    loadFriend (friendId) {
      // 获取好友用户信息
      this.$http({
        url: `/user/find/${friendId}`,
        method: 'GET'
      }).then((userInfo) => {
        this.userInfo = userInfo;
        this.updateFriendInfo();
      })
    },
    rpxTopx (rpx) {
      // rpx转换成rpx
      let info = uni.getSystemInfoSync()
      let px = info.windowWidth * rpx / 750;
      return Math.floor(rpx);
    },
    html2Escape (strHtml) {
      return strHtml.replace(/[<>&"]/g, function (c) {
        return {
          '<': '&lt;',
          '>': '&gt;',
          '&': '&amp;',
          '"': '&quot;'
        }[c];
      });
    },
    sendMessageRequest (msgInfo) {
      return new Promise((resolve, reject) => {
        // 请求入队列，防止请求"后发先至"，导致消息错序
        this.reqQueue.push({
          msgInfo,
          resolve,
          reject
        });
        this.processReqQueue();
      })
    },
    processReqQueue () {
      if (this.reqQueue.length && !this.isSending) {
        this.isSending = true;
        const reqData = this.reqQueue.shift();
        this.$http({
          url: this.messageAction,
          method: 'post',
          data: reqData.msgInfo
        }).then((res) => {
          reqData.resolve(res)
        }).catch((e) => {
          reqData.reject(e)
        }).finally(() => {
          this.isSending = false;
          // 发送下一条请求
          this.processReqQueue();
        })
      }
    },
    reCalChatMainHeight () {
      let h = this.windowHeight;
      // 减去标题栏高度
      h -= 50;
      // 减去键盘高度
      if (this.isShowKeyBoard || this.chatTabBox != 'none') {
        console.log("减去键盘高度:", this.keyboardHeight)
        h -= this.keyboardHeight;
        this.scrollToBottom();
      }
      // #ifndef H5
      // 非h5需要减去状态栏高度
      h -= uni.getSystemInfoSync().statusBarHeight;
      // #endif
      this.chatMainHeight = h;
      console.log("窗口高度:", this.chatMainHeight)
      if (this.isShowKeyBoard || this.chatTabBox != 'none') {
        this.scrollToBottom();
      }
      // ios浏览器键盘把页面顶起后，页面长度不会变化，这里把页面拉到顶部适配一下
      // #ifdef H5
      if (uni.getSystemInfoSync().platform == 'ios') {
        // 不同手机需要的延时时间不一致，采用分段延时的方式处理
        const delays = [50, 100, 500];
        delays.forEach((delay) => {
          setTimeout(() => {
            uni.pageScrollTo({
              scrollTop: 0,
              duration: 10
            });
          }, delay);
        })
      }
      // #endif
    },
    listenKeyBoard () {
      // #ifdef H5
      if (navigator.platform == "Win32") {
        // 电脑端不需要弹出键盘
        console.log("navigator.platform:", navigator.platform)
        return;
      }
      if (uni.getSystemInfoSync().platform == 'ios') {
        // ios h5实现键盘监听
        window.addEventListener('focusin', this.focusInListener);
        window.addEventListener('focusout', this.focusOutListener);
        // 监听键盘高度，ios13以上开始支持
        if (window.visualViewport) {
          window.visualViewport.addEventListener('resize', this.resizeListener);
        }
      } else {
        // 安卓h5实现键盘监听
        window.addEventListener('resize', this.resizeListener);
      }
      // #endif
      // #ifndef H5
      // app实现键盘监听
      uni.onKeyboardHeightChange(this.keyBoardListener);
      // #endif
    },
    unListenKeyboard () {
      // #ifdef H5
      window.removeEventListener('resize', this.resizeListener);
      window.removeEventListener('focusin', this.focusInListener);
      window.removeEventListener('focusout', this.focusOutListener);
      // #endif
      // #ifndef H5
      uni.offKeyboardHeightChange(this.keyBoardListener);
      // #endif
    },
    keyBoardListener (res) {
      this.isShowKeyBoard = res.height > 0;
      if (this.isShowKeyBoard) {
        this.keyboardHeight = res.height; // 获取并保存键盘高度
      }
      this.reCalChatMainHeight()
    },
    resizeListener () {
      console.log("resize:", window.innerHeight)
      let keyboardHeight = this.initHeight - window.innerHeight;
      // 兼容部分ios浏览器
      if (window.visualViewport && uni.getSystemInfoSync().platform == 'ios') {
        keyboardHeight = this.initHeight - window.visualViewport.height;
      }
      this.isShowKeyBoard = keyboardHeight > 150;
      if (this.isShowKeyBoard) {
        this.keyboardHeight = keyboardHeight;
      }
      setTimeout(() => this.reCalChatMainHeight(), 30);
    },
    focusInListener () {
      console.log("focusInListener")
      this.isShowKeyBoard = true;
      setTimeout(() => this.reCalChatMainHeight(), 30);
    },
    focusOutListener () {
      console.log("focusOutListener")
      this.isShowKeyBoard = false;
      setTimeout(() => this.reCalChatMainHeight(), 30);
    },
    showBannedTip () {
      let msgInfo = {
        tmpId: this.generateId(),
        sendId: this.mine.id,
        sendTime: new Date().getTime(),
        type: this.$enums.MESSAGE_TYPE.TIP_TEXT
      }
      if (this.chat.type == "PRIVATE") {
        msgInfo.recvId = this.mine.id
        msgInfo.content = "该用户已被管理员封禁,原因:" + this.userInfo.reason
      } else {
        msgInfo.groupId = this.group.id;
        msgInfo.content = "本群聊已被管理员封禁,原因:" + this.group.reason
      }
      this.chatStore.insertMessage(msgInfo, this.chat);
    },
    generateId () {
      // 生成临时id 
      return String(new Date().getTime()) + String(Math.floor(Math.random() * 1000));
    }
  },
  computed: {
    mine () {
      return this.userStore.userInfo;
    },
    isFriend () {
      return this.friendStore.isFriend(this.userInfo.id);
    },
    friend () {
      return this.friendStore.findFriend(this.userInfo.id);
    },
    group () {
      return this.groupStore.findGroup(this.groupId)
    },
    title () {
      if (!this.chat) {
        return "";
      }
      let title = this.chat.showName;
      if (this.chat.type == "GROUP") {
        let size = this.groupMembers.filter(m => !m.quit).length;
        title += `(${size})`;
      }
      return title;
    },
    messageAction () {
      return `/message/${this.chat.type.toLowerCase()}/send`;
    },
    messageSize () {
      if (!this.chat || !this.chat.messages) {
        return 0;
      }
      return this.chat.messages.length;
    },
    showMessages () {
      if (!this.chat.messages) {
        return [];
      }
      if (this.showMaxIdx > 0) {
        return this.chat.messages.slice(this.showMinIdx, this.showMaxIdx)
      } else {
        return this.chat.messages.slice(this.showMinIdx)
      }
    },
    unreadCount () {
      if (!this.chat || !this.chat.unreadCount) {
        return 0;
      }
      return this.chat.unreadCount;
    },
    isBanned () {
      return (this.chat.type == "PRIVATE" && this.userInfo.isBanned) || (this.chat.type == "GROUP" && this.group
        .isBanned)
    },
    isOwner () {
      this.group.ownerId == this.mine.id;
    },
    atUserItems () {
      let atUsers = [];
      this.atUserIds.forEach((id) => {
        if (id == -1) {
          atUsers.push({
            id: -1,
            showNickName: "全体成员"
          })
          return;
        }
        let member = this.groupMembers.find((m) => m.userId == id);
        if (member) {
          atUsers.push(member);
        }
      })
      return atUsers;
    },
    quoteMessageText () {
      if (!this.quoteMessage) return "";
      const showName = this.showName(this.quoteMessage);
      let content = this.quoteMessage.content;
      switch (this.quoteMessage.type) {
        case this.$enums.MESSAGE_TYPE.IMAGE:
          content = "[图片]";
          break;
        case this.$enums.MESSAGE_TYPE.VIDEO:
          content = "[视频]";
          break;
        case this.$enums.MESSAGE_TYPE.FILE:
          content = "[文件] " + JSON.parse(this.quoteMessage.content).name;
          break;
        case this.$enums.MESSAGE_TYPE.AUDIO:
          content = "[语音] " + JSON.parse(this.quoteMessage.content).duration + '"';
          break;
        case this.$enums.MESSAGE_TYPE.USER_CARD:
          content = "[个人名片] " + JSON.parse(this.quoteMessage.content).nickName;
          break;
        case this.$enums.MESSAGE_TYPE.GROUP_CARD:
          content = "[群名片] " + JSON.parse(this.quoteMessage.content).groupName;
          break;
      }
      return showName + ": " + content;
    },
    upperThreshold () {
      // #ifdef H5
      return 200;
      // #endif
      return 10;
    }
  },
  watch: {
    messageSize: function (newSize, oldSize) {
      // 接收到新消息
      if (newSize > oldSize && oldSize > 0) {
        let lastMessage = this.chat.messages[newSize - 1];
        if (this.$msgType.isNormal(lastMessage.type)) {
          if (this.isInBottom) {
            // 收到消息,则滚动至底部
            this.scrollToBottom();
          } else {
            // 若滚动条不在底部，说明用户正在翻历史消息，此时滚动条不能动，同时增加新消息提示
            this.newMessageSize++;
          }
        }
      }
    },
    unreadCount: {
      handler (newCount, oldCount) {
        if (newCount > 0) {
          // 消息已读
          this.readedMessage()
        }
      }
    }
  },
  onLoad (options) {
    // 聊天数据
    this.chat = this.chatStore.chats[options.chatIdx];
    // 初始状态只显示20条消息
    this.resetShowMessages();
    // 消息已读
    this.readedMessage()
    // 加载好友或群聊信息
    if (this.chat.type == "GROUP") {
      this.loadGroup(this.chat.targetId);
    } else {
      this.loadFriend(this.chat.targetId);
      this.loadReaded(this.chat.targetId)
    }
    // 激活当前会话
    this.chatStore.activeChat(options.chatIdx);
    // 复位回执消息
    this.isReceipt = false;
    // 清空引用消息
    this.quoteMessage = null;
    // 清空底部标志
    this.isInBottom = true;
    this.newMessageSize = 0;
    // 监听键盘高度
    this.listenKeyBoard();
    // 计算聊天窗口高度
    this.$nextTick(() => {
      // 没有键盘时的高度
      this.windowHeight = uni.getSystemInfoSync().windowHeight;
      this.reCalChatMainHeight();
      // 定位消息
      if (options.locateMessageIdx) {
        // 从消息记录页面定位过来
        this.locateMessage(this.chat.messages[options.locateMessageIdx]);
      } else {
        // 正常进入,消息拉到底部
        this.scrollToBottom();
      }
      // #ifdef H5
      this.initHeight = window.innerHeight;
      // 兼容ios的h5:禁止页面滚动
      const chatBox = document.getElementById('chatBox')
      chatBox.addEventListener('touchmove', e => {
        e.preventDefault()
      }, {
        passive: false
      });
      // #endif
    });
  },
  onUnload () {
    this.unListenKeyboard();
  }
}
</script>
<style lang="scss">
.chat-box {
  $icon-color: rgba(0, 0, 0, 0.88);
  position: relative;
  background-color: #fafafa;

  .chat-main-box {
    // #ifdef H5
    top: $im-nav-bar-height;
    // #endif
    // #ifndef H5
    top: calc($im-nav-bar-height + var(--status-bar-height));
    // #endif
    position: fixed;
    width: 100%;
    display: flex;
    flex-direction: column;
    z-index: 2;

    .chat-msg {
      flex: 1;
      padding: 0;
      overflow: hidden;
      position: relative;
      background-color: white;

      .scroll-box {
        height: 100%;
      }

      .scroll-to-bottom {
        position: absolute;
        right: 30rpx;
        bottom: 30rpx;
        font-size: $im-font-size;
        color: $im-color-primary;
        font-weight: 600;
        background: white;
        padding: 10rpx 30rpx;
        border-radius: 25rpx;
        box-shadow: $im-box-shadow-dark;
        opacity: 0.85;
      }
    }

    .chat-at-bar {
      display: flex;
      align-items: center;
      padding: 0 10rpx;

      .icon-at {
        font-size: $im-font-size-larger;
        color: $im-color-primary;
        font-weight: bold;
      }

      .chat-at-scroll-box {
        flex: 1;
        width: 80%;

        .chat-at-items {
          display: flex;
          align-items: center;
          height: 70rpx;

          .chat-at-item {
            padding: 0 3rpx;
          }
        }
      }
    }

    .send-bar {
      display: flex;
      align-items: center;
      padding: 10rpx;
      border-top: $im-border solid 1px;
      background-color: $im-bg;
      min-height: 80rpx;
      margin-bottom: 14rpx;

      .iconfont {
        font-size: 60rpx;
        margin: 0 10rpx;
        color: $icon-color;
      }

      .chat-record {
        flex: 1;
      }

      .send-text {
        flex: 1;
        overflow: auto;
        padding: 14rpx 20rpx;
        background-color: #fff;
        border-radius: 8rpx;
        font-size: $im-font-size;
        box-sizing: border-box;
        margin: 0 10rpx;
        position: relative;

        .send-text-area {
          width: 100%;
          height: 100%;
          min-height: 40rpx;
          max-height: 200rpx;
          font-size: 30rpx;
        }

        .quote-message {
          background: #eee;
          padding: 5rpx;
          display: flex;
          align-items: center;
          border-radius: 10rpx;

          .quote-text {
            flex: 1;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            font-size: $im-font-size-smaller;
            color: $im-text-color-lighter;
          }
        }
      }

      .btn-send {
        margin: 5rpx;
      }
    }
  }

  .chat-tab-bar {
    position: fixed;
    bottom: 0;
    background-color: $im-bg;

    .chat-tools {
      display: flex;
      flex-wrap: wrap;
      align-items: top;
      height: 310px;
      padding: 40rpx;
      box-sizing: border-box;

      .chat-tools-item {
        width: 25%;
        padding: 16rpx;
        box-sizing: border-box;
        display: flex;
        flex-direction: column;
        align-items: center;

        .tool-icon {
          padding: 26rpx;
          font-size: 54rpx;
          border-radius: 20%;
          background-color: white;
          color: $icon-color;

          &:active {
            background-color: $im-bg-active;
          }
        }

        .tool-name {
          height: 60rpx;
          line-height: 60rpx;
          font-size: 28rpx;
        }
      }
    }

    .chat-emotion {
      height: 310px;
      padding: 20rpx;
      box-sizing: border-box;

      .emotion-item-list {
        display: flex;
        flex-wrap: wrap;
        justify-content: space-between;
        align-content: center;

        .emotion-item {
          text-align: center;
          cursor: pointer;
          padding: 5px;
        }
      }
    }
  }
}
</style>