<template>
  <div class="app-container">
    <el-card>
      <div style="margin-bottom:12px;display:flex;gap:12px;align-items:center;">
        <el-select v-model="status" placeholder="状态" style="width:180px">
          <el-option label="全部" :value="undefined" />
          <el-option label="待审核" :value="0" />
          <el-option label="通过" :value="1" />
          <el-option label="拒绝" :value="2" />
        </el-select>
        <el-button type="primary" @click="load">查询</el-button>
      </div>
      <el-table :data="list" border>
        <el-table-column prop="id" label="ID" width="80" />
        <el-table-column prop="orderId" label="订单ID" width="100" />
        <el-table-column prop="userId" label="用户ID" width="100" />
        <el-table-column prop="reason" label="原因" />
        <el-table-column prop="status" label="状态" width="90" />
        <el-table-column prop="createdTime" label="创建时间" width="180" />
        <el-table-column label="操作" width="220">
          <template #default="scope">
            <el-button size="small" type="success" @click="approve(scope.row.id)" :disabled="scope.row.status!==0">通过</el-button>
            <el-button size="small" type="danger" @click="reject(scope.row.id)" :disabled="scope.row.status!==0">拒绝</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { listAfterSales, approveAfterSale, rejectAfterSale } from '@/api/mall/admin'

const list = ref<any[]>([])
const status = ref<number | undefined>(undefined)

async function load(){
  const res:any = await listAfterSales({ status: status.value, pageNum: 1, pageSize: 20 })
  list.value = res.data || []
}

async function approve(id:number){
  await approveAfterSale(id)
  await load()
}

async function reject(id:number){
  await rejectAfterSale(id)
  await load()
}

load()
</script>

<style scoped>
.app-container{ padding:16px }
</style>