<template>
  <div class="app-container">
    <el-card>
      <div style="margin-bottom: 12px; display:flex; gap:12px; align-items:center;">
        <el-input v-model.number="parentId" placeholder="父级ID" style="width:180px" />
        <el-button type="primary" @click="load">查询</el-button>
        <el-button type="success" @click="openCreate">新增分类</el-button>
      </div>
      <el-table :data="list" border>
        <el-table-column prop="id" label="ID" width="80" />
        <el-table-column prop="parentId" label="父级ID" width="100" />
        <el-table-column prop="name" label="名称" />
        <el-table-column prop="sortOrder" label="排序" width="90" />
        <el-table-column prop="status" label="状态" width="90" />
        <el-table-column label="操作" width="220">
          <template #default="scope">
            <el-button size="small" @click="openEdit(scope.row)">编辑</el-button>
            <el-button size="small" type="danger" @click="remove(scope.row.id)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>

    <el-dialog v-model="dialogVisible" :title="dialogTitle" width="500px">
      <el-form :model="form">
        <el-form-item label="名称"><el-input v-model="form.name" /></el-form-item>
        <el-form-item label="父级ID"><el-input v-model.number="form.parentId" /></el-form-item>
        <el-form-item label="排序"><el-input v-model.number="form.sortOrder" /></el-form-item>
        <el-form-item label="状态"><el-switch v-model="statusOn" /></el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible=false">取消</el-button>
        <el-button type="primary" @click="submit">保存</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { listCategories, createCategory, updateCategory, deleteCategory } from '@/api/mall/admin'

const list = ref<any[]>([])
const parentId = ref<number | undefined>(undefined)
const dialogVisible = ref(false)
const dialogTitle = ref('')
const form = ref<any>({ id: undefined, name: '', parentId: undefined, sortOrder: 0, status: 1 })
const statusOn = ref(true)

async function load(){
  const res:any = await listCategories(parentId.value)
  list.value = res.data || []
}

function openCreate(){
  dialogTitle.value = '新增分类'
  form.value = { id: undefined, name: '', parentId: parentId.value, sortOrder: 0, status: 1 }
  statusOn.value = true
  dialogVisible.value = true
}

function openEdit(row:any){
  dialogTitle.value = '编辑分类'
  form.value = { ...row }
  statusOn.value = row.status === 1
  dialogVisible.value = true
}

async function submit(){
  if (!form.value.name) { ElMessage.error('请输入名称'); return }
  form.value.status = statusOn.value ? 1 : 0
  if (!form.value.id) {
    await createCategory({ name: form.value.name, parentId: form.value.parentId, sortOrder: form.value.sortOrder })
  } else {
    await updateCategory(form.value.id, { name: form.value.name, parentId: form.value.parentId, sortOrder: form.value.sortOrder, status: form.value.status })
  }
  dialogVisible.value = false
  await load()
}

async function remove(id:number){
  await deleteCategory(id)
  await load()
}

load()
</script>

<style scoped>
.app-container{ padding:16px }
</style>