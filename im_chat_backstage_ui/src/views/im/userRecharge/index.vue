<template>
  <div class="p-2">
    <transition :enter-active-class="proxy?.animate.searchAnimate.enter" :leave-active-class="proxy?.animate.searchAnimate.leave">
      <div v-show="showSearch" class="mb-[10px]">
        <el-card shadow="hover">
          <el-form ref="queryFormRef" :model="queryParams" :inline="true">
            <el-form-item label="用户id" prop="userId">
              <el-input v-model="queryParams.userId" placeholder="请输入用户id" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="订单编号" prop="orderSn">
              <el-input v-model="queryParams.orderSn" placeholder="请输入订单编号" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="充值金额" prop="amount">
              <el-input v-model="queryParams.amount" placeholder="请输入充值金额" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="usdt金额" prop="usdtAmount">
              <el-input v-model="queryParams.usdtAmount" placeholder="请输入usdt金额" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="hash" prop="txHash">
              <el-input v-model="queryParams.txHash" placeholder="请输入hash" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="状态" prop="status">
              <el-select v-model="queryParams.status" placeholder="请选择状态" clearable >
                <el-option v-for="dict in biz_recharge_status" :key="dict.value" :label="dict.label" :value="dict.value"/>
              </el-select>
            </el-form-item>
            <el-form-item label="转出地址" prop="fromAddress">
              <el-input v-model="queryParams.fromAddress" placeholder="请输入转出地址" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="转入地址" prop="toAddress">
              <el-input v-model="queryParams.toAddress" placeholder="请输入转入地址" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="凭证" prop="img">
              <el-input v-model="queryParams.img" placeholder="请输入凭证" clearable @keyup.enter="handleQuery" />
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
      <template #header>
        <el-row :gutter="10" class="mb8">
          <el-col :span="1.5">
            <el-button type="primary" plain icon="Plus" @click="handleAdd" v-hasPermi="['im:userRecharge:add']">新增</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="success" plain icon="Edit" :disabled="single" @click="handleUpdate()" v-hasPermi="['im:userRecharge:edit']">修改</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="danger" plain icon="Delete" :disabled="multiple" @click="handleDelete()" v-hasPermi="['im:userRecharge:remove']">删除</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="warning" plain icon="Download" @click="handleExport" v-hasPermi="['im:userRecharge:export']">导出</el-button>
          </el-col>
          <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
        </el-row>
      </template>

      <el-table v-loading="loading" :data="userRechargeList" @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55" align="center" />
        <el-table-column label="主键" align="center" prop="id" v-if="true" />
        <el-table-column label="用户id" align="center" prop="userId" />
        <el-table-column label="订单编号" align="center" prop="orderSn" />
        <el-table-column label="充值金额" align="center" prop="amount" />
        <el-table-column label="usdt金额" align="center" prop="usdtAmount" />
        <el-table-column label="hash" align="center" prop="txHash" />
        <el-table-column label="状态" align="center" prop="status">
          <template #default="scope">
            <dict-tag :options="biz_recharge_status" :value="scope.row.status"/>
          </template>
        </el-table-column>
        <el-table-column label="转出地址" align="center" prop="fromAddress" />
        <el-table-column label="转入地址" align="center" prop="toAddress" />
        <!-- <el-table-column label="链上数据" align="center" prop="notifyData" /> -->
        <el-table-column label="凭证" align="center" prop="img" />
        <el-table-column label="备注" align="center" prop="remark" />
		<el-table-column label="创建时间" align="center" prop="createTime" width="180" show-overflow-tooltip></el-table-column>
		<el-table-column label="更新时间" align="center" prop="updateTime" width="180" show-overflow-tooltip></el-table-column>
        <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
          <template #default="scope">
            <el-tooltip content="修改" placement="top">
              <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['im:userRecharge:edit']"></el-button>
            </el-tooltip>
            <el-tooltip content="删除" placement="top">
              <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['im:userRecharge:remove']"></el-button>
            </el-tooltip>
          </template>
        </el-table-column>
      </el-table>

      <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />
    </el-card>
    <!-- 添加或修改用户充值记录对话框 -->
    <el-dialog :title="dialog.title" v-model="dialog.visible" width="500px" append-to-body>
      <el-form ref="userRechargeFormRef" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="用户id" prop="userId">
          <el-input v-model="form.userId" placeholder="请输入用户id" />
        </el-form-item>
        <el-form-item label="订单编号" prop="orderSn">
          <el-input v-model="form.orderSn" placeholder="请输入订单编号" />
        </el-form-item>
        <el-form-item label="充值金额" prop="amount">
          <el-input v-model="form.amount" placeholder="请输入充值金额" />
        </el-form-item>
        <el-form-item label="usdt金额" prop="usdtAmount">
          <el-input v-model="form.usdtAmount" placeholder="请输入usdt金额" />
        </el-form-item>
        <el-form-item label="hash" prop="txHash">
          <el-input v-model="form.txHash" placeholder="请输入hash" />
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-select v-model="form.status" placeholder="请选择状态">
            <el-option
                v-for="dict in biz_recharge_status"
                :key="dict.value"
                :label="dict.label"
                :value="parseInt(dict.value)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="转出地址" prop="fromAddress">
          <el-input v-model="form.fromAddress" placeholder="请输入转出地址" />
        </el-form-item>
        <el-form-item label="转入地址" prop="toAddress">
          <el-input v-model="form.toAddress" placeholder="请输入转入地址" />
        </el-form-item>
        <el-form-item label="凭证" prop="img">
          <el-input v-model="form.img" placeholder="请输入凭证" />
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

