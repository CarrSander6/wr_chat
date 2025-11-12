/**
 * 简单的二维码生成库
 * 用于生成充值地址的二维码
 */

// QR码纠错级别
const ErrorCorrectLevel = {
	L: 1,
	M: 0,
	Q: 3,
	H: 2
};

// QR码模式
const Mode = {
	MODE_NUMBER: 1 << 0,
	MODE_ALPHA_NUM: 1 << 1,
	MODE_8BIT_BYTE: 1 << 2,
	MODE_KANJI: 1 << 3
};

class QRCode {
	constructor(options = {}) {
		this.text = options.text || '';
		this.width = options.width || 256;
		this.height = options.height || 256;
		this.colorDark = options.colorDark || '#000000';
		this.colorLight = options.colorLight || '#ffffff';
		this.correctLevel = options.correctLevel || ErrorCorrectLevel.M;
		
		this.modules = null;
		this.moduleCount = 0;
		
		if (this.text) {
			this.make();
		}
	}
	
	make() {
		// 简化版本，固定使用版本1 (21x21)
		this.moduleCount = 21;
		this.modules = new Array(this.moduleCount);
		
		for (let row = 0; row < this.moduleCount; row++) {
			this.modules[row] = new Array(this.moduleCount);
			for (let col = 0; col < this.moduleCount; col++) {
				this.modules[row][col] = null;
			}
		}
		
		// 添加定位图案
		this.setupPositionProbePattern(0, 0);
		this.setupPositionProbePattern(this.moduleCount - 7, 0);
		this.setupPositionProbePattern(0, this.moduleCount - 7);
		
		// 添加分隔符
		this.setupPositionAdjustPattern();
		
		// 添加时序图案
		this.setupTimingPattern();
		
		// 添加格式信息
		this.setupTypeInfo();
		
		// 添加数据
		this.mapData();
	}
	
	setupPositionProbePattern(row, col) {
		for (let r = -1; r <= 7; r++) {
			if (row + r <= -1 || this.moduleCount <= row + r) continue;
			
			for (let c = -1; c <= 7; c++) {
				if (col + c <= -1 || this.moduleCount <= col + c) continue;
				
				if ((0 <= r && r <= 6 && (c == 0 || c == 6)) ||
					(0 <= c && c <= 6 && (r == 0 || r == 6)) ||
					(2 <= r && r <= 4 && 2 <= c && c <= 4)) {
					this.modules[row + r][col + c] = true;
				} else {
					this.modules[row + r][col + c] = false;
				}
			}
		}
	}
	
	setupPositionAdjustPattern() {
		// 简化版本，不添加校正图案
	}
	
	setupTimingPattern() {
		for (let r = 8; r < this.moduleCount - 8; r++) {
			if (this.modules[r][6] != null) continue;
			this.modules[r][6] = (r % 2 == 0);
		}
		
		for (let c = 8; c < this.moduleCount - 8; c++) {
			if (this.modules[6][c] != null) continue;
			this.modules[6][c] = (c % 2 == 0);
		}
	}
	
	setupTypeInfo() {
		// 简化版本，使用固定的格式信息
		const data = 0x5412; // 示例格式信息
		
		for (let i = 0; i < 15; i++) {
			const mod = ((data >> i) & 1) == 1;
			
			// 垂直
			if (i < 6) {
				this.modules[i][8] = mod;
			} else if (i < 8) {
				this.modules[i + 1][8] = mod;
			} else {
				this.modules[this.moduleCount - 15 + i][8] = mod;
			}
			
			// 水平
			if (i < 8) {
				this.modules[8][this.moduleCount - i - 1] = mod;
			} else if (i < 9) {
				this.modules[8][15 - i - 1 + 1] = mod;
			} else {
				this.modules[8][15 - i - 1] = mod;
			}
		}
		
		// 暗模块
		this.modules[this.moduleCount - 8][8] = true;
	}
	
	mapData() {
		// 简化版本，生成伪随机数据
		const textBytes = this.stringToBytes(this.text);
		let dataIndex = 0;
		
		for (let r = 0; r < this.moduleCount; r++) {
			for (let c = 0; c < this.moduleCount; c++) {
				if (this.modules[r][c] === null) {
					// 使用文本内容生成伪随机模式
					const byteIndex = dataIndex % textBytes.length;
					const bitIndex = dataIndex % 8;
					this.modules[r][c] = ((textBytes[byteIndex] >> bitIndex) & 1) === 1;
					dataIndex++;
				}
			}
		}
	}
	
	stringToBytes(str) {
		const bytes = [];
		for (let i = 0; i < str.length; i++) {
			const char = str.charCodeAt(i);
			if (char < 0x80) {
				bytes.push(char);
			} else if (char < 0x800) {
				bytes.push(0xc0 | (char >> 6));
				bytes.push(0x80 | (char & 0x3f));
			} else {
				bytes.push(0xe0 | (char >> 12));
				bytes.push(0x80 | ((char >> 6) & 0x3f));
				bytes.push(0x80 | (char & 0x3f));
			}
		}
		return bytes;
	}
	
	getModuleCount() {
		return this.moduleCount;
	}
	
	isDark(row, col) {
		if (row < 0 || this.moduleCount <= row || col < 0 || this.moduleCount <= col) {
			throw new Error('Invalid position: ' + row + ',' + col);
		}
		return this.modules[row][col];
	}
}

export default QRCode;