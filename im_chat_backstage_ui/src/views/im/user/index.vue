<template>
  <div class="p-2">
    <transition :enter-active-class="proxy?.animate.searchAnimate.enter"
      :leave-active-class="proxy?.animate.searchAnimate.leave">
      <div v-show="showSearch" class="mb-[10px]">
        <el-card shadow="hover">
          <el-form ref="queryFormRef" :model="queryParams" :inline="true">
            <el-form-item label="用户名" prop="userName">
              <el-input v-model="queryParams.userName" placeholder="请输入用户名" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="用户昵称" prop="nickName">
              <el-input v-model="queryParams.nickName" placeholder="请输入用户昵称" clearable @keyup.enter="handleQuery" />
            </el-form-item>
			<el-form-item label="钱包地址" prop="walletAddress">
			  <el-input v-model="queryParams.walletAddress" placeholder="请输入用户昵称" clearable @keyup.enter="handleQuery" />
			</el-form-item>
            <el-form-item>
              <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
              <el-button icon="Refresh" @click="resetQuery">重置</el-button>
              <el-button type="warning" plain icon="Download" @click="handleExport"
                v-hasPermi="['im:user:export']">导出</el-button>
            </el-form-item>
          </el-form>
        </el-card>
      </div>
    </transition>

    <el-card shadow="never">
      <el-table v-loading="loading" :data="userList" @selection-change="handleSelectionChange">
        <el-table-column label="用户名" align="center" prop="userName" />
        <el-table-column label="用户头像" align="center" prop="headImageThumb" width="100">
          <template #default="scope">
            <image-preview v-if="scope.row.headImageThumb" :src="scope.row.headImageThumb"
              :full-src="scope.row.headImage" :width="50" :height="50" />
          </template>
        </el-table-column>
        <el-table-column label="用户昵称" align="center" prop="nickName" />
		<el-table-column label="钱包地址" align="center" prop="walletAddress" width="200" />
		<el-table-column label="usdt" align="center" prop="balance" />
        <el-table-column label="用户类型" align="center" prop="type" sortable>
          <template #default="scope">
            <dict-tag :options="im_user_type" :value="scope.row.type" />
          </template>
        </el-table-column>
        <el-table-column label="性别" align="center" prop="sex">
          <template #default="scope">
            <dict-tag :options="sys_user_sex" :value="scope.row.sex" />
          </template>
        </el-table-column>
        <el-table-column label="标签" align="center">
          <template #default="scope">
            <el-tag v-if="scope.row.status == 1" class="tag" type="danger">已注销</el-tag>
            <el-tag v-if="scope.row.isBanned" class="tag" type="danger">已封禁</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="注册时间" align="center" prop="createdTime" width="180">
          <template #default="scope">
            <span>{{ parseTime(scope.row.createdTime, '{y}-{m}-{d}') }}</span>
          </template>
        </el-table-column>
        <el-table-column label="最后登录时间" align="center" prop="lastLoginTime" width="180">
          <template #default="scope">
            <span>{{ parseTime(scope.row.lastLoginTime, '{y}-{m}-{d}') }}</span>
          </template>
        </el-table-column>
        <el-table-column label="操作" align="center" class-name="small-padding fixed-width" fixed="right" width="400">
          <template #default="scope">
            <!-- <el-button link type="primary" v-hasPermi="['im:user:query']"
              @click="handleDetail(scope.row)">详情</el-button> -->
            <el-button link type="primary" v-hasPermi="['business:banner:edit']"
              @click="handleUpdate(scope.row)">修改</el-button>
            <el-button link type="warning" v-hasPermi="['business:banner:edit']"
              @click="handleUpdatePassword(scope.row)">修改密码</el-button>
            <el-button v-if="scope.row.isBanned" link type="danger" v-hasPermi="['business:banner:edit']"
              @click="unbanHandle(scope.row)">解封</el-button>
            <el-button v-else link type="danger" v-hasPermi="['business:banner:edit']"
              @click="banHandle(scope.row)">封禁</el-button>
          </template>
        </el-table-column>
      </el-table>

      <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum"
        v-model:limit="queryParams.pageSize" @pagination="getList" />
    </el-card>
    <!-- 添加或修改用户对话框 -->
    <el-dialog :title="dialog.title" v-model="dialog.visible" width="600px" append-to-body class="user-dialog">
      <el-form ref="userFormRef" :model="form" :rules="rules" label-width="120px" :disabled="dialog.title === '用户信息'"
        class="user-form">
        <el-form-item label="用户头像" prop="headImage">
          <image-preview :src="form.headImageThumb" :full-src="form.headImage" :width="100" :height="100" />
        </el-form-item>

        <el-form-item label="用户名" prop="userName">
          <el-input v-model="form.userName" placeholder="请输入用户名" clearable />
        </el-form-item>

        <el-form-item label="用户昵称" prop="nickName">
          <el-input v-model="form.nickName" placeholder="请输入用户昵称" clearable />
        </el-form-item>

        <el-form-item label="用户类型" prop="type">
          <el-select v-model="form.type" placeholder="请选择用户类型" clearable style="width: 100%">
            <el-option v-for="dict in im_user_type" :key="dict.value" :label="dict.label" :value="dict.value" />
          </el-select>
        </el-form-item>

        <el-form-item label="性别" prop="sex">
          <template v-if="dialog.title === '用户信息'">
            <dict-tag :options="sys_user_sex" :value="form.sex" />
          </template>
          <template v-else>
            <el-select v-model="form.sex" placeholder="请选择性别" clearable style="width: 100%">
              <el-option v-for="dict in sys_user_sex" :key="dict.value" :label="dict.label" :value="dict.value" />
            </el-select>
          </template>
        </el-form-item>

        <el-form-item label="手机号" prop="phone">
          <el-input v-model="form.phone" placeholder="请输入手机号" clearable />
        </el-form-item>

        <el-form-item label="邮箱" prop="email">
          <el-input v-model="form.email" placeholder="请输入邮箱" clearable />
        </el-form-item>



      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button v-if="dialog.title !== '用户信息'" type="primary" size="default" @click="submitForm">
            <el-icon>
              <Check />
            </el-icon>
            确 定
          </el-button>
          <el-button size="default" @click="dialog.visible = false">
            <el-icon>
              <Close />
            </el-icon>
            取 消
          </el-button>
        </div>
      </template>
    </el-dialog>

    <!-- 修改密码对话框 -->
    <el-dialog title="修改密码" v-model="passwordDialog.visible" width="600px" append-to-body class="password-dialog">
      <el-form ref="passwordFormRef" :model="passwordForm" :rules="passwordRules" label-width="120px"
        class="password-form">
        <el-form-item label="用户名" prop="userName">
          <el-input v-model="passwordForm.userName" disabled />
        </el-form-item>
        <el-form-item label="新密码" prop="password">
          <el-input v-model="passwordForm.password" type="password" placeholder="请输入新密码（6-20位字符）" show-password
            clearable />
        </el-form-item>
        <el-form-item label="确认密码" prop="confirmPassword">
          <el-input v-model="passwordForm.confirmPassword" type="password" placeholder="请再次输入新密码" show-password
            clearable />
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" size="default" @click="submitPasswordForm">
            <el-icon>
              <Check />
            </el-icon>
            确 定
          </el-button>
          <el-button size="default" @click="passwordDialog.visible = false">
            <el-icon>
              <Close />
            </el-icon>
            取 消
          </el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="User" lang="ts">
