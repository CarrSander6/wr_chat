<template>
  <div class="p-2">
    <transition :enter-active-class="proxy?.animate.searchAnimate.enter" :leave-active-class="proxy?.animate.searchAnimate.leave">
      <div v-show="showSearch" class="mb-[10px]">
        <el-card shadow="hover">
          <el-form ref="queryFormRef" :model="queryParams" :inline="true">
            <el-form-item label="用户账号" prop="userId">
              <el-input v-model="queryParams.userId" placeholder="请输入用户账号" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="红包标识串" prop="redPacket">
              <el-input v-model="queryParams.redPacket" placeholder="请输入红包标识串" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="红包金额(单位为分)" prop="amount">
              <el-input v-model="queryParams.amount" placeholder="请输入红包金额(单位为分)" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="时间" prop="robTime">
              <el-date-picker clearable
                v-model="queryParams.robTime"
                type="date"
                value-format="YYYY-MM-DD"
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
            <el-button type="primary" plain icon="Plus" @click="handleAdd" v-hasPermi="['im:robRecord:add']">新增</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="success" plain icon="Edit" :disabled="single" @click="handleUpdate()" v-hasPermi="['im:robRecord:edit']">修改</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="danger" plain icon="Delete" :disabled="multiple" @click="handleDelete()" v-hasPermi="['im:robRecord:remove']">删除</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="warning" plain icon="Download" @click="handleExport" v-hasPermi="['im:robRecord:export']">导出</el-button>
          </el-col>
          <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
        </el-row>
      </template>

      <el-table v-loading="loading" :data="robRecordList" @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55" align="center" />
        <el-table-column label="" align="center" prop="id" v-if="true" />
        <el-table-column label="用户账号" align="center" prop="userId" />
        <el-table-column label="红包标识串" align="center" prop="redPacket" />
        <el-table-column label="红包金额(单位为分)" align="center" prop="amount" />
        <el-table-column label="时间" align="center" prop="robTime" width="180">
          <template #default="scope">
            <span>{{ parseTime(scope.row.robTime, '{y}-{m}-{d}') }}</span>
          </template>
        </el-table-column>
        <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
          <template #default="scope">
            <el-tooltip content="修改" placement="top">
              <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['im:robRecord:edit']"></el-button>
            </el-tooltip>
            <el-tooltip content="删除" placement="top">
              <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['im:robRecord:remove']"></el-button>
            </el-tooltip>
          </template>
        </el-table-column>
      </el-table>

      <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />
    </el-card>
    <!-- 添加或修改抢红包记录对话框 -->
    <el-dialog :title="dialog.title" v-model="dialog.visible" width="500px" append-to-body>
      <el-form ref="robRecordFormRef" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="用户账号" prop="userId">
          <el-input v-model="form.userId" placeholder="请输入用户账号" />
        </el-form-item>
        <el-form-item label="红包标识串" prop="redPacket">
          <el-input v-model="form.redPacket" placeholder="请输入红包标识串" />
        </el-form-item>
        <el-form-item label="红包金额(单位为分)" prop="amount">
          <el-input v-model="form.amount" placeholder="请输入红包金额(单位为分)" />
        </el-form-item>
        <el-form-item label="时间" prop="robTime">
          <el-date-picker clearable
            v-model="form.robTime"
            type="datetime"
            value-format="YYYY-MM-DD HH:mm:ss"
            placeholder="请选择时间">
          </el-date-picker>
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

<script setup name="RobRecord" lang="ts">
import { listRobRecord, getRobRecord, delRobRecord, addRobRecord, updateRobRecord } from '@/api/im/robRecord';
import { RobRecordVO, RobRecordQuery, RobRecordForm } from '@/api/im/robRecord/types';

const { proxy } = getCurrentInstance() as ComponentInternalInstance;

const robRecordList = ref<RobRecordVO[]>([]);
const buttonLoading = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const ids = ref<Array<string | number>>([]);
const single = ref(true);
const multiple = ref(true);
const total = ref(0);

const queryFormRef = ref<ElFormInstance>();
const robRecordFormRef = ref<ElFormInstance>();

const dialog = reactive<DialogOption>({
  visible: false,
  title: ''
});

const initFormData: RobRecordForm = {
  id: undefined,
  userId: undefined,
  redPacket: undefined,
  amount: undefined,
  robTime: undefined,
}
const data = reactive<PageData<RobRecordForm, RobRecordQuery>>({
  form: {...initFormData},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    userId: undefined,
    redPacket: undefined,
    amount: undefined,
    robTime: undefined,
    params: {
    }
  },
  rules: {
    id: [
      { required: true, message: "不能为空", trigger: "blur" }
    ],
    userId: [
      { required: true, message: "用户账号不能为空", trigger: "blur" }
    ],
    redPacket: [
      { required: true, message: "红包标识串不能为空", trigger: "blur" }
    ],
    amount: [
      { required: true, message: "红包金额(单位为分)不能为空", trigger: "blur" }
    ],
    robTime: [
      { required: true, message: "时间不能为空", trigger: "blur" }
    ],
  }
});

const { queryParams, form, rules } = toRefs(data);

/** 查询抢红包记录列表 */
const getList = async () => {
  loading.value = true;
  const res = await listRobRecord(queryParams.value);
  robRecordList.value = res.rows;
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
  robRecordFormRef.value?.resetFields();
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
const handleSelectionChange = (selection: RobRecordVO[]) => {
  ids.value = selection.map(item => item.id);
  single.value = selection.length != 1;
  multiple.value = !selection.length;
}

/** 新增按钮操作 */
const handleAdd = () => {
  reset();
  dialog.visible = true;
  dialog.title = "添加抢红包记录";
}

/** 修改按钮操作 */
const handleUpdate = async (row?: RobRecordVO) => {
  reset();
  const _id = row?.id || ids.value[0]
  const res = await getRobRecord(_id);
  Object.assign(form.value, res.data);
  dialog.visible = true;
  dialog.title = "修改抢红包记录";
}

/** 提交按钮 */
const submitForm = () => {
  robRecordFormRef.value?.validate(async (valid: boolean) => {
    if (valid) {
      buttonLoading.value = true;
      if (form.value.id) {
        await updateRobRecord(form.value).finally(() =>  buttonLoading.value = false);
      } else {
        await addRobRecord(form.value).finally(() =>  buttonLoading.value = false);
      }
      proxy?.$modal.msgSuccess("操作成功");
      dialog.visible = false;
      await getList();
    }
  });
}

/** 删除按钮操作 */
const handleDelete = async (row?: RobRecordVO) => {
  const _ids = row?.id || ids.value;
  await proxy?.$modal.confirm('是否确认删除抢红包记录编号为"' + _ids + '"的数据项？').finally(() => loading.value = false);
  await delRobRecord(_ids);
  proxy?.$modal.msgSuccess("删除成功");
  await getList();
}

/** 导出按钮操作 */
const handleExport = () => {
  proxy?.download('im/robRecord/export', {
    ...queryParams.value
  }, `robRecord_${new Date().getTime()}.xlsx`)
}

onMounted(() => {
  getList();
});
</script>
