-- Week2
-- Exercise: Create SQL queries to check available bookings based on user input
-- -----------------------------------------------------------------------------

USE LittleLemonDB;

-- Add BookingDate index
-- This index has been also added to the model.
-- 
DROP INDEX BookingDate_idx ON Bookings;
CREATE INDEX BookingDate_idx ON Bookings (BookingDate ASC) VISIBLE;

-- Delete bookings records
-- all days and BookingIDs used in the exercise
--
DELETE FROM Bookings
WHERE BookingDate in ('2022-10-10','2022-11-12','2022-10-11','2022-10-13')
;	
DELETE FROM Bookings
WHERE BookingID in (1,2,3,4)
;
COMMIT
;


-- Task 1
-- Insert all records defined in the task
--
INSERT INTO Bookings  (BookingID, BookingDate, TableNumber, CustomerID, PlacedByStaffID)
VALUES (1,'2022-10-10', 5, 1, 1);
INSERT INTO Bookings  (BookingID, BookingDate, TableNumber, CustomerID, PlacedByStaffID)
VALUES (2,'2022-11-12', 3, 3, 1);
INSERT INTO Bookings  (BookingID, BookingDate, TableNumber, CustomerID, PlacedByStaffID)
VALUES (3,'2022-10-11', 2, 2, 1);
INSERT INTO Bookings  (BookingID, BookingDate, TableNumber, CustomerID, PlacedByStaffID)
VALUES (4,'2022-10-13', 2, 1, 1);
COMMIT
;

-- Select inserted records
SELECT BookingID, BookingDate, TableNumber, CustomerID
FROM Bookings
WHERE BookingID IN (1,2,3,4)
;