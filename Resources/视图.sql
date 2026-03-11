-- 视图

-- 视图类似与编程中的封装函数，可以封装一段查询重复使用

-- CREATE VIEW sales_by_clients AS 
-- SELECT
-- 	c.client_id,
--     c.name,
--     SUM(invoice_total) AS sales_total
-- FROM clients c
-- JOIN invoices i
-- 	USING(client_id)
-- GROUP BY client_id,name

-- 视图可以作为FROM后面的数据表使用

-- CREATE VIEW clients_balance AS
-- SELECT
-- 	c.client_id,
--     c.name,
--     SUM((i.invoice_total - i.payment_total)) AS balance
-- FROM clients c
-- JOIN invoices i
-- 	USING(client_id)
-- GROUP BY client_id,name

-- DROP VIEW XXXX
-- 删除XXXX视图
-- CREATE VIEW OR REPLACE clients_balance AS
-- 这样可以无限修改视图的定义,修改视图

-- 在视图定义中末尾加入WITH CHECK OPTION子句可以防止视图在使用时被UPDATE和DELETE修改