import { Check, Close } from '@element-plus/icons-vue';
import { listUser, getUser, ban, unban, updateUser, updateUserPassword } from '@/api/im/user';
import { UserVO, UserQuery, UserForm } from '@/api/im/user/types';

const { proxy } = getCurrentInstance() as ComponentInternalInstance;

const userList = ref<UserVO[]>([]);
const loading = ref(true);
const showSearch = ref(true);
const ids = ref<Array<string | number>>([]);
const single = ref(true);
const multiple = ref(true);
const total = ref(0);

const queryFormRef = ref<ElFormInstance>();
const userFormRef = ref<ElFormInstance>();
const dialog = reactive<DialogOption>({
  visible: false,
  title: ''
});

const passwordDialog = reactive<DialogOption>({
  visible: false,
  title: '修改密码'
});

const passwordFormRef = ref<ElFormInstance>();
const passwordForm = ref({
  id: undefined,
  userName: '',
  password: '',
  confirmPassword: ''
});

const initFormData: UserForm = {
  id: undefined,
  userName: undefined,
  nickName: undefined,
  headImage: undefined,
  headImageThumb: undefined,
  password: undefined,
  sex: undefined,
  phone: undefined,
  email: undefined,
  signature: undefined,
  lastLoginTime: undefined,
  createdTime: undefined,
  type: undefined,
  isBanned: undefined,
  reason: undefined,
  cid: undefined,
  status: undefined
}
const data = reactive<PageData<UserForm, UserQuery>>({
  form: { ...initFormData },
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    userName: undefined,
    nickName: undefined,
    params: {
    }
  },
  rules: {
    userName: [
      { required: true, message: '用户名不能为空', trigger: 'blur' }
    ],
    nickName: [
      { required: true, message: '用户昵称不能为空', trigger: 'blur' }
    ]
  },
  passwordRules: {
    password: [
      { required: true, message: '新密码不能为空', trigger: 'blur' },
      { min: 6, max: 20, message: '密码长度在 6 到 20 个字符', trigger: 'blur' }
    ],
    confirmPassword: [
      { required: true, message: '确认密码不能为空', trigger: 'blur' },
      {
        validator: (rule: any, value: any, callback: any) => {
          if (value !== passwordForm.value.password) {
            callback(new Error('两次输入密码不一致'));
          } else {
            callback();
          }
        },
        trigger: 'blur'
      }
    ]
  }
});
const { queryParams, form, rules, passwordRules } = toRefs(data);

