<template>
  <div class="p-2">
    <transition :enter-active-class="proxy?.animate.searchAnimate.enter"
      :leave-active-class="proxy?.animate.searchAnimate.leave">
      <div v-show="showSearch" class="mb-[10px]">
        <el-card shadow="hover">
          <el-form ref="queryFormRef" :model="queryParams" :inline="true" label-width="100">
            <el-form-item label="用户id" prop="userId">
              <el-input v-model="queryParams.userId" placeholder="请输入用户id" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <!-- <el-form-item label="类型" prop="type">
              <el-select v-model="queryParams.type" placeholder="请选择类型" clearable>
                <el-option v-for="dict in bms_fund_type" :key="dict.value" :label="dict.label" :value="dict.value" />
              </el-select>
            </el-form-item> -->
            <el-form-item label="订单编号" prop="orderSn">
              <el-input v-model="queryParams.orderSn" placeholder="请输入订单编号" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="提现金额" prop="amount">
              <el-input v-model="queryParams.amount" placeholder="请输入提现金额" clearable @keyup.enter="handleQuery" />
            </el-form-item>

            <el-form-item label="实际到账金额" prop="actualAmount">
              <el-input v-model="queryParams.actualAmount" placeholder="请输入实际到账金额" clearable
                @keyup.enter="handleQuery" />
            </el-form-item>


            <el-form-item label="时间" prop="transferTime">
              <el-date-picker v-model="queryParams.transferTime" clearable type="datetimerange" range-separator="至"
                start-placeholder="开始时间" end-placeholder="结束时间" value-format="YYYY-MM-DD HH:mm:ss"
                format="YYYY-MM-DD HH:mm:ss" />
            </el-form-item>
            <el-form-item label="提现地址" prop="fromAddress">
              <el-input v-model="queryParams.fromAddress" placeholder="请输入提现地址" clearable @keyup.enter="handleQuery" />
            </el-form-item>

            <el-form-item>
              <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
              <el-button icon="Refresh" @click="resetQuery">重置</el-button>
            </el-form-item>
          </el-form>
        </el-card>
      </div>
    </transition>

    <el-card shadow="never">
      <!-- 统计信息 -->
      <!-- <div class="mb-4" style="color: red;">
        USDT提现金额: {{ userWithdrawData.totalWithdrawUsdtAmount }} ， USDT手续费: {{
          userWithdrawData.totalWithdrawUsdtFeeAmount }} ， USDT实际到账: {{ userWithdrawData.totalWithdrawUsdtActualAmount }}
      </div> -->

      <template #header>
        <!-- 状态标签页 -->
        <el-tabs v-model="activeTab" @tab-click="handleTabClick" class="mb-4">
          <el-tab-pane label="全部" name="all"></el-tab-pane>
          <el-tab-pane v-for="dict in biz_withdraw_status" :key="dict.value" :label="dict.label"
            :name="dict.value"></el-tab-pane>
        </el-tabs>

        <el-row :gutter="10" class="mb8">
          <!-- <el-col :span="1.5">
            <el-button v-hasPermi="['im:userWithdrawal:add']" type="primary" plain icon="Plus"
              @click="handleAdd">新增</el-button>
          </el-col> -->
          <el-col :span="1.5">
            <el-button v-hasPermi="['im:userWithdrawal:edit']" type="success" plain icon="Edit" :disabled="single"
              @click="handleUpdate()">修改</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button v-hasPermi="['im:userWithdrawal:remove']" type="danger" plain icon="Delete" :disabled="multiple"
              @click="handleDelete()">删除</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button v-hasPermi="['im:userWithdrawal:export']" type="warning" plain icon="Download"
              @click="handleExport">导出</el-button>
          </el-col>
          <right-toolbar v-model:showSearch="showSearch" @query-table="getList"></right-toolbar>
        </el-row>
      </template>

      <el-table v-loading="loading" :data="userWithdrawalList" @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55" align="center" />
        <el-table-column v-if="true" label="主键" align="center" prop="id" />
        <el-table-column label="用户id" align="center" prop="userId" />
        <!-- <el-table-column label="类型" align="center" prop="type">
          <template #default="scope">
            <dict-tag :options="bms_fund_type" :value="scope.row.type" />
          </template>
        </el-table-column> -->
        <el-table-column label="订单编号" align="center" prop="orderSn" width="180">
          <template #default="scope">
            <div style="display: flex; align-items: center; justify-content: center;" v-if="scope.row.orderSn">
              <span style="margin-right: 8px;">{{ formatAddress(scope.row.orderSn) }}</span>
              <el-button type="primary" link icon="CopyDocument" size="small"
                @click="copyToClipboard(scope.row.orderSn)" title="复制订单编号"></el-button>
            </div>
            <span v-else>-</span>
          </template>
        </el-table-column>
        <el-table-column label="提现金额" align="center" prop="amount" />
        <el-table-column label="手续费" align="center" prop="feeAmount" />
        <el-table-column label="实际到账金额" align="center" prop="actualAmount" />
        <el-table-column label="Hash" align="center" prop="txHash" width="180">
          <template #default="scope">
            <div style="display: flex; align-items: center; justify-content: center;" v-if="scope.row.txHash">
              <span style="margin-right: 8px;">{{ formatAddress(scope.row.txHash) }}</span>
              <el-button type="primary" link icon="CopyDocument" size="small" @click="copyToClipboard(scope.row.txHash)"
                title="复制Hash"></el-button>
            </div>
            <span v-else>-</span>
          </template>
        </el-table-column>
        <el-table-column label="状态" align="center" prop="status">
          <template #default="scope">
            <dict-tag :options="biz_withdraw_status" :value="scope.row.status" />
          </template>
        </el-table-column>
        <el-table-column label="时间" align="center" prop="transferTime" width="180">
          <template #default="scope">
            <span v-if="scope.row.transferTime">{{ parseTime(scope.row.transferTime, '{y}-{m}-{d} {h}:{m}:{s}')
            }}</span>
            <span v-else>-</span>
          </template>
        </el-table-column>
        <el-table-column label="提现地址" align="center" prop="fromAddress" width="180">
          <template #default="scope">
            <div style="display: flex; align-items: center; justify-content: center;" v-if="scope.row.fromAddress">
              <span style="margin-right: 8px;">{{ formatAddress(scope.row.fromAddress) }}</span>
              <el-button type="primary" link icon="CopyDocument" size="small"
                @click="copyToClipboard(scope.row.fromAddress)" title="复制提现地址"></el-button>
            </div>
            <span v-else>-</span>
          </template>
        </el-table-column>
        <el-table-column label="数据" align="center" prop="notifyData" />
        <el-table-column label="备注" align="center" prop="remark" />
        <el-table-column label="创建时间" align="center" prop="updateTime" width="180">
          <template #default="scope">
            <span v-if="scope.row.createTime">{{ parseTime(scope.row.createTime, '{y}-{m}-{d} {h}:{m}:{s}') }}</span>
            <span v-else>-</span>
          </template>
        </el-table-column>
        <el-table-column label="更新时间" align="center" prop="updateTime" width="180">
          <template #default="scope">
            <span v-if="scope.row.updateTime">{{ parseTime(scope.row.updateTime, '{y}-{m}-{d} {h}:{m}:{s}') }}</span>
            <span v-else>-</span>
          </template>
        </el-table-column>
        <el-table-column label="操作" align="center" width="240" class-name="small-padding fixed-width" fixed="right">
          <template #default="scope">
            <el-button link type="primary" @click="handleWithDraw(scope.row)"
              v-hasPermi="['im:userWithdrawal:handleWithdraw']"
              v-if="scope.row.status == 1 && scope.row.type == 1">审核</el-button>
            <el-button link type="danger" @click="handleReject(scope.row)"
              v-hasPermi="['im:userWithdrawal:reject']" v-if="scope.row.status == 1">拒绝</el-button>
            <el-button link type="success" @click="handleComplete(scope.row)"
              v-hasPermi="['im:userWithdrawal:complete']"
              v-if="scope.row.status == 1 || scope.row.status == 2">完成</el-button>
            <el-tooltip content="修改" placement="top">
              <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)"
                v-hasPermi="['im:userWithdrawal:edit']"></el-button>
            </el-tooltip>
            <el-tooltip content="删除" placement="top">
              <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)"
                v-hasPermi="['im:userWithdrawal:remove']"></el-button>
            </el-tooltip>
          </template>
        </el-table-column>
      </el-table>

      <pagination v-show="total > 0" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize"
        :total="total" @pagination="getList" />
    </el-card>
    <!-- 添加或修改用户提现记录对话框 -->
    <el-dialog v-model="dialog.visible" :title="dialog.title" width="700px" append-to-body>
      <el-form ref="userWithdrawalFormRef" :model="form" :rules="rules" label-width="120px">
        <el-form-item label="用户id" prop="userId">
          <el-input v-model="form.userId" placeholder="请输入用户id" />
        </el-form-item>
        <!-- <el-form-item label="类型" prop="type">
          <el-select v-model="form.type" placeholder="请选择类型">
            <el-option v-for="dict in bms_fund_type" :key="dict.value" :label="dict.label"
              :value="parseInt(dict.value)"></el-option>
          </el-select>
        </el-form-item> -->
        <el-form-item label="订单编号" prop="orderSn">
          <el-input v-model="form.orderSn" placeholder="请输入订单编号" />
        </el-form-item>
        <el-form-item label="提现金额" prop="amount">
          <el-input v-model="form.amount" placeholder="请输入提现金额" />
        </el-form-item>
        <el-form-item label="手续费" prop="feeAmount">
          <el-input v-model="form.feeAmount" placeholder="请输入手续费" />
        </el-form-item>
        <el-form-item label="实际到账金额" prop="actualAmount">
          <el-input v-model="form.actualAmount" placeholder="请输入实际到账金额" />
        </el-form-item>
        <el-form-item label="hash" prop="txHash">
          <el-input v-model="form.txHash" placeholder="请输入hash" />
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-select v-model="form.status" placeholder="请选择状态">
            <el-option v-for="dict in biz_withdraw_status" :key="dict.value" :label="dict.label"
              :value="parseInt(dict.value)"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="时间" prop="transferTime">
          <el-date-picker v-model="form.transferTime" clearable type="datetime" value-format="YYYY-MM-DD HH:mm:ss"
            placeholder="请选择时间">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="提现地址" prop="fromAddress">
          <el-input v-model="form.fromAddress" placeholder="请输入提现地址" />
        </el-form-item>
        <el-form-item label="数据" prop="notifyData">
          <el-input v-model="form.notifyData" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input v-model="form.remark" placeholder="请输入备注" />
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button :loading="buttonLoading" type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="UserWithdrawal" lang="ts">
import Web3 from 'web3';
import detectEthereumProvider from '@metamask/detect-provider';
import { listUserWithdrawal, getUserWithdrawal, delUserWithdrawal, addUserWithdrawal, updateUserWithdrawal } from '@/api/im/userWithdrawal';
import { UserWithdrawalVO, UserWithdrawalQuery, UserWithdrawalForm } from '@/api/im/userWithdrawal/types';
import { ElMessage, ElMessageBox, ElLoading } from 'element-plus';

