<template>
	<view class="match-container">
		<view class="header">
			<view class="title">社交匹配</view>
			<view class="actions">
				<view class="action-btn" @click="goToHistory">
					<u-icon name="list" size="24"></u-icon>
					<text>历史</text>
				</view>
				<view class="action-btn" @click="goToMatched">
					<u-icon name="heart-fill" size="24" color="#ff6b6b"></u-icon>
					<text>匹配</text>
				</view>
			</view>
		</view>

		<view class="cards-container" v-if="candidates.length > 0">
        <view 
            v-for="(user, index) in candidates" 
            :key="user.id"
            class="card"
            :class="{ 'top-card': index === currentIndex }"
            :style="getCardStyle(index)"
            @touchstart="index === currentIndex && handleTouchStart($event)"
            @touchmove="index === currentIndex && handleTouchMove($event)"
            @touchend="index === currentIndex && handleTouchEnd()"
        >
            <image :src="user.headImage || '/static/default-avatar.png'" class="user-image" mode="aspectFill"></image>
            <view class="user-info">
                <view class="user-name">{{ user.nickName }}</view>
                <view class="user-signature">{{ user.signature || '这个人很懒，什么都没写~' }}</view>
                <view class="user-details">
                    <text>{{ user.sex === 0 ? '♂' : '♀' }}</text>
                </view>
            </view>
            <view v-if="index === currentIndex" class="like-label" :style="{ opacity: likeOpacity }">LIKE</view>
            <view v-if="index === currentIndex" class="nope-label" :style="{ opacity: nopeOpacity }">NOPE</view>
        </view>
		</view>

		<view v-else class="empty-state">
			<text class="empty-text">暂无推荐用户</text>
			<button type="primary" @click="loadCandidates">刷新</button>
		</view>

		<view class="action-buttons" v-if="candidates.length > 0">
			<view class="btn dislike-btn" @click="handleDislike">
				<text>✗</text>
			</view>
			<view class="btn like-btn" @click="handleLike">
				<text>♥</text>
			</view>
		</view>
	</view>
</template>

<script>
export default {
    data() {
        return {
            candidates: [],
            currentIndex: 0,
            startX: 0,
            startY: 0,
            dragX: 0,
            dragY: 0,
            likeOpacity: 0,
            nopeOpacity: 0
        }
    },
	onLoad() {
		this.loadCandidates();
	},
	methods: {
        async loadCandidates() {
            try {
                const list = await this.$http.get('/match/candidates', {
                    data: { limit: 10 }
                });
                this.candidates = Array.isArray(list) ? list : [];
            } catch (e) {
                this.candidates = [];
            } finally {
                this.currentIndex = 0;
            }
        },
        getCardStyle(index) {
            if (index < this.currentIndex) {
                return { display: 'none' };
            }
            const offset = index - this.currentIndex;
            if (index === this.currentIndex) {
                const rotate = this.dragX * 0.05;
                return {
                    transform: `translate(${this.dragX}px, ${this.dragY}px) rotate(${rotate}deg)`,
                    zIndex: 200,
                    opacity: 1
                };
            }
            return {
                transform: `translateY(${offset * 10}px) scale(${1 - offset * 0.05})`,
                zIndex: 100 - offset,
                opacity: 1 - offset * 0.2
            };
        },
        handleTouchStart(e) {
            const touch = e.changedTouches[0] || e.touches[0];
            this.startX = touch.pageX;
            this.startY = touch.pageY;
            this.dragX = 0;
            this.dragY = 0;
            this.likeOpacity = 0;
            this.nopeOpacity = 0;
        },
        handleTouchMove(e) {
            const touch = e.changedTouches[0] || e.touches[0];
            this.dragX = touch.pageX - this.startX;
            this.dragY = touch.pageY - this.startY;
            const ratio = Math.min(Math.abs(this.dragX) / 120, 1);
            if (this.dragX > 0) {
                this.likeOpacity = ratio;
                this.nopeOpacity = 0;
            } else if (this.dragX < 0) {
                this.nopeOpacity = ratio;
                this.likeOpacity = 0;
            } else {
                this.likeOpacity = 0;
                this.nopeOpacity = 0;
            }
        },
        async handleTouchEnd() {
            const threshold = 100;
            if (this.dragX > threshold) {
                await this.recordAction(1);
            } else if (this.dragX < -threshold) {
                await this.recordAction(2);
            }
            this.dragX = 0;
            this.dragY = 0;
            this.likeOpacity = 0;
            this.nopeOpacity = 0;
        },
        async handleLike() {
            await this.recordAction(1);
        },
        async handleDislike() {
            await this.recordAction(2);
        },
		async recordAction(actionType) {
			if (this.currentIndex >= this.candidates.length) {
				return;
			}
			
			const currentUser = this.candidates[this.currentIndex];
			try {
                const ok = await this.$http.post('/match/action', {
                    targetUserId: currentUser.id,
                    actionType: actionType
                });
                
                if (ok === true) {
                    // 匹配成功
                    uni.showModal({
                        title: '匹配成功',
                        content: '你们互相喜欢，现在可以开始聊天了',
						confirmText: '开始聊天',
						success: (modalRes) => {
							if (modalRes.confirm) {
								uni.navigateTo({
									url: `/pages/chat/chat-box?userId=${currentUser.id}`
								});
							}
						}
					});
				}
				
				this.currentIndex++;
				
				// 如果卡片不够了，加载更多
				if (this.currentIndex >= this.candidates.length - 2) {
					this.loadCandidates();
				}
			} catch (e) {
				uni.showToast({
					title: '操作失败',
					icon: 'none'
				});
			}
		},
		goToHistory() {
			uni.navigateTo({
				url: '/pages/match/match-history'
			});
		},
		goToMatched() {
			uni.navigateTo({
				url: '/pages/match/match-list'
			});
		}
        }
}
</script>

