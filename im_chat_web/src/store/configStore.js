import { defineStore } from 'pinia';
import http from '../api/httpRequest.js'

export default defineStore('configStore', {
	state: () => {
		return {
			electronMode: false, // 当前是否以客户端模式运行
			fullScreen: true, // 当前是否全屏
			registration: {
				mode: []
			},
			webrtc: {}
		}
	},
	actions: {
		setConfig(config) {
			this.webrtc = config.webrtc;
			this.registration = config.registration;
		},
		setElectronMode(mode) {
			this.electronMode = mode
		},
		setFullScreen(fullScreen) {
			this.fullScreen = fullScreen;
		},
		switchFullScreen() {
			this.fullScreen = !this.fullScreen;
		},
		loadConfig() {
			return new Promise((resolve, reject) => {
				http({
					url: '/system/config',
					method: 'GET'
				}).then(config => {
					console.log("系统配置", config)
					this.setConfig(config);
					resolve();
				}).catch((res) => {
					reject(res);
				});
			})
		}
	}
});