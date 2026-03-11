-- 数据库创建、管理相关代码

CREATE DATABASE IF NOT EXISTS sql_store2;

USE sql_store2;
CREATE TABLE customers
(
	customer_id INT PRIMARY KEY AUTO_INCREMENT,
    -- 作为主键、并自动增长的列,
    first_name VARCHAR(50) NOT NULL, -- 该列数据不能为空
    points INT NOT NULL DEFAULT 0, -- 默认值为0
    email VARCHAR(255) NOT NULL UNIQUE -- 输入的邮箱不能有重复
    
)

ALTER TABLE customers -- 修改已经创建过的数据表
(
	ADD last_name VARCHAR(50) NOT FULL ALTER 'first_name'; -- 在原先的'first_name'列之后添加'last_name'列
    DROP points -- 删除某一列
    
)

CREATE TABLE orders
(
	customer_id INT NOT NULL,
    order_id INT PRIMARY KEY,
    FOREIGN KEY fk_orders_customers(customer_id)
		REFERENCES customers (customer_id)
        ON UPDATE NO ACTION-- 用customer_id作为外键连接orders和customers两张数据表
        -- 外键限制 NO ACTION、SET NULL ,CASCADE 当主表发生变化时，从表的外键可以不变化或则一起变化或者设置成NULL
        ON DELETE NO ACTION
        -- 外键限制 NO ACTION、SET NULL ,CASCADE 当主表删除某一条数据时，从表的外键可以不变化或则一起删除或者设置成NULL
    
)