<style lang="scss" scoped>
.match-container {
	height: 100vh;
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	display: flex;
	flex-direction: column;
}

.header {
	padding: 20rpx 30rpx;
	display: flex;
	justify-content: space-between;
	align-items: center;
	
	.title {
		font-size: 36rpx;
		font-weight: bold;
		color: #fff;
	}
	
	.actions {
		display: flex;
		gap: 20rpx;
		
		.action-btn {
			display: flex;
			flex-direction: column;
			align-items: center;
			color: #fff;
			font-size: 24rpx;
		}
	}
}

.cards-container {
	flex: 1;
	position: relative;
	padding: 20rpx;
	
    .card {
        position: absolute;
        width: 90%;
        height: 70%;
        left: 5%;
        top: 10%;
        background: #fff;
        border-radius: 20rpx;
        overflow: hidden;
        box-shadow: 0 10rpx 40rpx rgba(0, 0, 0, 0.2);
        transition: transform 0.3s ease, opacity 0.3s ease;
		
		.user-image {
			width: 100%;
			height: 70%;
		}
		
		.user-info {
			padding: 30rpx;
			
			.user-name {
				font-size: 40rpx;
				font-weight: bold;
				margin-bottom: 10rpx;
			}
			
			.user-signature {
				font-size: 28rpx;
				color: #666;
				margin-bottom: 10rpx;
			}
			
			.user-details {
				font-size: 32rpx;
				color: #999;
        }
    }
}

.like-label {
    position: absolute;
    top: 30rpx;
    left: 30rpx;
    padding: 10rpx 20rpx;
    border: 4rpx solid #4cd964;
    color: #4cd964;
    font-weight: 700;
    border-radius: 8rpx;
    transform: rotate(-20deg);
    background: rgba(255,255,255,0.8);
}

.nope-label {
    position: absolute;
    top: 30rpx;
    right: 30rpx;
    padding: 10rpx 20rpx;
    border: 4rpx solid #ff6b6b;
    color: #ff6b6b;
    font-weight: 700;
    border-radius: 8rpx;
    transform: rotate(20deg);
    background: rgba(255,255,255,0.8);
}
}

.empty-state {
	flex: 1;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	color: #fff;
	
	.empty-text {
		margin: 30rpx 0;
		font-size: 28rpx;
	}
}

.action-buttons {
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 100rpx;
	padding: 40rpx;
	
	.btn {
		width: 120rpx;
		height: 120rpx;
		border-radius: 50%;
		display: flex;
		justify-content: center;
		align-items: center;
		box-shadow: 0 5rpx 20rpx rgba(0, 0, 0, 0.2);
		font-size: 60rpx;
		color: #fff;
	}
	
	.dislike-btn {
		background: #ff6b6b;
	}
	
	.like-btn {
		background: #4cd964;
	}
}
</style>