// Web3和以太坊钱包类型声明
declare global {
  interface Window {
    ethereum: any;
    bitkeep: any;
  }
}

const { proxy } = getCurrentInstance() as ComponentInternalInstance;
const { biz_withdraw_status } = toRefs<any>(proxy?.useDict('biz_withdraw_status'));

const userWithdrawalList = ref<UserWithdrawalVO[]>([]);
const userWithdrawData = ref({
  totalWithdrawUsdtAmount: 0,
  totalWithdrawUsdtFeeAmount: 0,
  totalWithdrawUsdtActualAmount: 0
});
const buttonLoading = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const ids = ref<Array<string | number>>([]);
const single = ref(true);
const multiple = ref(true);
const total = ref(0);
const activeTab = ref('all');
const dateRange = ref<[string, string]>();

const queryFormRef = ref<ElFormInstance>();
const userWithdrawalFormRef = ref<ElFormInstance>();

const dialog = reactive<DialogOption>({
  visible: false,
  title: ''
});

// 测试模式开关
const testMode = ref(false);

const initFormData: UserWithdrawalForm = {
  id: undefined,
  userId: undefined,
  type: undefined,
  orderSn: undefined,
  amount: undefined,
  feeAmount: undefined,
  actualAmount: undefined,
  txHash: undefined,
  status: undefined,
  transferTime: undefined,
  fromAddress: undefined,
  notifyData: undefined,
  remark: undefined
};
const data = reactive<PageData<UserWithdrawalForm, UserWithdrawalQuery>>({
  form: { ...initFormData },
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    userId: undefined,
    type: undefined,
    orderSn: undefined,
    amount: undefined,
    feeAmount: undefined,
    actualAmount: undefined,
    txHash: undefined,
    status: undefined,
    transferTime: [],
    fromAddress: undefined,
    notifyData: undefined,
    params: {}
  },
  rules: {
    id: [{ required: true, message: '主键不能为空', trigger: 'blur' }],
    userId: [{ required: true, message: '用户id不能为空', trigger: 'blur' }],
    // type: [{ required: true, message: '类型不能为空', trigger: 'change' }],
    orderSn: [{ required: true, message: '订单编号不能为空', trigger: 'blur' }],
    amount: [{ required: true, message: '提现金额不能为空', trigger: 'blur' }],
    feeAmount: [{ required: true, message: '手续费不能为空', trigger: 'blur' }],
    actualAmount: [{ required: true, message: '实际到账金额不能为空', trigger: 'blur' }],
    txHash: [{ required: false, message: 'hash不能为空', trigger: 'blur' }],
    status: [{ required: true, message: '状态不能为空', trigger: 'change' }],
    transferTime: [{ required: false, message: '时间不能为空', trigger: 'blur' }],
    fromAddress: [{ required: false, message: '提现地址不能为空', trigger: 'blur' }],
    notifyData: [{ required: false, message: '数据不能为空', trigger: 'blur' }],
    remark: [{ required: false, message: '备注不能为空', trigger: 'blur' }]
  }
});

