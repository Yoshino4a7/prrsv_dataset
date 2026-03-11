-- 事务
-- 事务是将多个操作封装后的一段操作，内部的所有子操作必须全部完成，整个事务才能算作完成，否则数据库会退回到执行事务之前的状态
-- 事务具有互斥性，当执行一个事务时，不能同时执行另一项事务，类似于操作系统中的进程概念

START TRANSACTION;

INSERT INTO orders (customer_id,order_date,status)
VALUES(1,'2026-03-08','1');

INSERT INTO order_items
VALUES(LAST_INSERT_ID(),1,1,1);

COMMIT; -- SQL看到该指令后，会将START TRANSACTION之后所有的更改写入数据库
ROLLBACK; -- SQL、看到该指令后，会将START TRANSACTION之后所有的更改取消，返回到START TRANSACTION之前的状态

-- 最小化并发问题（相同操作同时提交时的处理）
-- SQL默认会优先执行首先提交的事务，后执行后来提交的事务

-- 为了减少并发错误的产生，SQL对事务有四个限制等级：
-- 1.READ UNCOMMITTED ： 允许事务中的读取可以读取尚未完成提交的数据
-- 2.READ COMMITTED : 事务只能读取已经完成提交的数据
-- 3.REPEATABLE READ: 该事务在读取数据时，只会读取第一次读取得到的副本，确保数据在当前事务的不变性
-- 4.SERIALIZABLE: 该事务必须完全提交后，其他的事务才能对相同数据进行操作
-- -- 通过以下代码设置隔离级别
-- SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED