-- 子查询练习

-- SELECT
-- 	first_name,
--     last_name,
--     salary
-- FROM employees
-- WHERE salary > (
-- 		SELECT 
-- 			AVG(salary)
-- 		FROM employees
-- )

-- SELECT *
-- FROM clients
-- WHERE client_id NOT IN (
-- 				SELECT DISTINCT client_id
-- 				FROM invoices
--                 )

-- SELECT
-- 	c.customer_id,
--     c.first_name,
--     c.last_name
-- FROM customers c
-- WHERE customer_id IN(
-- 	SELECT
-- 		customer_id
-- 	FROM orders JOIN order_items USING (order_id)
-- 	WHERE product_id = 3
--     )
   --  --子查询和连接混用，查找product_id为3的客户
-- SELECT *
-- FROM invoices
-- WHERE invoice_total >  ALL (
-- 	SELECT *
-- 	FROM invoices
-- 	WHERE client_id = 3
-- )
-- 返回比id3客户所有的发票价格都要高的其他发票信息

-- SELECT *
-- FROM employees e
-- WHERE salary > (
-- 	SELECT AVG(salary)
--     FROM employees
--     WHERE office_id = e.office_id
-- )
-- --相关子查询，查询高于本部门平均工资的员工信息

-- SELECT *
-- FROM invoices i
-- WHERE invoice_total > (
-- 	SELECT AVG(invoice_total)
--     FROM invoices
--     WHERE client_id = i.client_id
-- )
-- SELECT *
-- FROM clients
-- JOIN invoices USING(client_id)



-- SELECT *
-- FROM clients c
-- WHERE EXISTS (
-- 	SELECT client_id
--     FROM invoices
--     WHERE client_id = c.client_id
-- )

-- SELECT *
-- FROM products p
-- WHERE NOT EXISTS (
-- 	SELECT
-- 		product_id
-- 	FROM order_items
--     WHERE product_id  =  p.product_id
-- )
-- --EXISTS运算符会将外层每一条product_id与order_items的product_id列表逐条比对，
-- 如果存在一条记录，则返回一个TRUE不返回子查询的结果，
-- IN运算符则会计算子查询的结果，返回一个列表，再进行逐条比对

-- SELECT 
-- 	invoice_id,
--     invoice_total,
--     (SELECT AVG(invoice_total)
-- 		FROM invoices) AS invoice_average,-- 不能在SELECT中直接选择另一个变量，需要再加一次SELECT
-- 	invoice_total-(SELECT invoice_average) AS difference
-- FROM invoices
-- -- --SELECT子句可以嵌套进去

-- SELECT
-- 	client_id,
-- 	name,
--     (SELECT 
-- 		SUM(invoice_total)
-- 	FROM invoices
--     WHERE client_id = c.client_id)  AS total_sales, 
--     -- 只筛选invoices中有client_id的发票进行计算，
--     -- 由于语句执行的时候是一条记录一条记录的执行，到达第一条记录时，
--     -- 会将第一条记录与invoices中所有记录进行比对，找出含有第一个id的发票，并将其求和，返回第一条记录的求和值
--     -- 所以需要用WHERE 进行相关，找到所有有发票的客户，又由于是在clients数据表查询，又能返回没有发票的客户
--     (SELECT AVG(invoice_total)
--     FROM invoices) AS average,
--     (SELECT total_sales) - (SELECT average) AS difference
-- FROM clients c
-- SELECT *
-- FROM(
-- 	SELECT
-- 		client_id,
-- 		name,
-- 		(SELECT 
-- 			SUM(invoice_total)
-- 		FROM invoices
-- 		WHERE client_id = c.client_id)  AS total_sales, 
-- 		-- 只筛选invoices中有client_id的发票进行计算，
-- 		-- 由于语句执行的时候是一条记录一条记录的执行，到达第一条记录时，
-- 		-- 会将第一条记录与invoices中所有记录进行比对，找出含有第一个id的发票，并将其求和，返回第一条记录的求和值
-- 		-- 所以需要用WHERE 进行相关，找到所有有发票的客户，又由于是在clients数据表查询，又能返回没有发票的客户
-- 		(SELECT AVG(invoice_total)
-- 		FROM invoices) AS average,
-- 		(SELECT total_sales) - (SELECT average) AS difference
-- 	FROM clients c
-- ) AS sale_summary-- 甚至可以在FROM加入这样一张临时的数据表


    