const { im_user_type, sys_user_sex, im_user_status, im_bool } = toRefs<any>(proxy?.useDict('im_user_type', 'sys_user_sex', 'im_user_status', 'im_bool'));

/** 查询用户列表 */
const getList = async () => {
  loading.value = true;
  const res = await listUser(queryParams.value);
  userList.value = res.rows;
  total.value = res.total;
  loading.value = false;
  console.log("getList")
}
/** 搜索按钮操作 */
const handleQuery = () => {
  queryParams.value.pageNum = 1;
  getList();
  console.log("handleQuery")
}

/** 重置按钮操作 */
const resetQuery = () => {
  queryFormRef.value?.resetFields();
  handleQuery();
  console.log("handleQuery")
}

/** 多选框选中数据 */
const handleSelectionChange = (selection: UserVO[]) => {
  ids.value = selection.map(item => item.id);
  single.value = selection.length != 1;
  multiple.value = !selection.length;
  console.log("handleSelectionChange")
}

/** 表单重置 */
const reset = () => {
  form.value = { ...initFormData };
  userFormRef.value?.resetFields();
  console.log("reset")
}

/** 修改按钮操作 */
const handleDetail = async (row?: UserVO) => {
  reset();
  const _id = row?.id || ids.value[0]
  const res = await getUser(_id);
  Object.assign(form.value, res.data);
  // 在赋值的时候 后端返回的 type类型 是数字 而字典类型是字符串 所以需要转换
  form.value.type = String(res.data.type);
  // 性别
  form.value.sex = String(res.data.sex);
  dialog.visible = true;
  dialog.title = "用户信息";
}

/** 修改用户信息按钮操作 */
const handleUpdate = async (row?: UserVO) => {
  reset();
  const _id = row?.id || ids.value[0]
  const res = await getUser(_id);
  Object.assign(form.value, res.data);
  // 在赋值的时候 后端返回的 type类型 是数字 而字典类型是字符串 所以需要转换
  form.value.type = String(res.data.type);
  // 性别
  form.value.sex = String(res.data.sex);
  dialog.visible = true;
  dialog.title = "修改用户信息";
}

/** 修改密码按钮操作 */
const handleUpdatePassword = (row: UserVO) => {
  passwordForm.value = {
    id: row.id,
    userName: row.userName,
    password: '',
    confirmPassword: ''
  };
  passwordDialog.visible = true;
}

/** 提交用户信息表单 */
const submitForm = () => {
  userFormRef.value?.validate(async (valid: boolean) => {
    if (valid) {
      try {
        await updateUser(form.value);
        ElMessage.success('修改成功');
        dialog.visible = false;
        await getList();
      } catch (error) {
        ElMessage.error('修改失败');
      }
    }
  });
}

/** 提交密码修改表单 */
const submitPasswordForm = () => {
  passwordFormRef.value?.validate(async (valid: boolean) => {
    if (valid) {
      try {
        await updateUserPassword({
          id: passwordForm.value.id,
          password: passwordForm.value.password
        });
        ElMessage.success('密码修改成功');
        passwordDialog.visible = false;
        passwordForm.value = {
          id: undefined,
          userName: '',
          password: '',
          confirmPassword: ''
        };
      } catch (error) {
        ElMessage.error('密码修改失败');
      }
    }
  });
}

const banHandle = (user: any) => {
  ElMessageBox.prompt('封禁原因:', '确定对该用户进行封禁？', {
    inputPattern: /\S/,
    inputErrorMessage: '请输入封禁原因',
    confirmButtonText: '确定',
    cancelButtonText: '取消'
  }).then(({ value }) => {
    const data = { id: user.id, reason: value }
    ban(data).then(() => {
      user.isBanned = true
      ElMessage.success(`用户'${user.userName}'已被封禁`);
    })
  })
}

const unbanHandle = (user: any) => {
  ElMessageBox.confirm('确定解除该用户的封禁状态？？', '提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消'
  }).then(() => {
    const data = { id: user.id }
    unban(data).then(() => {
      user.isBanned = false
      ElMessage.success(`用户'${user.userName}'解锁成功`);
    })

  })
}

/** 导出按钮操作 */
const handleExport = () => {
  proxy?.download('im/user/export', {
    ...queryParams.value
  }, `user_${new Date().getTime()}.xlsx`)
}


onMounted(() => {
  getList();
});
</script>

<style lang="scss" scoped>
.tag {
  margin-left: 3px;
}
</style>