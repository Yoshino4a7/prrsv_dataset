-- 索引
-- 用来加快查询某一条数据速度的数据结构
SELECT customer_id
FROM customers
WHERE state = 'CA';

CREATE INDEX idx_state ON customers(state); -- 在customers数据表中的state列建立一个索引

CREATE INDEX idx_state ON customers(last_name(20)); -- 在customers数据表中的last_name列建立一个索引,该索引只搜索last_name 20 个字符
SELECT
	COUNT(DISTINCT LEFT(last_name,1)
FROM customers;
-- 可以只对某一段前缀进行查询


SHOW INDEXES IN customers; -- 显示数据表的索引

ANALYZE TABLE customers -- 获取数据表的统计信息

