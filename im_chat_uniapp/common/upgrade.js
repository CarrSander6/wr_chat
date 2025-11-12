import http from './request';
import dialog from './dialog';
import UNI_APP from '@/.env.js'
let checkAndUpgrade = () => {
	plus.runtime.getProperty(plus.runtime.appid, (info) => {
		const curVersionCode = info.versionCode;
		console.log("当前应用版本号：", curVersionCode);
		http({
			url: '/system/checkVersion?versionCode=' + info.version
		}).then((res) => {
			console.log("获取版本信息res",res);
			if (!res.isLatestVersion) {
				dialog.open({
					title: "发现新版本",
					confirmText: "立即更新",
					cancelText: "稍后再说",
					content: res.changeLog,
					icon: '/static/image/upgrade.png',
					success: () => {
						downloadAndInstall(res.apkUrl);
					}
				})
			}
		}).catch(() => {
			console.log("获取版本信息异常");
		})
	});
}
let downloadAndInstall = (apkUrl) => {
	// 如果后端没有返回APK地址，则使用配置文件中的默认地址
	if (!apkUrl) {
		apkUrl = UNI_APP.APK_URL;
	}
	const dtask = plus.downloader.createDownload(apkUrl, {}, (d, status) => {
		if (status == 200) {
			install(d.filename); // 安装apk包  
		} else {
			plus.nativeUI.alert('下载失败');
		}
	});
	downloadProgress(dtask);
}
let install = (path) => {
	let showLoading = plus.nativeUI.showWaiting('正在安装...');
	// 使用系统安装器安装APK
	plus.runtime.openFile(path, {}, () => {
		plus.nativeUI.closeWaiting();
		// APK安装由系统处理，不需要重启应用
	}, (e) => {
		plus.nativeUI.closeWaiting();
		plus.nativeUI.alert('安装失败，请手动安装');
	});
}
let downloadProgress = (dtask) => {
	try {
		dtask.start(); //开启下载任务
		let showLoading = plus.nativeUI.showWaiting('正在下载');
		let timeStamp = new Date().getTime();
		dtask.addEventListener('statechanged', (task, status) => {
			// 给下载任务设置监听
			switch (task.state) {
				case 3:
					let prg = parseInt((parseFloat(task.downloadedSize) / parseFloat(task.totalSize)) *
					100);
					let curTime = new Date().getTime();
					if (curTime > timeStamp + 100) {
						showLoading.setTitle('正在下载' + prg + '%');
						timeStamp = curTime
					}
					break;
				case 4:
					// 下载完成
					plus.nativeUI.closeWaiting();
					break;
			}
		})
	} catch (e) {
		plus.nativeUI.closeWaiting();
		uni.showToast({
			title: '更新失败',
			icon: 'none'
		})
	}
}
export {
	checkAndUpgrade
}