const { queryParams, form, rules } = toRefs(data);

/** 查询用户提现记录列表 */
const getList = async () => {
  loading.value = true;
  const params = { ...queryParams.value };
  if (dateRange.value) {
    params.params = {
      ...params.params,
      startTime: dateRange.value[0],
      endTime: dateRange.value[1]
    };
  }
  const res = await listUserWithdrawal(params);
  userWithdrawalList.value = res.rows;
  total.value = res.total;

  // 查询统计数据（如果API支持）
  try {
    // 这里需要根据实际API调整
    // const statsRes = await queryUserWithdrawData(params);
    // userWithdrawData.value = statsRes.data;
  } catch (error) {
    console.warn('获取统计数据失败:', error);
  }

  loading.value = false;
};

/** 取消按钮 */
const cancel = () => {
  reset();
  dialog.visible = false;
};

/** 表单重置 */
const reset = () => {
  form.value = { ...initFormData };
  userWithdrawalFormRef.value?.resetFields();
};

/** 搜索按钮操作 */
const handleQuery = () => {
  queryParams.value.pageNum = 1;
  getList();
};

/** 标签页切换操作 */
const handleTabClick = (tab: any) => {
  console.log('handleTabClick', tab.props);
  console.log('handleTabClick name', tab.props.name);
  if (tab.props.name === 'all') {
    queryParams.value.status = undefined;
  } else {
    queryParams.value.status = parseInt(tab.props.name);
  }
  queryParams.value.pageNum = 1;
  getList();
};

