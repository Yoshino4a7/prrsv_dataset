
-- SELECT 语句及其子句
-- SELECT 
-- 	name,
--     unit_price,
--     unit_price *1.1 AS new_price
-- FROM products;
-- AS关键字可以将算术表达式的列名修改，显示name、uinit_price和unit_price计算之后的记录

-- SELECT *
-- FROM customers
-- WHERE birth_date BETWEEN "1990-01-01" AND '2000-01-01'
-- 查找birth_date在1990-01-01和2000-01-01之间的记录

-- SELECT *
-- FROM customers
-- WHERE last_name LIKE 'b%'-- 查找last_name中以B开头的记录（%表示可以匹配后续的任意数量的字符）
-- WHERE last_name LIKE '____b'-- 查找last_name中以B结尾的记录（b前面有四个_，表示前面要匹配四个任意字符）

-- SELECT *
-- FROM customers
-- WHERE (address LIKE "%TRAIL%" OR "%AVENUE%" )OR(phone LIKE '%9')

-- SELECT *
-- FROM customers
-- WHERE last_name REGEXP '^field' 正则表达式匹配 field必须在开头,不区分大小写
-- 'field' 匹配字符串中的field
-- '^field' 字符串中的field 必须在开头
-- 'field$' 字符串中的field 必须在结尾
-- 'field|mac' 字符串中需要存在field 或存在mac
-- '^field|mac' 字符串中的field必须在开头、或者存在mac
-- '[gim]e' 匹配字符串中的ge、ie、me （gim任意一个字符在e的前面）
-- '[a-h]e' 匹配字符串中的ae、be、ce、de、ee、fe、ge、he （a-h任意一个字符在e的前面）

-- SELECT *
-- FROM customers
-- WHERE first_name REGEXP 'ELKA|AMBUR'

-- SELECT *
-- FROM customers
-- WHERE last_name REGEXP 'EY$|ON$'

-- SELECT *
-- FROM customers
-- WHERE last_name REGEXP '^MY|SE'

-- SELECT *
-- FROM customers
-- WHERE last_name REGEXP 'B[ru]'

-- SELECT *
-- FROM customers
-- WHERE phone IS NULL

-- SELECT *
-- FROM orders
-- WHERE shipped_date IS NULL 
-- 查找shipped_date 为NULL的记录

-- SELECT * 
-- FROM customers
-- ORDER BY state DESC ,first_name-- DESC表示降序排列 先对state排序，再对first_name 排序

-- SELECT *
-- FROM order_items
-- WHERE order_id = 2
-- ORDER BY quantity * unit_price DESC

-- SELECT *
-- FROM customers
-- LIMIT 2,5 -- 2偏移量，5为此次查询需要获得的记录总数，表示需要跳过前2个记录获取序号为3-7的记录

-- SELECT *
-- FROM customers
-- ORDER BY points DESC
-- LIMIT 3

-- 内连接
-- SELECT order_id,first_name,last_name ,orders.customer_id
-- -- SELECT对于同一个数据只能选择一张表的数据，连接之后不能选择共同的数据，除非加上对应数据表的前缀
-- FROM  orders
-- JOIN customers
-- 	ON orders.customer_id = customers.customer_id
-- -- 将两个有着共同标识（数据）的数据表（orders和customers）连接，构建关系，这样就能用customer_id 同时查询这两个表的数据

-- SELECT order_id,order_items.product_id,quantity,order_items.unit_price
-- FROM order_items
-- JOIN products
-- 	ON products.product_id = order_items.product_id


-- USE sql_inventory;
-- SELECT *
-- FROM sql_store.order_items oi
-- JOIN sql_inventory.products p
-- 	ON oi.product_id = p.product_id
-- -- 将两个数据库的不同表连接-- 

-- USE sql_hr;

-- SELECT 
-- 	e.first_name,
-- 	m.first_name AS manager,
--     e.employee_id
-- FROM employees e
-- JOIN employees m
-- 	ON e.reports_to = m.employee_id -- （reports_to 是employee_id的一个子集）
-- -- 将同一张表中拥有重复数据的记录连接（表的自连接）,连接时要对同一个表使用不同的别名表示不同的数据，抓取数据时需要给每一列都标明来源

-- USE sql_store;

-- SELECT o.order_id,o.order_date,c.first_name,c.last_name,os.name
-- FROM orders o
-- JOIN customers c
-- 	ON c.customer_id = o.customer_id
-- JOIN order_statuses os
-- 	ON os.order_status_id= o.status
-- ORDER BY o.order_id 
-- 关联多张数据表

-- USE sql_invoicing;

-- SELECT 
-- 	c.name,
--     p.invoice_id,
--     p.date,
--     p.amount,
--     pm.name AS pay_methond
-- FROM payments p
-- JOIN clients c
-- 	ON p.client_id = c.client_id
-- JOIN payment_methods pm
-- 	ON pm.payment_method_id = p.payment_method

-- SELECT *
-- FROM order_items oi
-- JOIN order_item_notes oin
-- 	ON oi.order_id= oin.order_id
--     AND oi.product_id = oin.product_id
--  -- 复合连接，当一个表有多个主键，又需要和另一个表进行连接时，需要用AND进行多个连接（这里的主键是order_id和product_id）

-- SELECT *
-- FROM orders o,customers c
-- WHERE o.customer_id = c.customer_id
-- 隐式连接（不写JOIN和ON的连接语法）

