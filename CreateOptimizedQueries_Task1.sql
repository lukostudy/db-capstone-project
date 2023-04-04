USE LittleLemonDB;

DROP procedure IF EXISTS GetMaxQuantity;

DELIMITER $$
USE LittleLemonDB $$
CREATE PROCEDURE GetMaxQuantity ()
BEGIN
SELECT MAX(Quantity) as 'Max Quantity in Order' from Orders;
END$$

DELIMITER ;


CALL GetMaxQuantity();
