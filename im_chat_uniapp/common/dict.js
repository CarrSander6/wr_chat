const COMPLAINT_TYPE = [{
	val: 1,
	name: '对我造成骚扰'
}, {
	val: 2,
	name: '疑似诈骗'
}, {
	val: 3,
	name: '传播不良内容'
}, {
	val: 99,
	name: '其他不正规行为'
}]

const RESOLVED_TYPE = [{
	val: 1,
	name: '情况已核实,已处理'
}, {
	val: 2,
	name: '证据不充分,不予处理'
}, {
	val: 3,
	name: '投诉内容未涉及不正规行为'
}, {
	val: 99,
	name: '其他情况'
}]



const covertToName = (dictType, val, defName) => {
	let dictItem = dictType.find(item => item.val == val);
	return dictItem ? dictItem.name : defName;
}

export {
	COMPLAINT_TYPE,
	RESOLVED_TYPE,
	covertToName
}