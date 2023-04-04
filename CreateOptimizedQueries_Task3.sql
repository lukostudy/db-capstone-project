USE LittleLemonDB;
DROP procedure IF EXISTS CancelOrder;


DELIMITER $$

CREATE PROCEDURE CancelOrder(IN id INT)
BEGIN
    DECLARE DELROWS INT;
    DECLARE CONFIRMATION VARCHAR(50);
    
    DELETE FROM Orders WHERE OrderID = id;
    SELECT ROW_COUNT() INTO DELROWS;
    
    IF DELROWS = 1 THEN
		SET CONFIRMATION = CONCAT("Order ", id, " is cancelled");
    ELSE
		SET CONFIRMATION = CONCAT("Error! Order ", id, " could not be calcelled");
    END IF;
    
    SELECT CONFIRMATION;
END$$

DELIMITER ;
;


CALL CancelOrder(2266);

-- To use the CancelOrder proedure pls check available OrdersID
-- You should pass to the procedure an existing OrderID 
-- You can use the following SQL query:
-- SELECT OrderID FROM Orders Order by OrderID ASC;


