<template>
  <div class="p-2">
    <transition :enter-active-class="proxy?.animate.searchAnimate.enter" :leave-active-class="proxy?.animate.searchAnimate.leave">
      <div v-show="showSearch" class="mb-[10px]">
        <el-card shadow="hover">
          <el-form ref="queryFormRef" :model="queryParams" :inline="true">
            <el-form-item label="用户id" prop="userId">
              <el-input v-model="queryParams.userId" placeholder="请输入用户id" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="描述" prop="describes">
              <el-input v-model="queryParams.describes" placeholder="请输入描述" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="资产类型" prop="type">
              <el-select v-model="queryParams.type" placeholder="请选择资产类型" clearable >
                <el-option v-for="dict in biz_fund_type" :key="dict.value" :label="dict.label" :value="dict.value"/>
              </el-select>
            </el-form-item>
            <el-form-item label="转入转出" prop="transferFlag">
              <el-select v-model="queryParams.transferFlag" placeholder="请选择转入转出" clearable >
                <el-option v-for="dict in biz_transfer_flag" :key="dict.value" :label="dict.label" :value="dict.value"/>
              </el-select>
            </el-form-item>
            <el-form-item label="订单编号" prop="orderNo">
              <el-input v-model="queryParams.orderNo" placeholder="请输入订单编号" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="变动前" prop="pointBefore">
              <el-input v-model="queryParams.pointBefore" placeholder="请输入变动前" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="数量" prop="amount">
              <el-input v-model="queryParams.amount" placeholder="请输入数量" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="变动后" prop="pointAfter">
              <el-input v-model="queryParams.pointAfter" placeholder="请输入变动后" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="hash" prop="txHash">
              <el-input v-model="queryParams.txHash" placeholder="请输入hash" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="创建时间" prop="createTime">
              <el-date-picker clearable
                v-model="queryParams.createTime"
                type="date"
                value-format="YYYY-MM-DD hh:mm:ss"
                placeholder="请选择时间"
              />
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
            <el-button type="primary" plain icon="Plus" @click="handleAdd" v-hasPermi="['im:userFundDetail:add']">新增</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="success" plain icon="Edit" :disabled="single" @click="handleUpdate()" v-hasPermi="['im:userFundDetail:edit']">修改</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="danger" plain icon="Delete" :disabled="multiple" @click="handleDelete()" v-hasPermi="['im:userFundDetail:remove']">删除</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="warning" plain icon="Download" @click="handleExport" v-hasPermi="['im:userFundDetail:export']">导出</el-button>
          </el-col>
          <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
        </el-row>
      </template>

      <el-table v-loading="loading" :data="userFundDetailList" @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55" align="center" />
        <el-table-column label="主键" align="center" prop="id" v-if="true" />
        <el-table-column label="用户id" align="center" prop="userId" />
        <el-table-column label="描述" align="center" prop="describes" />
        <el-table-column label="资产类型" align="center" prop="type">
          <template #default="scope">
            <dict-tag :options="biz_fund_type" :value="scope.row.type"/>
          </template>
        </el-table-column>
        <el-table-column label="转入转出" align="center" prop="transferFlag">
          <template #default="scope">
            <dict-tag :options="biz_transfer_flag" :value="scope.row.transferFlag"/>
          </template>
        </el-table-column>
        <el-table-column label="订单编号" align="center" prop="orderNo" show-overflow-tooltip/>
        <el-table-column label="变动前" align="center" prop="pointBefore" />
        <el-table-column label="数量" align="center" prop="amount" />
        <el-table-column label="变动后" align="center" prop="pointAfter" />
        <el-table-column label="hash" align="center" prop="txHash" show-overflow-tooltip/>
        <!-- <el-table-column label="存证时间" align="center" prop="txTime" width="180">
          <template #default="scope">
            <span>{{ parseTime(scope.row.txTime, '{y}-{m}-{d}') }}</span>
          </template>
        </el-table-column> -->
		<el-table-column label="创建时间" align="center" prop="createTime" width="180" show-overflow-tooltip></el-table-column>
		<el-table-column label="更新时间" align="center" prop="updatTime" width="180" show-overflow-tooltip></el-table-column>
        <el-table-column label="备注" align="center" prop="remark" />
        <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
          <template #default="scope">
            <el-tooltip content="修改" placement="top">
              <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['im:userFundDetail:edit']"></el-button>
            </el-tooltip>
            <el-tooltip content="删除" placement="top">
              <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['im:userFundDetail:remove']"></el-button>
            </el-tooltip>
          </template>
        </el-table-column>
      </el-table>

      <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />
    </el-card>
    <!-- 添加或修改用户资产明细对话框 -->
    <el-dialog :title="dialog.title" v-model="dialog.visible" width="500px" append-to-body>
      <el-form ref="userFundDetailFormRef" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="用户id" prop="userId">
          <el-input v-model="form.userId" placeholder="请输入用户id" />
        </el-form-item>
        <el-form-item label="描述" prop="describes">
          <el-input v-model="form.describes" placeholder="请输入描述" />
        </el-form-item>
        <el-form-item label="资产类型" prop="type">
          <el-select v-model="form.type" placeholder="请选择资产类型">
            <el-option
                v-for="dict in biz_fund_type"
                :key="dict.value"
                :label="dict.label"
                :value="parseInt(dict.value)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="转入转出" prop="transferFlag">
          <el-select v-model="form.transferFlag" placeholder="请选择转入转出">
            <el-option
                v-for="dict in biz_transfer_flag"
                :key="dict.value"
                :label="dict.label"
                :value="parseInt(dict.value)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="订单编号" prop="orderNo">
          <el-input v-model="form.orderNo" placeholder="请输入订单编号" />
        </el-form-item>
        <el-form-item label="变动前" prop="pointBefore">
          <el-input v-model="form.pointBefore" placeholder="请输入变动前" />
        </el-form-item>
        <el-form-item label="数量" prop="amount">
          <el-input v-model="form.amount" placeholder="请输入数量" />
        </el-form-item>
        <el-form-item label="变动后" prop="pointAfter">
          <el-input v-model="form.pointAfter" placeholder="请输入变动后" />
        </el-form-item>
        <el-form-item label="hash" prop="txHash">
          <el-input v-model="form.txHash" placeholder="请输入hash" />
        </el-form-item>
        <el-form-item label="存证时间" prop="txTime">
          <el-date-picker clearable
            v-model="form.txTime"
            type="datetime"
            value-format="YYYY-MM-DD HH:mm:ss"
            placeholder="请选择存证时间">
          </el-date-picker>
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

