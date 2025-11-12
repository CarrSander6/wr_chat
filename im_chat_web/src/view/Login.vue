<template>
	<div class="login-view" :class="configStore.electronMode ? 'white-backgroup' : ''">
		<div class="content">
			<el-form class="form" :model="loginForm" status-icon :rules="rules" ref="loginForm"
				@keyup.enter.native="submitForm()" v-loading="loading" element-loading-text="正在登陆...">
				<div class="title">
					<div>登录盒子IM</div>
				</div>
				<el-form-item prop="userName" v-show="false">
					<el-input type="terminal" v-model="loginForm.terminal" autocomplete="off"></el-input>
				</el-form-item>
				<el-form-item prop="userName">
					<el-input type="userName" v-model="loginForm.userName" autocomplete="off"
						:placeholder="loginNamePlaceholder" prefix-icon="el-icon-user"></el-input>
				</el-form-item>
				<el-form-item prop="password">
					<el-input type="password" v-model="loginForm.password" autocomplete="off" placeholder="密码"
						prefix-icon="el-icon-lock"></el-input>
				</el-form-item>
				<el-form-item>
					<el-checkbox v-model="isAutoLogin">下次自动登录</el-checkbox>
				</el-form-item>
				<el-button class="submit-btn" type="primary" @click="submitForm()">登录</el-button>
				<div class="register">
					<router-link to="/register">没有账号? 立即注册</router-link>
				</div>
			</el-form>
		</div>
		<icp></icp>
		<captcha-image ref="captchaRef"></captcha-image>
	</div>

</template>

<script>
import Icp from '../components/common/Icp.vue'
import CaptchaImage from '../components/common/CaptchaImage.vue';

export default {
	name: "login",
	components: {
		Icp,
		CaptchaImage
	},
	data() {
		var checkUsername = (rule, value, callback) => {
			if (!value) {
				return callback(new Error('请输入用户名'));
			}
			callback();
		};
		var checkPassword = (rule, value, callback) => {
			if (value === '') {
				callback(new Error('请输入密码'));
			}
			callback();
		};
		return {
			loading: false,
			isAutoLogin: true,
			loginForm: {
				terminal: this.$enums.TERMINAL_TYPE.WEB,
				userName: '',
				password: ''
			},
			rules: {
				userName: [{
					validator: checkUsername,
					trigger: 'blur'
				}],
				password: [{
					validator: checkPassword,
					trigger: 'blur'
				}]
			}
		};
	},
	methods: {
		submitForm() {
			this.$refs.loginForm.validate((valid) => {
				if (valid) {
					this.loading = true;
					this.$http({
						url: "/login",
						method: 'post',
						data: this.loginForm
					}).then((data) => {
						localStorage.setItem('isAutoLogin', this.isAutoLogin);
						// 保存密码到
						localStorage.setItem('username', this.loginForm.userName);
						localStorage.setItem('password', this.loginForm.password);
						// localStorage
						sessionStorage.setItem("accessToken", data.accessToken);
						sessionStorage.setItem("refreshToken", data.refreshToken);
						this.$message.success("登录成功");
						this.$router.push("/home/chat");
					}).finally(() => {
						this.loading = false
					})
				}
			});
		},
		resetForm(formName) {
			this.$refs[formName].resetFields();
		},
		// 获取cookie、
		getCookie(name) {
			let reg = new RegExp("(^| )" + name + "=([^;]*)(;|$)");
			let arr = document.cookie.match(reg)
			if (arr) {
				return unescape(arr[2]);
			}
			return '';
		},
		// 设置cookie,增加到vue实例方便全局调用
		setCookie(name, value) {
			document.cookie = name + "=" + escape(value);
		}
	},
	mounted() {
		// 账号密码
		this.loginForm.userName = localStorage.getItem("username");
		this.loginForm.password = localStorage.getItem("password");

		// 加载配置
		this.configStore.loadConfig();
		// electron 窗口大小
		window.electronAPI && window.electronAPI.sendEvent('resize', {
			width: 360,
			height: 440,
			maximizable: false
		})
		// 自动登录
		if (localStorage.getItem("isAutoLogin") != null) {
			this.isAutoLogin = JSON.parse(localStorage.getItem("isAutoLogin"));
			if (this.isAutoLogin) {
				this.submitForm();
			}
		}
	},
	computed: {
		loginNamePlaceholder() {
			let mode = this.configStore.registration.mode;
			let strText = "用户名";
			if (mode.includes("phone")) {
				strText += "/手机号"
			}
			if (mode.includes("email")) {
				strText += "/邮箱"
			}
			return strText;
		}
	}
}
</script>

<style scoped lang="scss">
.login-view {
	width: 100%;
	height: 100%;
	background: #E8F2FF;
	background-size: cover;
	box-sizing: border-box;
	display: flex;

	&.white-backgroup {
		background: white;
	}

	.content {
		position: relative;
		display: flex;
		justify-content: center;
		align-items: center;
		width: 100%;

		.form {
			width: 360px;
			height: 380px;
			padding: 30px;
			background: white;
			opacity: 0.9;
			box-shadow: 0px 0px 1px #ccc;
			border-radius: 3%;
			overflow: hidden;
			border: 1px solid #ccc;

			.title {
				display: flex;
				justify-content: center;
				align-items: center;
				line-height: 50px;
				margin: 30px 0;
				font-size: 22px;
				font-weight: 600;
				letter-spacing: 2px;
				text-transform: uppercase;
				text-align: center;
			}

			.submit-btn {
				width: 100%;
			}

			.register {
				display: flex;
				flex-direction: row-reverse;
				line-height: 40px;
				text-align: left;
				margin-top: 20px;
				padding-left: 20px;
			}
		}
	}
}
</style>