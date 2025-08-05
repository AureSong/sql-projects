# Superstore SQL Practice

本项目基于 Kaggle 的 **Superstore 数据集**，使用 MySQL 完成了 43 道 SQL 实战题目，内容从基础查询到进阶分析，涵盖客户、产品、利润等多维度分析目标，逐步构建数据分析思维与实战能力。

## 项目内容

1. **数据准备**
- 使用 DBeaver 将 Kaggle Superstore CSV 数据导入 MySQL
- 对列名进行规范化处理（如用 snake_case 命名）
- 字段类型调整（如日期字段由字符串转为 `DATE` 类型）

2. **SQL 练习题**

- **阶段一（已完成）**：23 道基础题  
  - SELECT 基础语法、聚合函数、GROUP BY、HAVING、ORDER BY、日期函数等  
  - 详见：`01_queries.sql`

- **阶段二（已完成）**：20 道进阶题  
  - 包含时间序列分析、复购率计算、客户留存、排名与分层分析、窗口函数等  
  - 详见：`02_queries.sql`  
  - 配套说明文档：`03_superstore_report.pdf`

3. **目录结构**

```bash
superstore_sql_practice/
│
├── 00_orders_sample.csv              # 示例数据
├── 01_queries.sql               # 阶段一：基础题
├── 02_queries.sql               # 阶段二：进阶题
├── 03_superstore_report.pdf         # SQL 报告 Word 转 PDF，含图文解读
└── README.md                 # 项目说明文件

4. **数据集来源**
Kaggle: [Superstore Dataset](https://www.kaggle.com/datasets/vivek468/superstore-dataset-final)

## 如何使用

- 在 MySQL 中创建数据库并导入 orders_sample.csv
- 使用 DBeaver 等客户端运行 01_queries.sql 和 02_queries.sql，查看查询效果
- 阅读 03_superstore_report.pdf 了解分析逻辑、SQL 思路和业务解读



---

作者信息
作者：AureSong
GitHub：[sql-projects](https://github.com/AureSong/sql-projects)
联系方式：如需合作或交流，请通过 GitHub issue 留言。

License
本项目代码与内容遵循 MIT License，欢迎引用与再创作。