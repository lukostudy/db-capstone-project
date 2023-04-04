-- OrdersView
-- presents orders with quantity > 2
-- ----------------------------------


USE LittleLemonDB;

DROP VIEW IF EXISTS OrdersView;

CREATE VIEW OrdersView AS
SELECT OrderID, Quantity, TotalCost AS Cost
FROM LittleLemonDB.Orders
WHERE Quantity > 2
;

SELECT * FROM OrdersView LIMIT 10;