/** 重置按钮操作 */
const resetQuery = () => {
  queryFormRef.value?.resetFields();
  dateRange.value = undefined;
  handleQuery();
};

/** 多选框选中数据 */
const handleSelectionChange = (selection: UserWithdrawalVO[]) => {
  ids.value = selection.map((item) => item.id);
  single.value = selection.length != 1;
  multiple.value = !selection.length;
};

/** 新增按钮操作 */
const handleAdd = () => {
  reset();
  dialog.visible = true;
  dialog.title = '添加用户提现记录';
};

/** 修改按钮操作 */
const handleUpdate = async (row?: UserWithdrawalVO) => {
  reset();
  const _id = row?.id || ids.value[0];
  const res = await getUserWithdrawal(_id);
  Object.assign(form.value, res.data);
  dialog.visible = true;
  dialog.title = '修改用户提现记录';
};

/** 提交按钮 */
const submitForm = () => {
  userWithdrawalFormRef.value?.validate(async (valid: boolean) => {
    if (valid) {
      buttonLoading.value = true;
      if (form.value.id) {
        await updateUserWithdrawal(form.value).finally(() => (buttonLoading.value = false));
      } else {
        await addUserWithdrawal(form.value).finally(() => (buttonLoading.value = false));
      }
      proxy?.$modal.msgSuccess('操作成功');
      dialog.visible = false;
      await getList();
    }
  });
};

/** 删除按钮操作 */
const handleDelete = async (row?: UserWithdrawalVO) => {
  const _ids = row?.id || ids.value;
  await proxy?.$modal.confirm('是否确认删除用户提现记录编号为"' + _ids + '"的数据项？').finally(() => (loading.value = false));
  await delUserWithdrawal(_ids);
  proxy?.$modal.msgSuccess('删除成功');
  await getList();
};

