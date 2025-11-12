const path = require('path')
const fs = require('fs')

module.exports = {
	devServer: {
		proxy: {
			'/api': {
				target: 'http://127.0.0.1:8888',
				changeOrigin: true,
				ws: false,
				pathRewrite: {
					'^/api': ''
				}
			}
		}
	},
	pluginOptions: {
		electronBuilder: {
			preload: 'src/preload.js',
			externals: ["electron-screenshots"],
			builderOptions: {
				// 包名
				appId: 'com.boxim',
				productName: '盒子IM', // 安装包名称
				icon: "public/logo.ico", // 安装包logo
				win: {
					icon: 'public/logo.ico' // Windows图标,大小要求:256x256
				},
				mac: {
					icon: 'public/logo.icns' // MacOS图标,大小要求: 512x512
				}
			}
		}
	}
}