<script setup name="UserFundDetail" lang="ts">
import { listUserFundDetail, getUserFundDetail, delUserFundDetail, addUserFundDetail, updateUserFundDetail } from '@/api/im/userFundDetail';
import { UserFundDetailVO, UserFundDetailQuery, UserFundDetailForm } from '@/api/im/userFundDetail/types';

const { proxy } = getCurrentInstance() as ComponentInternalInstance;
const { biz_transfer_flag, biz_fund_type } = toRefs<any>(proxy?.useDict('biz_transfer_flag', 'biz_fund_type'));

const userFundDetailList = ref<UserFundDetailVO[]>([]);
const buttonLoading = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const ids = ref<Array<string | number>>([]);
const single = ref(true);
const multiple = ref(true);
const total = ref(0);

const queryFormRef = ref<ElFormInstance>();
const userFundDetailFormRef = ref<ElFormInstance>();

const dialog = reactive<DialogOption>({
  visible: false,
  title: ''
});

const initFormData: UserFundDetailForm = {
  id: undefined,
  userId: undefined,
  describes: undefined,
  type: undefined,
  transferFlag: undefined,
  orderNo: undefined,
  pointBefore: undefined,
  amount: undefined,
  pointAfter: undefined,
  txHash: undefined,
  txTime: undefined,
  remark: undefined,
}
const data = reactive<PageData<UserFundDetailForm, UserFundDetailQuery>>({
  form: {...initFormData},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    userId: undefined,
    describes: undefined,
    type: undefined,
    transferFlag: undefined,
    orderNo: undefined,
    pointBefore: undefined,
    amount: undefined,
    pointAfter: undefined,
    txHash: undefined,
    txTime: undefined,
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
    describes: [
      { required: true, message: "描述不能为空", trigger: "blur" }
    ],
    type: [
      { required: true, message: "资产类型不能为空", trigger: "change" }
    ],
    transferFlag: [
      { required: true, message: "转入转出不能为空", trigger: "change" }
    ],
    orderNo: [
      { required: true, message: "订单编号不能为空", trigger: "blur" }
    ],
    pointBefore: [
      { required: true, message: "变动前不能为空", trigger: "blur" }
    ],
    amount: [
      { required: true, message: "数量不能为空", trigger: "blur" }
    ],
    pointAfter: [
      { required: true, message: "变动后不能为空", trigger: "blur" }
    ],
    txHash: [
      { required: true, message: "hash不能为空", trigger: "blur" }
    ],
    txTime: [
      { required: true, message: "存证时间不能为空", trigger: "blur" }
    ],
    remark: [
      { required: true, message: "备注不能为空", trigger: "blur" }
    ],
  }
});

const { queryParams, form, rules } = toRefs(data);

/** 查询用户资产明细列表 */
const getList = async () => {
  loading.value = true;
  const res = await listUserFundDetail(queryParams.value);
  userFundDetailList.value = res.rows;
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
  userFundDetailFormRef.value?.resetFields();
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
const handleSelectionChange = (selection: UserFundDetailVO[]) => {
  ids.value = selection.map(item => item.id);
  single.value = selection.length != 1;
  multiple.value = !selection.length;
}

/** 新增按钮操作 */
const handleAdd = () => {
  reset();
  dialog.visible = true;
  dialog.title = "添加用户资产明细";
}

/** 修改按钮操作 */
const handleUpdate = async (row?: UserFundDetailVO) => {
  reset();
  const _id = row?.id || ids.value[0]
  const res = await getUserFundDetail(_id);
  Object.assign(form.value, res.data);
  dialog.visible = true;
  dialog.title = "修改用户资产明细";
}

/** 提交按钮 */
const submitForm = () => {
  userFundDetailFormRef.value?.validate(async (valid: boolean) => {
    if (valid) {
      buttonLoading.value = true;
      if (form.value.id) {
        await updateUserFundDetail(form.value).finally(() =>  buttonLoading.value = false);
      } else {
        await addUserFundDetail(form.value).finally(() =>  buttonLoading.value = false);
      }
      proxy?.$modal.msgSuccess("操作成功");
      dialog.visible = false;
      await getList();
    }
  });
}

/** 删除按钮操作 */
const handleDelete = async (row?: UserFundDetailVO) => {
  const _ids = row?.id || ids.value;
  await proxy?.$modal.confirm('是否确认删除用户资产明细编号为"' + _ids + '"的数据项？').finally(() => loading.value = false);
  await delUserFundDetail(_ids);
  proxy?.$modal.msgSuccess("删除成功");
  await getList();
}

/** 导出按钮操作 */
const handleExport = () => {
  proxy?.download('im/userFundDetail/export', {
    ...queryParams.value
  }, `userFundDetail_${new Date().getTime()}.xlsx`)
}

onMounted(() => {
  getList();
});
</script>