/** 导出按钮操作 */
const handleExport = () => {
  proxy?.download(
    'im/userWithdrawal/export',
    {
      ...queryParams.value
    },
    `userWithdrawal_${new Date().getTime()}.xlsx`
  );
};

// 提现审核成功处理
const doSuccess = async (row?: any, txHash: any, status = 2) => {
  let params = status == 2 ? {
    id: row.id,
    type: row.type,
    amount: row.amount,
    password: '123456',
    status,
    txHash
  } : {
    id: row.id,
    type: row.type,
    amount: row.amount,
    password: '123456',
    status
  };

  await updateUserWithdrawal(params).finally(async () => {
    console.log('成功');
    ElMessage.success('操作成功');
    await getList();
  });
};

// 提现审核处理
const handleWithDraw = async (row: UserWithdrawalVO) => {
  if (row.status !== 1) {
    ElMessage.error('提现申请已处理');
    return;
  }
  if (row.type !== 1) {
    ElMessage.error('提现申请类型错误');
    return;
  }
  if (!row.fromAddress) {
    ElMessage.error('提现申请地址错误');
    return;
  }
  if (!row.actualAmount) {
    ElMessage.error('提现申请金额错误');
    return;
  }

  ElMessageBox.confirm(
    '确认该笔提现申请，是否同意?',
    '提现提示',
    {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning',
    }
  )
    .then(async (result) => {
      console.log('用户确认审核:', result);

      // USDT类型，执行链上转账
      try {
        const txHash = await usdtTransaction(row.fromAddress, row.actualAmount);
        if (txHash) {
          await doSuccess(row, txHash, 2);
        }
      } catch (error: any) {
        console.error('转账失败:', error);
        ElMessage.error(error.message || '转账失败，请重试');
      }
    })
    .catch((err) => {
      console.log('用户取消审核:', err);
    });
};

// 提现完成处理
const handleComplete = async (row: UserWithdrawalVO) => {
  ElMessageBox.confirm(
    '确认完成该笔提现申请？',
    '完成提示',
    {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning',
    }
  )
    .then(async () => {
      console.log('用户确认完成');
      // 设置状态为已到账
      await doSuccess(row, row.txHash, 3);
    })
    .catch(() => {
      console.log('用户取消完成');
    });
};

// 提现拒绝处理
const handleReject = async (row: UserWithdrawalVO) => {
  if (row.status !== 1) {
    ElMessage.error('提现申请已处理');
    return;
  }

  ElMessageBox.confirm(
    '确认拒绝该笔提现申请？',
    '拒绝提示',
    {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning',
    }
  )
    .then(async () => {
      console.log('用户确认拒绝');
      // 设置状态为审核拒绝
      await doSuccess(row, row.txHash, 5);
    })
    .catch(() => {
      console.log('用户取消拒绝');
    });
};

