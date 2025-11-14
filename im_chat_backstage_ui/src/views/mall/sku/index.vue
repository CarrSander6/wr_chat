<template>
  <div class="app-container">
    <el-card>
      <div style="margin-bottom:12px;display:flex;gap:12px;align-items:center;">
        <el-input v-model.number="productId" placeholder="商品ID" style="width:180px" />
        <el-button type="primary" @click="load">查询</el-button>
        <el-button type="success" @click="openCreate">新增SKU</el-button>
      </div>
      <el-table :data="list" border>
        <el-table-column prop="id" label="ID" width="80" />
        <el-table-column prop="productId" label="商品ID" width="100" />
        <el-table-column prop="skuCode" label="编码" />
        <el-table-column prop="attributes" label="属性" />
        <el-table-column prop="price" label="价格" width="120" />
        <el-table-column prop="stock" label="库存" width="100" />
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
        <el-form-item label="商品ID"><el-input v-model.number="form.productId" /></el-form-item>
        <el-form-item label="编码"><el-input v-model="form.skuCode" /></el-form-item>
        <el-form-item label="属性"><el-input v-model="form.attributes" /></el-form-item>
        <el-form-item label="价格"><el-input v-model.number="form.price" /></el-form-item>
        <el-form-item label="库存"><el-input v-model.number="form.stock" /></el-form-item>
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
import { listSkus, addSku, updateSku, deleteSku } from '@/api/mall/admin'

const list = ref<any[]>([])
const productId = ref<number | undefined>(undefined)
const dialogVisible = ref(false)
const dialogTitle = ref('')
const form = ref<any>({ id: undefined, productId: undefined, skuCode: '', attributes: '', price: 0, stock: 0, status: 1 })
const statusOn = ref(true)

async function load(){
  if(!productId.value){ ElMessage.error('请输入商品ID'); return }
  const res:any = await listSkus(productId.value)
  list.value = res.data || []
}

function openCreate(){
  dialogTitle.value = '新增SKU'
  form.value = { id: undefined, productId: productId.value, skuCode: '', attributes: '', price: 0, stock: 0, status: 1 }
  statusOn.value = true
  dialogVisible.value = true
}

function openEdit(row:any){
  dialogTitle.value = '编辑SKU'
  form.value = { ...row }
  statusOn.value = row.status === 1
  dialogVisible.value = true
}

async function submit(){
  if (!form.value.productId || !form.value.skuCode) { ElMessage.error('请填写商品ID与编码'); return }
  form.value.status = statusOn.value ? 1 : 0
  if (!form.value.id) {
    await addSku({ productId: form.value.productId, skuCode: form.value.skuCode, attributes: form.value.attributes, price: form.value.price, stock: form.value.stock })
  } else {
    await updateSku(form.value.id, { attributes: form.value.attributes, price: form.value.price, stock: form.value.stock, status: form.value.status })
  }
  dialogVisible.value = false
  await load()
}

async function remove(id:number){
  await deleteSku(id)
  await load()
}
</script>

<style scoped>
.app-container{ padding:16px }
</style>