-- 外连接，在JOIN	前面加上LEFT或RIGHT关键字
-- SELECT
-- 	c.customer_id,
--     c.first_name,
--     o.order_id,
--     s.name
-- FROM customers c
-- LEFT JOIN orders o
-- 	ON c.customer_id = o.customer_id
-- LEFT JOIN shippers s
-- 	ON o.shipper_id = s.shipper_id
-- -- 左连接：在匹配customers与orders两张表中的数据时，返回customers表中所有的数据，返回order表中custome_id在customers存在的数据
-- -- 右连接：在匹配customers与orders两张表中的数据时，返回orders表中所有的数据，返回customers表中custome_id在orders存在的数据
-- ORDER BY c.customer_id

-- SELECT 
-- 	oi.product_id,
--     p.name,
--     oi.quantity
-- FROM order_items oi
-- RIGHT JOIN products p
-- 	ON p.product_id = oi.product_id
-- ORDER BY p.product_id
-- JOIN左边的数据表是连接中的左边，JOIN右边的数据表示连接中的右边

-- SELECT
-- 	o.order_date,
--     o.order_id,
--     c.first_name,
--     s.name,
--     os.name AS status
-- FROM customers c
-- JOIN orders o
-- 	ON c.customer_id = o.customer_id
-- LEFT JOIN shippers s
-- 	ON s.shipper_id = o.shipper_id
-- LEFT JOIN order_statuses os
-- 	ON os.order_status_id = o.status
-- -- 左连接：在匹配customers与orders两张表中的数据时，返回customers表中所有的数据，返回order表中custome_id在customers存在的数据
-- -- 右连接：在匹配customers与orders两张表中的数据时，返回orders表中所有的数据，返回customers表中custome_id在orders存在的数据
-- ORDER BY o.order_id

-- SELECT
-- 	p.date,
-- 	c.name,
--     p.amount,
--     pm.name
-- FROM payments p
-- JOIN clients c
-- 	USING(client_id)
-- JOIN payment_methods pm
-- 	ON pm.payment_method_id = p.payment_method

-- SELECT *
-- FROM orders o
-- NATURAL JOIN customers c
-- -- 自然连接，引擎根据共同的列自动连接两个数据表-- 

-- SELECT *
-- FROM customers c
-- CROSS JOIN products p
-- -- 交叉连接，将两个表的每条记录互相连接，输出时会导致一个记录出现多次重复

-- SELECT
-- 	order_id,
--     order_date,
--     'Active' AS status
-- FROM orders
-- WHERE order_date >= '2019-01-01'
-- UNION -- UNION关键字能将两个查询块返回的结果合并一起显示，两个查询返回的列数需要相等-- 
-- SELECT 
-- 	order_id,
--     order_date,
--     'Archive' AS status
-- FROM orders
-- WHERE order_date < '2019-01-01';


-- SELECT
-- 	c.customer_id,
--     c.first_name,
--     c.points,
--     'Bronce' AS type
-- FROM customers c
-- WHERE c.points <2000
-- UNION
-- SELECT
-- 	c.customer_id,
--     c.first_name,
--     c.points,
--     'Silver' AS type
-- FROM customers c
-- WHERE c.points >=2000 AND c.points<3000
-- UNION
-- SELECT
-- 	c.customer_id,
--     c.first_name,
--     c.points,
--     'Gold' AS type
-- FROM customers c
-- WHERE c.points>=3000
-- ORDER BY first_name

-- INSERT INTO orders(order_date,customer_id)
-- VALUE
-- 	("2026-03-07",
--     5);
-- -- 在orders表中插入新一行数据，只提供order_date,customer_id的数值，其他列默认或是NULL
-- INSERT INTO order_items
-- VALUE
-- 	(LAST_INSERT_ID(),
--     2,
--     5,
--     10)
-- -- LAST_INSERT_ID()返回上一次插入操作时，给新行赋予的id值

-- CREATE TABLE order_archived AS
-- SELECT * 
-- FROM orders
-- 创建orders的复制表

-- INSERT INTO order_archived 
-- SELECT *
-- FROM orders
-- WHERE order_date < '2019-01-01'
-- -- 将orders中order_date在2019年之前的记录插入到order_archived表中

-- CREATE TABLE invoices_archived AS
-- SELECT 
-- 	i.invoice_id,
--     i.number,
--     c.name,
--     i.invoice_total,
--     i.payment_total,
--     i.invoice_date,
--     i.due_date,
--     i.payment_date
-- FROM invoices i
-- JOIN clients c
-- 	ON c.client_id = i.client_id
-- WHERE NOT(i.payment_date IS NULL)

-- UPDATE invoices
-- SET payment_total = 10,payment_date = '2026-03-07'
-- WHERE invoice_id = 1
-- -- 更新invoices中invoice_id =1 的记录中的payment_total和payment_date值

-- UPDATE invoices
-- SET payment_total = DEFAULT,payment_date = DEFAULT
-- WHERE invoice_id = 1
-- -- 更新invoices中invoice_id =1 的记录中的payment_total和payment_date值为默认值

-- UPDATE invoices
-- SET 
-- 	payment_total = invoice_total * 0.5,
-- 	payment_date = NULL 
-- WHERE client_id = 3
-- -- 更新invoices中client_id = 3 的记录中的payment_total为invoice_total的50%和payment_date值为默认值

-- UPDATE customers
-- SET
-- 	points = points + 50
-- WHERE birth_date < '1990-01-01'

-- UPDATE orders
-- SET
-- 	comments = 'Gold'
--   

-- WHERE customer_id IN 
-- 			(SELECT customer_id
--             FROM customers
--             WHERE points >= 3000);
-- -- 根据条件筛选需要更新数据的行，用选择子句确认条件

    