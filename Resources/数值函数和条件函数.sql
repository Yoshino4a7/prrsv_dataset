-- 数值函数
-- SELECT 
-- 	ROUND(5.73,1) 5.7 四舍五入
--     TRUNCATE(5.7345,2), 5.73 截取数字
--     CEILING(5.2), 返回大于等于5.2的最小整数6
--     FLOOR(5.2), 返回小于等于5.2的最小整数5
--     ABS(-5) 绝对值


-- SELECT
-- 	UPPER('a') 返回大写
--     LOWER('A') 返回小写
--     LTRIM('  A') 修剪左侧空格
--     RTRIM('A    ') 修剪右侧空格
--     TRIM('  A  ')
--     LOCATE('B','ABCD') 返回2
--     LEFT('ABCDF',2) 返回'AB'
--     RIGHT('ABCDF',2) 返回'DF'
--     SUBSTRING('ABCDF',3,2) 返回'CD'
--     CONCAT('AB','CD') 返回'ABCD'
--     REPLACE('ABCD','AB','CD') 返回'CDCD'
--     
-- SELECT
-- 	NOW() 当前日期和时间
--     CURDATE() 当前日期
--     CURTIME() 当前时间
--     YEAR()
--     HOUR()
--     SECOND()
--     DAYNAME()
--     MONTHNAME()

-- SELECT *
-- FROM orders
-- WHERE YEAR(order_date) = YEAR(NOW())

-- SELECT
-- 	DATE_FORMAT(NOW(),'%y')  26
--     DATE_FORMAT(NOW(),'%Y')  2026
--     DATE_FORMAT(NOW(),'%m %Y') 03 2026
--     DATE_FORMAT(NOW(),'%M %Y') March 2026
--     DATE_FORMAT(NOW(),'%M %d %Y') March 11 2026

-- 日期计算函数
-- SELECT 
-- 	DATE_ADD(NOW(),INTERVAL 1 DAY) 返回明天的同一时间
--     DATE_ADD(NOW(),INTERVAL 1 YEAR) 返回明年的同一时间
--     DATEDIFF('2026-03-07','2026-03-04') 返回3
--     TIME_TO_SEC('09:00') 返回到0点的秒数总和


-- SELECT
-- 	order_id,
--     IFNULL(shipper_id,'Not assigned'),-- 将shipper_id中原本为NULL的值转变为Not assigned输出
--     COALESCE(shipper_id,comments,'Not assigned') -- shipper_id是NULL的值的话输出comments，comments是NULL值的话输出Not assigned
--     
-- FROM orders

-- SELECT
-- 	CONCAT(first_name,' ',last_name) AS customer,
--     IFNULL(phone,'Unknown') AS phone
-- FROM customers

-- IF 函数
-- SELECT 
-- 	product_id,
-- 	name,
--     (SELECT
-- 		COUNT(oi.product_id)
--     FROM order_items oi
--     WHERE p.product_id = oi.product_id) AS orders,
--     IF ((SELECT orders )>1 ,'Many times','Once') AS frequency
-- FROM products p
-- WHERE product_id IN(SELECT
-- 					product_id
-- 					FROM order_items)
                    
-- SELECT
-- 	product_id,
-- 	name,
--     COUNT(*) AS orders, 
--     IF (COUNT(*) >1 ,'Many times','Once') AS frequency-- 使用聚合函数之后需要使用一次GROUP BY
--     -- 连接相当于将两张表合并，去除不相同的部分（在这里就是id=7的product），形成了同一张表，所以用COUNT(*)就可以算出所有产生过订单的product
-- FROM products p
-- JOIN order_items
-- 	USING(product_id)
-- GROUP BY product_id,name
-- -- 会对所有进行过聚合函数COUNT的地方进行分组

SELECT
	CONCAT(first_name,' ',last_name) AS customer,
    points,
    CASE
		WHEN points >=3000 THEN 'Gold'
        WHEN points BETWEEN 2000 AND 3000 THEN 'Silver'
        ELSE 'Bronze'
	END AS category
FROM customers
ORDER BY points DESC


    

    
    