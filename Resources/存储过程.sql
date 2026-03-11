-- 存储过程  不能在存储过程创建语句内部写注释
use sql_invoicing
-- 存储过程是编程语言对数据库进行交换数据和操作的桥梁
-- 改变语句的分隔符，用于区别存储过程与其他SQL语句 不是所有的DBMS都需要修改分隔符
DELIMITER $$ 
CREATE PROCEDURE get_client()
BEGIN
	SELECT * FROM clients;
END$$
DELIMITER ;

CALL get_client() -- 使用存储过程
-- 改变语句的分隔符，用于区别存储过程与其他SQL语句 不是所有的DBMS都需要修改分隔符
DELIMITER $$ 
CREATE PROCEDURE get_invoices_with_balance()
BEGIN
	SELECT * FROM clients_balance
    WHERE balance >0;
END$$
DELIMITER ;

CALL get_invoices_with_balance() 

DELIMITER $$ 
CREATE PROCEDURE get_clients_by_state(state VARCHAR(2))
BEGIN
	SELECT * FROM clients c
    WHERE c.state = state;
END$$
DELIMITER ;
-- CHAR(2)表示该存储过程需要接受长度为2的字符串作为参数
-- VARCHAR表示该存储过程需要接受任意长度的字符串作为参数

DELIMITER $$ 
CREATE PROCEDURE get_invoicess_by_client(client_id INT)
BEGIN
	SELECT * FROM invoices i
    WHERE i.client_id = client_id;
END$$
DELIMITER ;

CALL get_invoicess_by_client(1)

DELIMITER $$ 
CREATE PROCEDURE get_payments(client_id INT(4),payment_method_id TINYINT(1))
BEGIN
	SELECT * FROM payments p
    WHERE (p.client_id = IFNULL(client_id,p.client_id)) AND (p.payment_method = IFNULL(payment_method_id,p.payment_method));
END$$
DELIMITER ;

CALL get_payments(5,NULL)

DELIMITER $$ 
CREATE PROCEDURE get_unpaid_payments_by_client_id(client_id INT,OUT count_of_invoices INT,OUT invoices_total DECIMAL(9,2))
BEGIN
	SELECT COUNT(*),SUM(invoice_total) INTO count_of_invoices,invoices_total
    FROM invoices i
    WHERE (i.client_id = IFNULL(client_id,i.client_id)) AND (payment_total = 0);
END$$
DELIMITER ;
-- 变量前面需要加一个@
SET @count_of_invoices = 0;
SET @invoices_total = 0;
CALL get_unpaid_payments_by_client_id(5 ,@count_of_invoices,@invoices_total);
SELECT @count_of_invoices,@invoices_total

-- INTO和OUT关键字可以将查询获得的记录数据输出到参数当中

DELIMITER $$ 
CREATE PROCEDURE get_risk_factor()
BEGIN
	DECLARE risk_factor DECIMAL(9.2) DEFAULT 0;
    DECLARE invoices_total DECIMAL(9.2);
    DECLARE invoices_count INT;
    
	SELECT COUNT(*),SUM(invoice_total) INTO invoices_count,invoices_total
    FROM invoices i;
    
    SET risk_factor = invoices_total/invoices_count*5;
    
    SELECT risk_factor;
END$$
DELIMITER ;
-- 本地变量，在存储过程中临时定义的变量

SELECT
	client_id,
    name,
	get_risk_factor(client_id)
FROM clients