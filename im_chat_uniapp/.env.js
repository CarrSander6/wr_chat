//设置环境(打包前修改此变量,可选值:DEV/PROD)
const ENV = "PROD";
const UNI_APP = {}
// app热更新文件下载地址
UNI_APP.WGT_URL = "https://chatoss.sheng-ping.com/download/wrim.wgt";
// app安装包下载地址
UNI_APP.APK_URL = "https://is-demo-redpack-im.gzwrxxkj.com/download/im-chat.apk";
// 用户协议、隐私协议
UNI_APP.PROTOCOL_URL = "https://is-demo-redpack-im.gzwrxxkj.com/protocol/xxx.html";
UNI_APP.PRIVACY_URL = "https://is-demo-redpack-im.gzwrxxkj.com/protocol/xxx.html";
// 站外扫描二维码跳转地址,这里跳转到h5
UNI_APP.SCAN_URL = "https://is-demo-redpack-im.gzwrxxkj.com/"
// 表情包路径
UNI_APP.EMO_URL = "/static/emoji/";
// #ifdef MP-WEIXIN
// 微信小程序的本地表情包经常莫名失效，建议将表情包放到服务器中
// UNI_APP.EMO_URL = "https://chatoss.sheng-ping.com/emoji/";
// #endif

if (ENV == "DEV") {
	// UNI_APP.BASE_URL = "http://127.0.0.1:8888/api";
	// UNI_APP.WS_URL = "ws://127.0.0.1:8878/im";
	UNI_APP.BASE_URL = "http://192.168.191.80:8888/api";
	UNI_APP.WS_URL = "ws://192.168.191.80:8878/im";
	// H5 走本地代理解决跨域问题
	// // #ifdef H5
	// UNI_APP.BASE_URL = "/api";
	// // #endif
}

if (ENV == "PROD") {
	// UNI_APP.BASE_URL = "https://chatapi.sheng-ping.com/api";
	// UNI_APP.WS_URL = "wss://chatapi.sheng-ping.com/im";
	// UNI_APP.BASE_URL = "https://chip.im.test.yqkj.lvbei.dhuasuan.com/api";
	// UNI_APP.WS_URL = "wss://chip.im.test.yqkj.lvbei.dhuasuan.com/im";
	UNI_APP.BASE_URL = "https://is-demo-redpack-im.gzwrxxkj.com/api";
	UNI_APP.WS_URL = "wss://is-demo-redpack-im.gzwrxxkj.com/im";
}
// com.shengping.chatapi
export default UNI_APP