<template>
  <el-card shadow="hover" class="stat-card" :class="`stat-card-${type}`">
    <div class="stat-content">
      <div class="stat-icon" :style="{ backgroundColor: color }">
        <component :is="icon" :size="iconSize" />
      </div>
      <div class="stat-info">
        <div class="stat-value">{{ value }}</div>
        <div class="stat-label">{{ label }}</div>
        <div v-if="change" class="stat-change" :class="changeClass">
          <el-icon><component :is="changeIcon" /></el-icon>
          <span>{{ Math.abs(change) }}%</span>
        </div>
      </div>
    </div>
  </el-card>
</template>

<script setup lang="ts">
import { computed } from 'vue';
import { ArrowUp, ArrowDown } from '@element-plus/icons-vue';

interface Props {
  label: string;
  value: string | number;
  icon?: any;
  color?: string;
  type?: 'primary' | 'success' | 'warning' | 'danger' | 'info';
  change?: number;
  iconSize?: number;
}

const props = withDefaults(defineProps<Props>(), {
  color: '#409EFF',
  type: 'primary',
  change: 0,
  iconSize: 30
});

const changeClass = computed(() => {
  if (props.change > 0) return 'is-increase';
  if (props.change < 0) return 'is-decrease';
  return '';
});

const changeIcon = computed(() => {
  return props.change > 0 ? ArrowUp : ArrowDown;
});
</script>

<style scoped lang="scss">
.stat-card {
  cursor: default;
  transition: all 0.3s ease;

  &:hover {
    transform: translateY(-5px);
    box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15) !important;
  }

  :deep(.el-card__body) {
    padding: 20px;
  }

  .stat-content {
    display: flex;
    align-items: center;
    gap: 20px;
  }

  .stat-icon {
    width: 60px;
    height: 60px;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    flex-shrink: 0;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  }

  .stat-info {
    flex: 1;
    min-width: 0;
  }

  .stat-value {
    font-size: 28px;
    font-weight: bold;
    color: #303133;
    line-height: 1.2;
    margin-bottom: 4px;
  }

  .stat-label {
    font-size: 14px;
    color: #909399;
    margin-bottom: 8px;
  }

  .stat-change {
    display: inline-flex;
    align-items: center;
    gap: 4px;
    font-size: 12px;
    font-weight: 500;

    &.is-increase {
      color: #67C23A;
    }

    &.is-decrease {
      color: #F56C6C;
    }
  }
}
</style>
