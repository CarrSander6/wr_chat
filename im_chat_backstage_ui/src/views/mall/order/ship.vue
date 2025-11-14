<template>
  <div class="app-container">
    <el-card>
      <el-form :inline="true" :model="form">
        <el-form-item label="订单ID"><el-input v-model.number="form.orderId" /></el-form-item>
        <el-form-item label="承运商"><el-input v-model="form.carrier" /></el-form-item>
        <el-form-item label="运单号"><el-input v-model="form.shippingNo" /></el-form-item>
        <el-form-item><el-button type="primary" @click="submit">发货</el-button></el-form-item>
      </el-form>
    </el-card>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { shipOrder } from '@/api/mall/admin'

const form = ref<any>({ orderId: undefined, carrier: '', shippingNo: '' })

async function submit(){
  if(!form.value.orderId || !form.value.carrier || !form.value.shippingNo){ ElMessage.error('请填写完整信息'); return }
  await shipOrder(form.value)
  ElMessage.success('发货成功')
}
</script>

<style scoped>
.app-container{ padding:16px }
</style>