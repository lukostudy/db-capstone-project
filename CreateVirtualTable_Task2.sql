-- SQL query that presents customers with orders that cost more than $150
-- ----------------------------------------------------------------------

USE LittleLemonDB;


SELECT c.CustomerID,
	CONCAT(c.FirstName, " ", c.LastName) as FullName,
    o.OrderID,
    o.TotalCost as Cost,
    m.Name as MenuName,
    mi.Name as CourseName
FROM LittleLemonDB.Orders o
JOIN LittleLemonDB.Customers c on c.CustomerID = o.CustomerID
JOIN LittleLemonDB.Menus m on m.MenuID = o.MenuID
JOIN LittleLemonDB.MenusSelection ms on ms.MenuID = m.MenuID
JOIN LittleLemonDB.MenuItems mi on mi.MenuItemID = ms.MenuItemID
WHERE ms.MenuSelCatID = 2 AND o.TotalCost > 150
ORDER BY TotalCost ASC