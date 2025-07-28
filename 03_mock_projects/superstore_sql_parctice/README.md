# Superstore SQL Practice

本项目基于 Kaggle 的 **Superstore 数据集**，使用 MySQL 完成了一系列 SQL 练习，目标是从基础查询到进阶分析，逐步熟悉数据分析的完整过程。

## 项目内容

1. **数据准备**
   - 使用 DBeaver 将 Kaggle Superstore CSV 数据导入 MySQL
   - 对列名进行规范化处理（snake_case）
   - 部分字段类型调整（日期字段原为字符串）

2. **SQL 练习题**
   - **阶段一（已完成）**
     - 共 23 道题，内容涵盖：
       - 基础查询与 DISTINCT
       - 统计指标（COUNT / SUM / AVG）
       - 分组与排序
       - 条件过滤（WHERE / HAVING）
       - 日期处理与计算
       - 窗口函数入门（RANK/DENSE_RANK）
     - 见 `01_queries.sql`
   - **阶段二（计划中）**
     - 时间序列分析（月度趋势）
     - 客户行为分析（复购率、留存）
     - 利润率结构和排名

3. **目录结构**
superstore_sql_practice/
README.md
01_queries.sql
export/orders_sample.csv


4. **数据集来源**
Kaggle: [Superstore Dataset](https://www.kaggle.com/datasets/vivek468/superstore-dataset-final)

## 如何使用

1. 创建数据库并导入数据
2. 打开 `01_queries.sql`，按题号逐条执行
3. 可在 DBeaver 或其他 SQL 客户端查看结果



---

**作者**：AureSong  
**仓库**：[sql-projects](https://github.com/你的GitHub账户/sql-projects)