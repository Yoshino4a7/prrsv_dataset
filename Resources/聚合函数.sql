
-- 聚合函数

-- SELECT
-- 	MAX(invoice_total) AS highest,
--     MIN(invoice_total) AS lowest,
--     AVG(invoice_total)  AS average,
--     SUM(invoice_total) AS total,
--     COUNT(invoice_total)  AS number_of_invoices,
--     COUNT(payment_date) AS count_of_payments, -- 不会将NULL值计数
--     COUNT(DISTINCT clien) AS clients -- 只计入非重复行
-- FROM invoices

-- SELECT
-- 	'First half of 2019' AS date_range,
--     SUM(invoice_total) AS total_sales,
--     SUM(payment_total) AS total_payments,
--     SUM(invoice_total-payment_total) AS what_we_expect
-- FROM invoices
-- WHERE invoice_date 
-- 	BETWEEN '2019-01-01' AND '2019-06-30'
-- UNION
-- SELECT
-- 	'Second half of 2019' AS date_range,
--     SUM(invoice_total) AS total_sales,
--     SUM(payment_total) AS total_payments,
--     SUM(invoice_total-payment_total) AS what_we_expect
-- FROM invoices
-- WHERE invoice_date 
-- 	BETWEEN '2019-07-01' AND '2019-12-31'
-- UNION
-- SELECT
-- 	'Total' AS date_range,
--     SUM(invoice_total) AS total_sales,
--     SUM(payment_total) AS total_payments,
--     SUM(invoice_total-payment_total) AS what_we_expect
-- FROM invoices	
-- WHERE invoice_date
-- 	BETWEEN '2019-01-01' AND '2019-12-31'
    
-- 分组
-- SELECT
-- 	client_id,
--     SUM(invoice_total) AS total_sales
-- FROM invoices
-- -- GROUP BY client_id -- 按照client_id进行分组，计算相同id值的invoice_total总和
-- GROUP BY state,city --按照state和city进行分组
-- ORDER BY total_sales DESC 降序排序

-- SELECT
-- 	date,
--     pm.name AS payment_method,
--     SUM(p.amount)
-- FROM payments p
-- JOIN payment_methods pm
-- 	ON pm.payment_method_id = p.payment_method
-- GROUP BY p.date,p.payment_method
-- ORDER BY p.date

-- SELECT
-- 	client_id,
--     SUM(invoice_total) AS total_sales,
--     COUNT(payment_total) AS number_of_invoices
-- FROM invoices
-- GROUP BY client_id
-- HAVING total_sales >500 AND number_of_invoices > 5
-- HAVING关键字可以给分组后的数据添加条件限定,GROUP和HAVING后的变量必须在SELECT的选择范围中，WHERE则没有这样的限制

-- SELECT
-- 	c.first_name,
--     c.state,
--     SUM(oi.quantity*oi.unit_price) AS total_custom
-- FROM customers c
-- JOIN orders o
-- 	USING(customer_id)
-- JOIN order_items oi
-- 	USING(order_id)
-- GROUP BY c.customer_id WITH ROLLUP -- WITH ROLLUP关键字可以对每个分组汇总
-- HAVING c.state='VA' AND total_custom > 100

SELECT
    pm.name AS payment_method,
    SUM(p.amount) AS total
FROM payments p
JOIN payment_methods pm
	ON pm.payment_method_id = p.payment_method
GROUP BY pm.name WITH ROLLUP -- WITH ROLLUP关键字可以对每个分组汇总
