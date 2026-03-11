-- 触发器
触发器是SQL在进行数据修改时自动执行的一段代码
用来指定某一段代码执行的时间

DELIMITER $$

CREATE TRIGGER payments_after_insert
	AFTER INSERT ON payments -- 在数据表payments进行插入操作时触发
    FOR EACH ROW -- 该触发器会影响每一行
BEGIN
-- OLD 关键字可以返回payments更新前的行，NEW可以返回此时插入payments的行
	UPDATE invoices
    SET payment_total = payment_total + NEW.amount
    WHERE NEW.invoice_id = invoice_id;
    -- 这样在客户支付了支票后，会修改payments数据表的amount值，也会同时修改invoices数据表相应invoice_id的的payment_total值
END $$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER payments_after_delete
	AFTER DELETE ON payments -- 在数据表payments进行删除操作时触发
    FOR EACH ROW -- 该触发器会影响每一行
BEGIN
-- OLD 关键字可以返回payments更新前的行，NEW可以返回此时插入payments的行
	UPDATE invoices
    SET payment_total = payment_total - OLD.amount
    WHERE OLD.invoice_id = invoice_id;
    -- 这样在客户支付了支票后，会修改payments数据表的amount值，也会同时修改invoices数据表相应invoice_id的的payment_total值
END $$

DELIMITER ;

-- DROP TRIGGER payments_after_delete

INSERT INTO payments
VALUES(DEFAULT,5,3,'2026-03-07',10,1);

DELETE  FROM payments
WHERE payment_id = 9


SHOW VARIABLES LIKE 'event%'
-- 查找与事件相关的系统变量

SHOW EVENTS LIKE 'yearly%'
-- 查找每年执行的事件

DELIMITER $$
-- ALTER 关键字可修改事件定义
ALTER EVENT yearly_delete_state_audit_rows
ON SCHEDULE
	-- AT 关键字 在某个时刻执行事件
	EVERY 1 YEAR STARTS '2026-01-01' ENDS '2029-01-01' -- 每隔一年执行事件
DO BEGIN
	DELETE FROM payments_audit
    WHERE action_date < NOW() - INTERVAL 1 YEAR;
    -- 当当前年份往后退一年仍然大于删除期限时，删除数据，即清理一年过期的数据
END $$

DELIMITER ;

DROP EVENT IF EXISTS yearly_delete_state_audit_rows;
-- 删除事件

ALTER EVENT yearly_delete_state_audit_rows ENABLE
-- 启用事件
ALTER EVENT yearly_delete_state_audit_rows DISABLE
-- 禁用