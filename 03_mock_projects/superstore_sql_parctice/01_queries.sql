-- Superstore SQL Practice
-- 阶段一：23 道练习题
-- 数据表: orders

-- 1. 显示表中前 10 条记录
SELECT * 
FROM orders 
LIMIT 10;

-- 2. 查看有多少不同的运输方式 ship_mode
SELECT DISTINCT ship_mode 
FROM orders 
ORDER BY ship_mode;

-- 3. 查询所有唯一的 region 和 segment
SELECT DISTINCT region, segment 
FROM orders 
ORDER BY region, segment;

-- 4. 统计订单总数、总销售额、总利润
SELECT COUNT(DISTINCT order_id), SUM(sales), SUM(profit)
FROM orders;

-- 5. 每个 ship_mode 的订单数量
SELECT ship_mode, COUNT(DISTINCT order_id) AS order_count
FROM orders
GROUP BY ship_mode
ORDER BY ship_mode;

-- 6. 每个 region 的销售额
SELECT region, SUM(sales)
FROM orders
GROUP BY region
ORDER BY region;

-- 7. 按 region 分组，计算总销售额和总利润
SELECT region, SUM(sales), SUM(profit)
FROM orders
GROUP BY region
ORDER BY region;

-- 8. 找出销售额最高的前 5 个 product_name
SELECT product_name, SUM(sales) AS product_sales
FROM orders
GROUP BY product_name
ORDER BY product_sales DESC
LIMIT 5;

-- 9. 每个 category 的平均折扣
SELECT category, SUM(sales * discount) / SUM(sales) AS discount_avg
FROM orders
GROUP BY category
ORDER BY category;

-- 10. 找出利润为负的订单记录
SELECT order_id, SUM(profit) AS order_profit
FROM orders
GROUP BY order_id
HAVING SUM(profit) < 0
ORDER BY order_id;

-- 11. 统计销售额 > 500 的订单数量
SELECT COUNT(*)
FROM (
    SELECT order_id
    FROM orders
    GROUP BY order_id
    HAVING SUM(sales) > 500
) t;

-- 12. 找出 ship_mode = 'Second Class' 且利润小于 0 的订单明细
SELECT o.*
FROM orders o
JOIN (
    SELECT order_id
    FROM orders
    WHERE ship_mode = 'Second Class'
    GROUP BY order_id
    HAVING SUM(profit) < 0
) t ON o.order_id = t.order_id
ORDER BY o.row_id;

-- 13. 每年订单数（从 order_date 提取年份）
SELECT YEAR(STR_TO_DATE(order_date,'%m/%d/%Y')) AS orders_year,
       COUNT(DISTINCT order_id) AS count_order
FROM orders
GROUP BY YEAR(STR_TO_DATE(order_date,'%m/%d/%Y'))
ORDER BY orders_year;

-- 14. 计算发货天数 ship_date - order_date，找出发货时间最长的前 10 个订单
SELECT order_id,
       DATEDIFF(STR_TO_DATE(ship_date,'%m/%d/%Y'), STR_TO_DATE(order_date,'%m/%d/%Y')) AS shipping_days
FROM orders
ORDER BY shipping_days DESC, order_id
LIMIT 10;

-- 15. 每个 region, segment 的总销售额
SELECT region, segment, SUM(sales)
FROM orders
GROUP BY region, segment
ORDER BY region, segment;

-- 16. 每个 city 的销售额与利润，按利润降序
SELECT city, SUM(sales) AS city_sales, SUM(profit) AS city_profit
FROM orders
GROUP BY city
ORDER BY city_profit DESC, city;

-- 17. 找出销售额排名前 10 的客户
SELECT customer_id, SUM(sales) AS customer_sales
FROM orders
GROUP BY customer_id
ORDER BY customer_sales DESC, customer_id
LIMIT 10;

-- 18. 每个 product_id 的总销售额，并按总销售额排序
SELECT product_id, SUM(sales) AS product_sales
FROM orders
GROUP BY product_id
ORDER BY product_sales DESC, product_id;

-- 19. 哪个 category 的平均利润率 (SUM(profit)/SUM(sales)) 最高
SELECT category,
       SUM(profit) / SUM(sales) AS profit_avg
FROM orders
GROUP BY category
ORDER BY profit_avg DESC
LIMIT 1;

-- 20. 每个 region 内销售额排名前三的城市
WITH orders_city AS (
    SELECT region, city, SUM(sales) AS sales_city
    FROM orders
    GROUP BY region, city
)
SELECT region, city, sales_city, rank_city
FROM (
    SELECT region, city, sales_city,
           DENSE_RANK() OVER (PARTITION BY region ORDER BY sales_city DESC) AS rank_city
    FROM orders_city
) t
WHERE rank_city <= 3
ORDER BY region, rank_city, city;

-- 21. 使用 RANK()，按销售额给所有 product_id 排名
SELECT product_id, rank_product, sales_product
FROM (
    SELECT product_id, SUM(sales) AS sales_product,
           RANK() OVER (ORDER BY SUM(sales) DESC) AS rank_product
    FROM orders
    GROUP BY product_id
) t
ORDER BY rank_product, product_id;

-- 22. 每个 region, segment 的订单数、销售额、利润、平均折扣
SELECT region, segment,
       COUNT(DISTINCT order_id) AS count_order,
       SUM(sales) AS sales_region_segment,
       SUM(profit) AS profit_region_segment,
       SUM(sales * discount) / SUM(sales) AS discount_avg
FROM orders
GROUP BY region, segment
ORDER BY profit_region_segment DESC, region, segment;

-- 23. 找出销售额占比最高的前 3 个 category
WITH orders_category AS (
    SELECT category, SUM(sales) AS sales_category
    FROM orders
    GROUP BY category
),
    ranked AS (
        SELECT category,
            DENSE_RANK() OVER (ORDER BY sales_category DESC) AS rank_category,
            ROUND(sales_category / SUM(sales_category) OVER(), 4) AS percent_category
        FROM orders_category
)
SELECT category, rank_category, percent_category
FROM ranked 
WHERE rank_category <= 3
ORDER BY rank_category, category;
