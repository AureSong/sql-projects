-- Superstore SQL Practice
-- 阶段二：20 道练习题
-- 数据表: orders

-- 1 按月统计销售额和利润额
WITH orders_clean AS (
    SELECT STR_TO_DATE(order_date, '%m/%d/%Y') AS order_dt,
        sales,
        profit
    FROM orders
)
SELECT DATE_FORMAT(order_dt, '%Y-%m') AS ym,
    SUM(sales) AS total_sales,
    SUM(profit) As total_profit
FROM orders_clean
GROUP BY DATE_FORMAT(order_dt, '%Y-%m')
ORDER BY ym;

-- 2 按季度统计利润率（profit ÷ sales）
WITH orders_clean AS (
    SELECT STR_TO_DATE(order_date, '%m/%d/%Y') AS order_dt,
        sales, 
        profit
    FROM orders
)
SELECT YEAR(order_dt) AS order_year,
    QUARTER(order_dt) AS order_quarter,
    ROUND(SUM(profit) / SUM(sales), 2) AS profit_rate
FROM orders_clean
GROUP BY YEAR(order_dt), QUARTER(order_dt)
ORDER BY order_year, order_quarter;

-- 3 找出年度销售额最高的年份
WITH orders_by_year AS (
    SELECT YEAR(STR_TO_DATE(order_date, '%m/%d/%Y')) AS order_year,
        SUM(sales) AS sales_year,
        SUM(profit) AS profit_year
    FROM orders
    GROUP BY YEAR(STR_TO_DATE(order_date, '%m/%d/%Y'))
),
orders_by_year_rnk AS (
    SELECT order_year, sales_year, profit_year,
        RANK() OVER (ORDER BY sales_year DESC) AS rnk
    FROM orders_by_year 
)
SELECT order_year, sales_year, profit_year
FROM orders_by_year_rnk
WHERE rnk = 1
ORDER BY order_year;

-- 4 每年的增长率（销售额环比年度增长率）
WITH orders_by_year AS (
    SELECT YEAR(STR_TO_DATE(order_date, '%m/%d/%Y')) AS order_year,
        SUM(sales) AS total_sales
    FROM orders
    GROUP BY YEAR(STR_TO_DATE(order_date, '%m/%d/%Y'))
),
    orders_by_year_2 AS (
        SELECT order_year, 
            total_sales,
            LAG(total_sales) OVER (ORDER BY order_year) AS total_sales_lag
        FROM orders_by_year 
    )
SELECT order_year, total_sales, total_sales_lag,
    ROUND((total_sales - total_sales_lag ) / total_sales_lag , 2) AS year_by_year_growth
FROM orders_by_year_2 
ORDER BY order_year;

-- 5 按月销售趋势图数据
WITH orders_clean AS (
    SELECT STR_TO_DATE(order_date, '%m/%d/%Y') AS order_dt,
        sales
    FROM orders
),
    orders_by_month AS (
        SELECT DATE_FORMAT(order_dt, '%Y-%m') AS ym,
            SUM(sales) AS total_sales
        FROM orders_clean 
        GROUP BY DATE_FORMAT(order_dt, '%Y-%m')
),
    orders_by_month_2 AS (
        SELECT ym, 
            total_sales,
            LAG(total_sales) OVER (ORDER BY ym) AS total_sales_prev_month,
            LAG(total_sales, 12) OVER (ORDER BY ym) AS total_sales_prev_year
        FROM orders_by_month
)
SELECT ym, 
    total_sales,
    ROUND((total_sales - total_sales_prev_month) / total_sales_prev_month, 2) AS mom_growth,
    ROUND((total_sales - total_sales_prev_year) / total_sales_prev_year, 2) AS yoy_growth
FROM orders_by_month_2 
ORDER BY ym;

-- 6 每个 region 内销售额排名前 3 的城市
WITH orders_by_city AS (
    SELECT region, city,
        SUM(sales) AS total_sales
    FROM orders
    GROUP BY region, city
),
orders_by_city_rnk AS (
    SELECT region, city, total_sales,
        DENSE_RANK() OVER (PARTITION BY region ORDER BY total_sales DESC) AS rnk
    FROM orders_by_city 
)
SELECT region, city, total_sales, rnk
FROM orders_by_city_rnk 
WHERE rnk <= 3
ORDER BY region, rnk, city;

