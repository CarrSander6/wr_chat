<template>
  <div class="p-2">
    <transition :enter-active-class="proxy?.animate.searchAnimate.enter"
      :leave-active-class="proxy?.animate.searchAnimate.leave">
      <div v-show="showSearch" class="mb-[10px]">
        <el-card shadow="hover">
          <el-form ref="queryFormRef" :model="queryParams" :inline="true">
            <el-form-item label="发起用户" prop="userId">
              <im-user-select v-model="queryParams.userId"></im-user-select>
            </el-form-item>
            <el-form-item label="处理状态" prop="status">
              <el-select v-model="queryParams.status" clearable>
                <el-option v-for="dict in im_complaint_status" :key="dict.value" :label="dict.label"
                  :value="dict.value" />
              </el-select>
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
      <el-table v-loading="loading" :data="complaintList">
        <el-table-column label="发起用户" align="center" prop="userName" />
        <el-table-column label="投诉对象" align="center" prop="targetName">
          <template #default="scope">
            {{ scope.row.targetName }}
          </template>
        </el-table-column>
        <el-table-column label="投诉对象类型" align="center" prop="targetType">
          <template #default="scope">
            <dict-tag :options="im_complaint_target_type" :value="scope.row.targetType" />
          </template>
        </el-table-column>
        <el-table-column label="投诉原因" align="center" prop="type">
          <template #default="scope">
            <dict-tag :options="im_complaint_type" :value="scope.row.type" />
          </template>
        </el-table-column>
        <el-table-column label="投诉时间" align="center" prop="createTime" />
        <el-table-column label="处理状态" align="center" prop="status">
          <template #default="scope">
            <dict-tag :options="im_complaint_status" :value="scope.row.status" />
          </template>
        </el-table-column>
        <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
          <template #default="scope">
            <el-button link type="primary" @click="handleDetail(scope.row)"
              v-hasPermi="['im:complaint:query']">详情</el-button>
            <el-button link v-if="scope.row.status == 1" type="primary" @click="handleReslove(scope.row)"
              v-hasPermi="['im:complaint:reslove']">处理</el-button>
            <el-button link v-else type="danger" @click="handleReslove(scope.row)"
              v-hasPermi="['im:complaint:reslove']">重新处理</el-button>
          </template>
        </el-table-column>
      </el-table>
      <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum"
        v-model:limit="queryParams.pageSize" @pagination="getList" />
    </el-card>
    <!-- 投诉详情对话框 -->
    <el-dialog :title="dialog.title" v-model="dialog.visible" width="800px" append-to-body>
      <el-form ref="detailFormRef" :model="form" label-width="80px">
        <el-form-item label="发起用户" prop="userName">
          <div>{{ form.userName }}</div>
        </el-form-item>
        <el-form-item label="投诉对象" prop="targetName">
          <div>{{ form.targetName }}</div>
          <dict-tag class="tag" :options="im_complaint_target_type" :value="form.targetType" />
        </el-form-item>
        <el-form-item label="投诉时间" prop="createTime">
          <div>{{ form.createTime }}</div>
        </el-form-item>
        <el-form-item label="投诉原因" prop="type">
          <dict-tag :options="im_complaint_type" :value="form.type + ''" />
        </el-form-item>
        <el-form-item label="图片证据" prop="images" v-if="JSON.parse(form.images).length">
          <div class="form-images">
            <div v-for="(img, idx) in JSON.parse(form.images)" :key="idx">
              <image-preview :src="img.thumbUrl" :full-src="img.originUrl" :width="120" :height="120" />
            </div>
          </div>
        </el-form-item>
        <el-form-item label="投诉内容" prop="content">
          <div>{{ form.content }}</div>
        </el-form-item>
        <el-form-item label="处理状态" prop="status">
          <dict-tag :options="im_complaint_status" :value="form.status + ''" />
        </el-form-item>
        <el-form-item v-if="form.status == 2" label="处理人" prop="resolvedAdminName">
          <div>{{ form.resolvedAdminName }}</div>
        </el-form-item>
        <el-form-item v-if="form.status == 2" label="处理结果" prop="resolvedAdminName">
          <dict-tag :options="im_resolved_type" :value="form.resolvedType" />
        </el-form-item>
        <el-form-item v-if="form.status == 2" label="处理摘要" prop="resolvedSummary">
          <div>{{ form.resolvedSummary }}</div>
        </el-form-item>
        <el-form-item v-if="form.status == 2" label="处理时间" prop="resolvedTime">
          <div>{{ form.resolvedTime }}</div>
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button v-hasPermi="['im:complaint:reslove']" type="primary" @click="handleReslove(form)">{{ form.status
            == 1 ? '处 理' : '重新处理' }}</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>
    <!-- 处理投诉对话框 -->
    <el-dialog :title="resloveDialog.title" v-model="resloveDialog.visible" width="600px" append-to-body>
      <el-form ref="resloveFormRef" :model="resloveForm" :rules="resloveRules" label-width="80px">
        <el-form-item label="处理结果" prop="resolvedType">
          <el-select v-model="resloveForm.resolvedType" clearable>
            <el-option v-for="dict in im_resolved_type" :key="dict.value" :label="dict.label" :value="dict.value" />
          </el-select>
        </el-form-item>
        <el-form-item label="处理摘要" prop="resolvedSummary">
          <el-input v-model="resloveForm.resolvedSummary" type="textarea" :rows="8" placeholder="补充处理内容" />
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="resloveSubmit()">确 定</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="UserComplaint" lang="ts">
import { listUserComplaint, getUserComplaint, resloveUserComplaint } from '@/api/im/complaint';
import { UserComplaintVO, UserComplaintQuery, UserComplaintForm } from '@/api/im/complaint/types';

