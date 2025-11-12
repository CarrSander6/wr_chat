# MySQL 版本兼容性说明

## 快速诊断

### 检查您的MySQL版本
```sql
SELECT VERSION();
```

### 版本对应关系

| 版本范围 | DROP INDEX IF EXISTS | 是否需要修复 |
|---------|---------------------|-------------|
| MySQL 5.5 | ❌ 不支持 | ✅ 需要 |
| MySQL 5.6 | ❌ 不支持 | ✅ 需要 |
| MySQL 5.7 | ❌ 不支持 | ✅ 需要 |
| MySQL 8.0.0-8.0.2 | ❌ 不支持 | ✅ 需要 |
| MySQL 8.0.3+ | ✅ 支持 | 🟢 可选(建议仍用动态SQL) |
| MariaDB 10.1+ | ✅ 支持 | 🟢 可选 |

## 常见错误对照表

### 错误1: 语法错误
```
[ERR] 1064 - You have an error in your SQL syntax; 
check the manual that corresponds to your MySQL server version 
for the right syntax to use near 'IF EXISTS `idx_xxx`'
```
**原因**: 您的MySQL版本 < 8.0.3,不支持 `DROP INDEX IF EXISTS`  
**解决**: 使用本项目修复后的 `db_optimization_and_data.sql` 脚本

### 错误2: 重复索引
```
[ERR] 1061 - Duplicate key name 'idx_xxx'
```
**原因**: 索引已存在,脚本未检查直接创建  
**解决**: 使用本项目修复后的脚本,支持幂等执行

### 错误3: 重复列
```
[ERR] 1060 - Duplicate column name 'xxx'
```
**原因**: 列已存在,脚本未检查直接添加  
**解决**: 使用本项目修复后的脚本,自动跳过已存在的列

## 脚本特性对比

| 特性 | 原始脚本 | 修复后脚本 |
|-----|---------|-----------|
| MySQL 5.7兼容 | ❌ | ✅ |
| MySQL 8.0兼容 | ⚠️ 部分 | ✅ |
| 幂等性(可重复执行) | ❌ | ✅ |
| 索引自动检查 | ❌ | ✅ |
| 列自动检查 | ❌ | ✅ |
| 视图自动删除重建 | ❌ | ✅ |
| 存储过程自动替换 | ❌ | ✅ |

## 执行建议

### 生产环境(推荐)
```bash
# 1. 备份数据库
mysqldump -u root -p im_chat > backup_$(date +%Y%m%d_%H%M%S).sql

# 2. 测试执行(先在测试库)
mysql -u root -p im_chat_test < db_optimization_and_data.sql

# 3. 验证无误后执行生产库
mysql -u root -p im_chat < db_optimization_and_data.sql

# 4. 验证索引创建
mysql -u root -p im_chat -e "SHOW INDEX FROM im_user_match_record"
```

### 开发环境(快速)
```bash
# PowerShell
Get-Content "d:\code\wurun\wr_chat\im_chat_server\db_optimization_and_data.sql" | mysql -u root -p im_chat

# CMD
type "d:\code\wurun\wr_chat\im_chat_server\db_optimization_and_data.sql" | mysql -u root -p im_chat
```

## 验证清单

执行脚本后,运行以下SQL验证:

### ✅ 检查索引是否创建
```sql
-- 应该看到 idx_user_action_time, idx_target_user 等索引
SHOW INDEX FROM im_user_match_record;
SHOW INDEX FROM im_distribution_commission;
SHOW INDEX FROM im_mall_order;
```

### ✅ 检查列是否添加
```sql
-- 应该看到 interests, age, city, profile_score, last_match_time 等列
DESC im_user;
```

### ✅ 检查视图是否创建
```sql
-- 应该看到 v_distributor_commission_summary, v_product_sales_summary, v_user_match_summary
SHOW FULL TABLES WHERE TABLE_TYPE = 'VIEW';
```

### ✅ 检查存储过程是否创建
```sql
-- 应该看到 sp_clean_expired_orders, sp_daily_distributor_stats
SHOW PROCEDURE STATUS WHERE Db = 'im_chat';
```

### ✅ 检查事件是否创建
```sql
-- 应该看到 evt_clean_expired_orders
SHOW EVENTS FROM im_chat;
```

## 性能验证

### 验证索引生效
```sql
-- 查看执行计划,应该使用 idx_user_action_time 索引
EXPLAIN SELECT * FROM im_user_match_record 
WHERE user_id = 1 
  AND action_type = 1 
ORDER BY created_time DESC;

-- type 应该是 ref 或 range
-- key 应该显示 idx_user_action_time
-- Extra 不应该出现 Using filesort
```

### 查询响应时间对比
```sql
-- 开启慢查询日志(可选)
SET GLOBAL slow_query_log = 'ON';
SET GLOBAL long_query_time = 0.5; -- 超过0.5秒记录

-- 执行测试查询
SELECT * FROM im_user_match_record 
WHERE user_id = 1 
ORDER BY created_time DESC 
LIMIT 20;

-- 检查执行时间应显著降低
```

## 常见问题

### Q1: 脚本执行很慢怎么办?
**A**: 这是正常的,动态SQL需要查询 information_schema,如果表很多会较慢。建议:
- 在数据量小的时候执行(如凌晨)
- 分段执行(先执行索引部分,再执行其他部分)

### Q2: 能否跳过某些对象的创建?
**A**: 可以,注释掉对应的SQL语句即可。例如:
```sql
-- 不需要创建视图,注释掉这部分
-- DROP VIEW IF EXISTS `v_distributor_commission_summary`;
-- CREATE VIEW `v_distributor_commission_summary` AS ...
```

### Q3: 如何回滚已执行的脚本?
**A**: 手动删除创建的对象:
```sql
-- 删除索引
ALTER TABLE im_user_match_record DROP INDEX idx_user_action_time;

-- 删除列
ALTER TABLE im_user DROP COLUMN interests;

-- 删除视图
DROP VIEW v_distributor_commission_summary;

-- 删除存储过程
DROP PROCEDURE sp_clean_expired_orders;

-- 删除事件
DROP EVENT evt_clean_expired_orders;
```

### Q4: MariaDB需要修复吗?
**A**: MariaDB 10.1+ 支持 `DROP INDEX IF EXISTS`,但为了代码统一和可维护性,仍建议使用修复后的脚本。

## 技术支持

- 查看详细文档: `SQL脚本修复说明.md`
- 项目文档: `docs/项目说明文档.md`
- API文档: `docs/API测试指南.md`

---

**最后更新**: 2025-01-12  
**适用版本**: MySQL 5.5+, MySQL 8.0+, MariaDB 10.1+