-- 7 按产品计算销售额，并列出排名（不分组后再排序）
WITH orders_by_product AS (
    SELECT product_id, 
        SUM(sales) AS total_sales
    FROM orders
    GROUP BY product_id
)
SELECT product_id, total_sales,
    RANK() OVER (ORDER BY total_sales DESC) AS rnk
FROM orders_by_product
ORDER BY rnk, product_id;

-- 8 计算每个月的利润率变化趋势
WITH orders_clean AS (
    SELECT STR_TO_DATE(order_date, '%m/%d/%Y') AS order_dt,
        sales,
        profit
    FROM orders
),
    orders_by_month AS (
        SELECT DATE_FORMAT(order_dt, '%Y-%m') AS ym,
            ROUND(SUM(profit) / SUM(sales), 2) AS profit_margin
        FROM orders_clean
        GROUP BY DATE_FORMAT(order_dt, '%Y-%m')
    )
SELECT ym,
    profit_margin,
    LAG(profit_margin) OVER(ORDER BY ym) AS profit_margin_prev_month,
    profit_margin - (LAG(profit_margin) OVER(ORDER BY ym)) AS profit_margin_month_diff
FROM orders_by_month 
ORDER BY ym;

-- 9 在每个类别（category）中，找出利润额最高的子类别（sub-category）
WITH orders_by_sub_category AS (
    SELECT category, sub_category,
        SUM(profit) AS total_profit
    FROM orders
    GROUP BY category, sub_category 
),
orders_by_sub_category_rnk AS (
    SELECT category, sub_category, total_profit,
        RANK() OVER (PARTITION BY category ORDER BY total_profit DESC) AS rnk
    FROM orders_by_sub_category
)
SELECT category, sub_category, total_profit
FROM orders_by_sub_category_rnk
WHERE rnk = 1
ORDER BY category, sub_category;

-- 10 找出销售额超过所在 region 平均值的城市
WITH orders_by_city AS (
    SELECT region, city,
        SUM(sales) AS total_sales
    FROM orders
    GROUP BY region, city
),
    orders_by_city_2 AS(
    SELECT region, city, total_sales,
        AVG(total_sales) OVER (PARTITION BY region) AS sales_avg
    FROM orders_by_city
)
SELECT region, city, total_sales, sales_avg
FROM orders_by_city_2
WHERE total_sales > sales_avg
ORDER BY region, city;

-- 11 统计每个客户的总销售额、下单次数
-- 输出：customer_id、订单数、销售额，按销售额倒序排列
SELECT customer_id, 
    SUM(sales) AS total_sales,
    COUNT(DISTINCT order_id) AS order_count   
FROM orders
GROUP BY customer_id 
ORDER BY total_sales DESC, customer_id;

-- 12 找出下单超过 5 次的老客户
SELECT customer_id, 
    COUNT(DISTINCT order_id) AS order_count
FROM orders
GROUP BY customer_id 
HAVING order_count > 5
ORDER BY order_count DESC, customer_id;

-- 13 计算客户复购率(>=2单为复购)
SELECT
    ROUND(
        SUM(CASE WHEN order_count >= 2 THEN 1 ELSE 0 END ) / COUNT(*),2
    ) AS repurchase_rate
FROM (
    SELECT customer_id, COUNT(DISTINCT order_id) AS order_count
    FROM orders
    GROUP BY customer_id
) AS t;

-- 14 按年份统计客户数，计算每年新增客户数
WITH orders_clean AS (
    SELECT 
        STR_TO_DATE(order_date, '%m/%d/%Y') AS order_dt,
        customer_id
    FROM orders
),
orders_first AS (
    SELECT customer_id,
           order_dt
    FROM (
        SELECT customer_id,
               order_dt,
               ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_dt) AS rn
        FROM orders_clean
    ) t
    WHERE rn = 1
)
SELECT YEAR(order_dt) AS first_order_year,
       COUNT(customer_id) AS customer_count
FROM orders_first
GROUP BY YEAR(order_dt)
ORDER BY first_order_year;