/** USDT转账函数 - BSC链实现 */
const usdtTransaction = async (toAddress: string, amount: number): Promise<string> => {
  try {
    // 参数验证
    if (!toAddress || !toAddress.match(/^0x[a-fA-F0-9]{40}$/)) {
      throw new Error('无效的以太坊地址格式');
    }

    if (!amount || amount <= 0) {
      throw new Error('转账金额必须大于0');
    }

    // 检测TokenPocket钱包
    if (typeof window.ethereum?.isTokenPocket !== 'undefined') {
      await window.ethereum.request({ method: 'eth_requestAccounts' });
    }

    // 检测以太坊提供者
    const provider = await detectEthereumProvider();
    if (!provider) {
      // 尝试使用BitKeep钱包作为备选
      const bitkeepProvider = window.bitkeep && window.bitkeep.ethereum;
      if (!bitkeepProvider) {
        throw new Error('请安装MetaMask、TokenPocket或BitKeep钱包');
      }
    }

    const web3 = new Web3(provider || window.ethereum);

    // USDT合约ABI（标准ERC20）
    const usdtAbi = [{
      "inputs": [],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "constructor"
    }, {
      "anonymous": false,
      "inputs": [{
        "indexed": true,
        "internalType": "address",
        "name": "owner",
        "type": "address"
      }, {
        "indexed": true,
        "internalType": "address",
        "name": "spender",
        "type": "address"
      }, {
        "indexed": false,
        "internalType": "uint256",
        "name": "value",
        "type": "uint256"
      }],
      "name": "Approval",
      "type": "event"
    }, {
      "anonymous": false,
      "inputs": [{
        "indexed": true,
        "internalType": "address",
        "name": "from",
        "type": "address"
      }, {
        "indexed": true,
        "internalType": "address",
        "name": "to",
        "type": "address"
      }, {
        "indexed": false,
        "internalType": "uint256",
        "name": "value",
        "type": "uint256"
      }],
      "name": "Transfer",
      "type": "event"
    }, {
      "constant": true,
      "inputs": [],
      "name": "decimals",
      "outputs": [{
        "internalType": "uint8",
        "name": "",
        "type": "uint8"
      }],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    }, {
      "constant": true,
      "inputs": [{
        "internalType": "address",
        "name": "account",
        "type": "address"
      }],
      "name": "balanceOf",
      "outputs": [{
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    }, {
      "constant": false,
      "inputs": [{
        "internalType": "address",
        "name": "recipient",
        "type": "address"
      }, {
        "internalType": "uint256",
        "name": "amount",
        "type": "uint256"
      }],
      "name": "transfer",
      "outputs": [{
        "internalType": "bool",
        "name": "",
        "type": "bool"
      }],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "function"
    }];

    // BSC链上的USDT合约地址
    const bscUsdtAddress = "0x55d398326f99059ff775485246999027b3197955";
    const myContract = new web3.eth.Contract(usdtAbi, bscUsdtAddress);

    // 转换金额（BSC上USDT有18位小数）
    const transferAmount = web3.utils.toWei(amount.toString(), 'ether');

    // 检查并切换到BSC网络
    if (provider.chainId !== '0x38') {
      await window.ethereum.request({
        method: 'wallet_switchEthereumChain',
        params: [{ chainId: '0x38' }]
      });
    }

    // 获取当前账户地址
    const accounts = await web3.eth.getAccounts();
    if (!accounts || accounts.length === 0) {
      throw new Error('未找到可用的钱包账户');
    }
    const fromAddress = accounts[0];

    // 检查USDT余额 - 测试模式下跳过
    if (!testMode.value) {
      try {
        const usdtBalance = await myContract.methods.balanceOf(fromAddress).call();
        const balanceInUsdt = parseFloat(web3.utils.fromWei(usdtBalance, 'ether'));
        if (balanceInUsdt < amount) {
          throw new Error(`USDT余额不足，当前余额: ${balanceInUsdt.toFixed(2)} USDT，需要: ${amount} USDT`);
        }
      } catch (balanceError: any) {
        if (balanceError.message.includes('USDT余额不足')) {
          throw balanceError;
        }
        console.warn('检查USDT余额失败:', balanceError);
      }
    }

    // 执行转账
    return new Promise((resolve, reject) => {
      myContract.methods.transfer(toAddress, Math.floor(parseFloat(transferAmount))).send({
        from: fromAddress
      }, (err: any, res: any) => {
        if (err) {
          console.error('转账失败:', err);
          reject(err);
        } else {
          console.log('转账hash:', res);
        }
      }).then((result: any) => {
        console.log('转账结束:', result.transactionHash);
        resolve(result.transactionHash);
      }).catch((error: any) => {
        console.error('转账错误:', error);
        let errorMessage = '转账失败';
        
        switch (error.code) {
          case 4001:
            errorMessage = '用户拒绝了交易';
            break;
          case -32603:
            errorMessage = 'Gas费用不足或Gas限制过低';
            break;
          default:
            errorMessage = error.message || '转账执行失败';
        }
        
        reject(new Error(errorMessage));
      });
    });
  } catch (error: any) {
    console.error('USDT转账失败:', error);
    
    // 重新抛出错误，保持原始错误信息
    if (error.message) {
      throw error;
    } else {
      throw new Error('USDT转账失败：未知错误');
    }
  }
};



/** 格式化地址显示 */
const formatAddress = (address: string) => {
  if (!address) return '-';
  if (address.length <= 10) return address;
  return `${address.slice(0, 6)}...${address.slice(-4)}`;
};

/** 复制到剪贴板 */
const copyToClipboard = async (text: string) => {
  try {
    if (navigator.clipboard && window.isSecureContext) {
      await navigator.clipboard.writeText(text);
    } else {
      // 兼容不支持 clipboard API 的浏览器
      const textArea = document.createElement('textarea');
      textArea.value = text;
      document.body.appendChild(textArea);
      textArea.select();
      document.execCommand('copy');
      document.body.removeChild(textArea);
    }
    ElMessage.success('复制成功');
  } catch (err) {
    ElMessage.error('复制失败');
  }
};

onMounted(() => {
  getList();
});
</script>

<style scoped>
</style>
