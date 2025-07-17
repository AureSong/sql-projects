USE BookLearning;

-- 练习 1｜订单金额等级分类（⭐）
-- 目标： 查询每个订单编号及其订单总金额，并按金额分类为“小单”“中单”“大单”。
-- 提示：需要在 OrderItems 表中，计算 item_price * quantity 作为订单金额
-- 建议使用 GROUP BY + CASE WHEN
SELECT
    order_num,
    SUM(item_price * quantity) AS total_ordered,
    CASE 
    	WHEN SUM(item_price * quantity) >= 1000 THEN '大单'
    	WHEN SUM(item_price * quantity) >= 500 THEN '中单'
    	ELSE '小单'
    END AS order_type
FROM OrderItems
GROUP BY order_num;

-- 练习 3｜客户消费等级
-- 目标： 查询每位客户的总订单金额，并按消费总额划分客户等级（“高价值”“中等”“低价值”）
-- 涉及 Customers、Orders、OrderItems 三表 JOIN
-- 用 SUM(oi.item_price * oi.quantity)
-- GROUP BY cust_id
-- 然后用 CASE WHEN 设置等级：
-- ≥ 2000 为高价值，1000~1999为中等，其余为低价值
SELECT
    c.cust_id,
    c.cust_name,
    SUM(oi.item_price * oi.quantity) AS total_ordered,
    CASE
    	WHEN SUM(oi.item_price * oi.quantity) >= 2000 THEN '高价值'
    	WHEN SUM(oi.item_price * oi.quantity) >= 1000 THEN '中等'
    	ELSE '低价值'
    END AS customers_type
FROM Customers AS c
JOIN Orders AS o ON c.cust_id = o.cust_id
JOIN OrderItems AS oi ON o.order_num = oi.order_num
GROUP BY c.cust_id, c.cust_name
ORDER BY total_ordered DESC;
    



USE BookLearning;

-- 练习 4｜供应商活跃状态判断
-- 目标： 查询每个供应商名称、产品数量、活跃状态
-- 如果某供应商提供的产品数量 ≥ 5，显示为“活跃供应商”
-- 否则为“低频供应商”
-- 涉及 Vendors 表 JOIN Products 表
-- 用 COUNT(product_id) 分组后再 CASE WHEN
SELECT
    v.vend_name,
    COUNT(p.prod_id) AS prod_count,
    CASE 
    	WHEN COUNT(p.prod_id) >= 5 THEN '活跃供应商'
    	ELSE '低频供应商'
    END AS vend_type
FROM Vendors AS v
INNER JOIN Products AS p ON v.vend_id = p.vend_id
GROUP BY vend_name
ORDER BY vend_name, prod_count;
    


-- 练习 5｜客户是否有高额订单
-- 目标： 查询客户ID、客户名，并判断是否下过任意单笔金额 ≥1000 的订单
-- 用子查询或 JOIN + GROUP BY + HAVING + CASE WHEN
-- 输出字段为：cust_id, cust_name, 是否有大额订单（是/否）
-- 思路：先统计每笔订单金额 → 判断是否 ≥ 1000 → 每位客户是否存在此类订单
SELECT
    c.cust_id,
    c.cust_name,
    CASE 
    	WHEN EXISTS(
    	    SELECT 1
    	    FROM Orders o 
    	    JOIN OrderItems oi ON o.order_num = oi.order_num
    	    WHERE o.cust_id = c.cust_id 
    	    GROUP BY oi.order_num
    	    HAVING SUM(oi.quantity * oi.item_price) >= 1000
    	)
    	THEN '是'
    	ELSE '否'
    END AS 是否有大额订单
FROM Customers c;

SELECT 
    c.cust_id,
    c.cust_name,
    CASE 
    	WHEN SUM(oi.quantity * oi.item_price) >= 1000 THEN '是'
    	ELSE '否'
    END AS 是否有大额订单
FROM Customers c 
JOIN Orders o ON c.cust_id = o.cust_id
JOIN OrderItems oi ON o.order_num = oi.order_num
GROUP BY c.cust_id, c.cust_name;
    