-- 15 客户留存分析（跨年份购买）
WITH orders_clean AS (
    SELECT customer_id, 
        STR_TO_DATE(order_date, '%m/%d/%Y') AS order_dt
    FROM orders
),
orders_by_year AS ( 
    SELECT customer_id, 
        YEAR(order_dt) AS order_year
    FROM orders_clean
)
SELECT customer_id,
    GROUP_CONCAT(DISTINCT order_year ORDER BY order_year) AS purchase_years,
    COUNT(DISTINCT order_year) AS year_count,
    CASE WHEN COUNT(DISTINCT order_year) >= 2 THEN 'Yes' ELSE 'No' END AS is_cross_year
FROM orders_by_year 
GROUP BY customer_id
ORDER BY customer_id;

-- 16 找出最忠诚的前 10 个客户
WITH orders_clean AS ( 
    SELECT customer_id, 
        order_id,
        YEAR(STR_TO_DATE(order_date, '%m/%d/%Y' )) AS order_year,
        sales
    FROM orders
)
SELECT customer_id,
    COUNT(DISTINCT order_id) AS order_count,
    SUM(sales) AS total_sales
FROM orders_clean 
GROUP BY customer_id 
HAVING COUNT(DISTINCT order_year) >= 2
ORDER BY order_count DESC, total_sales DESC
LIMIT 10;

-- 17 按月统计，每个 region 的总销售额、总利润和利润率
WITH orders_clean AS (
    SELECT STR_TO_DATE(order_date, '%m/%d/%Y' ) AS order_dt,
        region,
        sales,
        profit
    FROM orders
)
SELECT region,
    DATE_FORMAT(order_dt, '%Y-%m') AS ym,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND(SUM(profit) / SUM(sales), 2) AS profit_rate
FROM orders_clean 
GROUP BY region, DATE_FORMAT(order_dt, '%Y-%m')
ORDER BY region, ym;
 
-- 18 对比每个 segment 在不同年份的销售额变化（同比）
WITH orders_clean AS ( 
    SELECT segment, 
        STR_TO_DATE(order_date, '%m/%d/%Y') AS order_dt,
        sales
    FROM orders
),
orders_by_segment AS (
    SELECT segment,
        YEAR(order_dt) AS order_year,
        SUM(sales) AS total_sales
    FROM orders_clean
    GROUP BY segment, YEAR(order_dt)
)
SELECT segment,
    order_year,
    total_sales,
    LAG(total_sales) OVER (PARTITION BY segment ORDER BY order_year) AS total_salses_prev_year,
    (total_sales - (LAG(total_sales) OVER (PARTITION BY segment ORDER BY order_year))) 
        / (LAG(total_sales) OVER (PARTITION BY segment ORDER BY order_year)) AS yoy_growth
FROM orders_by_segment 
ORDER BY segment, order_year;

-- 19 客户分层：按总销售额划分客户等级
-- 大客户（前 20%）
-- 中客户（中间 60%）
-- 小客户（后 20%）
WITH orders_by_customer AS (
    SELECT customer_id,
        SUM(sales) AS total_sales
    FROM orders
    GROUP BY customer_id
),
orders_by_customer_rnk AS (
    SELECT customer_id, 
        total_sales,
        PERCENT_RANK() OVER (ORDER BY total_sales DESC) AS rnk
    FROM orders_by_customer
)
SELECT customer_id, 
    total_sales,
    rnk,
    CASE
    	WHEN rnk < 0.2 THEN '大客户'
    	WHEN rnk BETWEEN 0.2 AND 0.8 THEN '中客户'
    	ELSE '小客户'
    END AS customer_level
FROM orders_by_customer_rnk 
ORDER BY rnk, customer_id;

-- 20 每年最赚钱的前 3 个产品（按利润排序）
WITH orders_clean AS (
    SELECT STR_TO_DATE(order_date, '%m/%d/%Y') AS order_dt,
        product_id,
        profit
    FROM orders
),
orders_by_product AS ( 
    SELECT YEAR(order_dt) AS order_year,
        product_id,
        SUM(profit) AS total_profit
    FROM orders_clean 
    GROUP BY YEAR(order_dt), product_id
),
orders_by_product_rnk AS (
    SELECT order_year,
        product_id,
        total_profit,
        DENSE_RANK() OVER (PARTITION BY order_year ORDER BY total_profit DESC) AS rnk
    FROM orders_by_product 
)
SELECT order_year, product_id, total_profit, rnk
FROM orders_by_product_rnk
WHERE rnk <= 3
ORDER BY order_year, rnk, product_id;