<script setup name="UserRecharge" lang="ts">
import { listUserRecharge, getUserRecharge, delUserRecharge, addUserRecharge, updateUserRecharge } from '@/api/im/userRecharge';
import { UserRechargeVO, UserRechargeQuery, UserRechargeForm } from '@/api/im/userRecharge/types';

const { proxy } = getCurrentInstance() as ComponentInternalInstance;
const { biz_recharge_status } = toRefs<any>(proxy?.useDict('biz_recharge_status'));

const userRechargeList = ref<UserRechargeVO[]>([]);
const buttonLoading = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const ids = ref<Array<string | number>>([]);
const single = ref(true);
const multiple = ref(true);
const total = ref(0);

const queryFormRef = ref<ElFormInstance>();
const userRechargeFormRef = ref<ElFormInstance>();

const dialog = reactive<DialogOption>({
  visible: false,
  title: ''
});

const initFormData: UserRechargeForm = {
  id: undefined,
  userId: undefined,
  orderSn: undefined,
  amount: undefined,
  usdtAmount: undefined,
  txHash: undefined,
  status: undefined,
  fromAddress: undefined,
  toAddress: undefined,
  notifyData: undefined,
  img: undefined,
  remark: undefined,
}
const data = reactive<PageData<UserRechargeForm, UserRechargeQuery>>({
  form: {...initFormData},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    userId: undefined,
    orderSn: undefined,
    amount: undefined,
    usdtAmount: undefined,
    txHash: undefined,
    status: undefined,
    fromAddress: undefined,
    toAddress: undefined,
    notifyData: undefined,
    img: undefined,
    params: {
    }
  },
  rules: {
    id: [
      { required: true, message: "主键不能为空", trigger: "blur" }
    ],
    userId: [
      { required: true, message: "用户id不能为空", trigger: "blur" }
    ],
    orderSn: [
      { required: true, message: "订单编号不能为空", trigger: "blur" }
    ],
    amount: [
      { required: true, message: "充值金额不能为空", trigger: "blur" }
    ],
    usdtAmount: [
      { required: true, message: "usdt金额不能为空", trigger: "blur" }
    ],
    txHash: [
      { required: true, message: "hash不能为空", trigger: "blur" }
    ],
    status: [
      { required: true, message: "状态不能为空", trigger: "change" }
    ],
    fromAddress: [
      { required: true, message: "转出地址不能为空", trigger: "blur" }
    ],
    toAddress: [
      { required: true, message: "转入地址不能为空", trigger: "blur" }
    ],
    notifyData: [
      { required: true, message: "链上数据不能为空", trigger: "blur" }
    ],
    img: [
      { required: true, message: "凭证不能为空", trigger: "blur" }
    ],
    remark: [
      { required: true, message: "备注不能为空", trigger: "blur" }
    ],
  }
});

const { queryParams, form, rules } = toRefs(data);

/** 查询用户充值记录列表 */
const getList = async () => {
  loading.value = true;
  const res = await listUserRecharge(queryParams.value);
  userRechargeList.value = res.rows;
  total.value = res.total;
  loading.value = false;
}

/** 取消按钮 */
const cancel = () => {
  reset();
  dialog.visible = false;
}

/** 表单重置 */
const reset = () => {
  form.value = {...initFormData};
  userRechargeFormRef.value?.resetFields();
}

/** 搜索按钮操作 */
const handleQuery = () => {
  queryParams.value.pageNum = 1;
  getList();
}

/** 重置按钮操作 */
const resetQuery = () => {
  queryFormRef.value?.resetFields();
  handleQuery();
}

/** 多选框选中数据 */
const handleSelectionChange = (selection: UserRechargeVO[]) => {
  ids.value = selection.map(item => item.id);
  single.value = selection.length != 1;
  multiple.value = !selection.length;
}

/** 新增按钮操作 */
const handleAdd = () => {
  reset();
  dialog.visible = true;
  dialog.title = "添加用户充值记录";
}

/** 修改按钮操作 */
const handleUpdate = async (row?: UserRechargeVO) => {
  reset();
  const _id = row?.id || ids.value[0]
  const res = await getUserRecharge(_id);
  Object.assign(form.value, res.data);
  dialog.visible = true;
  dialog.title = "修改用户充值记录";
}

/** 提交按钮 */
const submitForm = () => {
  userRechargeFormRef.value?.validate(async (valid: boolean) => {
    if (valid) {
      buttonLoading.value = true;
      if (form.value.id) {
        await updateUserRecharge(form.value).finally(() =>  buttonLoading.value = false);
      } else {
        await addUserRecharge(form.value).finally(() =>  buttonLoading.value = false);
      }
      proxy?.$modal.msgSuccess("操作成功");
      dialog.visible = false;
      await getList();
    }
  });
}

/** 删除按钮操作 */
const handleDelete = async (row?: UserRechargeVO) => {
  const _ids = row?.id || ids.value;
  await proxy?.$modal.confirm('是否确认删除用户充值记录编号为"' + _ids + '"的数据项？').finally(() => loading.value = false);
  await delUserRecharge(_ids);
  proxy?.$modal.msgSuccess("删除成功");
  await getList();
}

/** 导出按钮操作 */
const handleExport = () => {
  proxy?.download('im/userRecharge/export', {
    ...queryParams.value
  }, `userRecharge_${new Date().getTime()}.xlsx`)
}

onMounted(() => {
  getList();
});
</script>
