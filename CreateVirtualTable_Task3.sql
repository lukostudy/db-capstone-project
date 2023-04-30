-- SQL query that presents menu items for which more than 2 orders have been placed
-- --------------------------------------------------------------------------------


USE LittleLemonDB;

SELECT m.Name as MenuName
FROM Menus m
WHERE m.MenuID = ANY (	SELECT MenuID
						FROM Orders
						GROUP BY MenuID
						HAVING COUNT(OrderID) > 2 )
;