const { proxy } = getCurrentInstance() as ComponentInternalInstance;
const complaintList = ref<UserComplaintVO[]>([]);
const loading = ref(true);
const showSearch = ref(true);
const total = ref(0);
const queryFormRef = ref<ElFormInstance>();
const detailFormRef = ref<ElFormInstance>();
const resloveFormRef = ref<ElFormInstance>();
const resloveForm = ref<UserComplaintForm>();
const resloveRules = reactive<ElFormRules>({
  resolvedType: [
    { required: true, message: "请选择处理结果", trigger: "blur" }
  ]
})

const dialog = reactive<DialogOption>({
  visible: false,
  title: '用户投诉'
});

const resloveDialog = reactive<DialogOption>({
  visible: false,
  title: '处理投诉'
});
const initFormData: UserComplaintForm = {
  id: undefined,
  userId: undefined,
  userName: undefined,
  targetType: undefined,
  targetId: undefined,
  targetName: undefined,
  type: undefined,
  images: undefined,
  status: undefined,
  content: undefined,
  createTime: undefined
}
const data = reactive<PageData<UserComplaintForm, UserComplaintQuery>>({
  form: { ...initFormData },
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    userId: undefined,
    status: undefined
  },
  rules: {}
});

const { queryParams, form } = toRefs(data);

const { im_complaint_type } = toRefs<any>(proxy?.useDict('im_complaint_type'));
const { im_complaint_target_type } = toRefs<any>(proxy?.useDict('im_complaint_target_type'));
const { im_complaint_status } = toRefs<any>(proxy?.useDict('im_complaint_status'));
const { im_resolved_type } = toRefs<any>(proxy?.useDict('im_resolved_type'));

/** 查询用户投诉列表 */
const getList = async () => {
  loading.value = true;
  const res = await listUserComplaint(queryParams.value);
  complaintList.value = res.rows;
  total.value = res.total;
  loading.value = false;
}

/** 取消按钮 */
const cancel = () => {
  dialog.visible = false;
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

const handleDetail = async (row: UserComplaintVO) => {
  const res = await getUserComplaint(row.id);
  form.value = { ...initFormData };
  Object.assign(form.value, res.data)
  dialog.visible = true;
}

const handleReslove = async (row: UserComplaintVO) => {
  resloveForm.value = initFormData;
  resloveForm.value.id = row.id
  resloveForm.value.resolvedType = row.resolvedType
  resloveForm.value.resolvedSummary = row.resolvedSummary
  resloveDialog.visible = true;
}

const resloveSubmit = async () => {
  resloveFormRef.value?.validate(async (valid: boolean) => {
    if (valid) {
      resloveUserComplaint(resloveForm.value).then(async () => {
        resloveDialog.visible = false;
        // 如果是在详情页发起的处理，需要刷新详情页面
        if (dialog.visible) {
          const res = await getUserComplaint(resloveForm.value.id);
          Object.assign(form.value, res.data);
        }
        getList();
        ElMessage.success("处理成功");
      })
    }
  })
}

onMounted(() => {
  getList();
});
</script>

<style scoped lang="scss">
.tag {
  margin-left: 5px;
}

.form-images {
  display: flex;
  flex-wrap: wrap;

  .el-image {
    margin: 5px;
  }
}
</style>
