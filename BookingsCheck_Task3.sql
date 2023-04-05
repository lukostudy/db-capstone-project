-- Week2
-- Exercise: Create SQL queries to check available bookings based on user input
-- ----------------------------------------------------------------------------

-- Task3
-- Create a stored procedure called AddValidBooking

-- Remarks
-- -------
-- AddValidBooking needs more IN parameters than specified in the task
-- customer_id is required to create a booking record
--   |-> every booking is made for a customer
-- staff_id in this database model is also required to create a booking record
--   |-> every booking is made by someone and system stores this information

USE LittleLemonDB;
DROP procedure IF EXISTS AddValidBooking;


DELIMITER $$

CREATE PROCEDURE AddValidBooking(IN booking_date DATE, IN table_number INT, IN customer_id INT, IN staff_id INT)
BEGIN
    DECLARE booking_count INT;
    DECLARE booking_status VARCHAR(50);

    
    START TRANSACTION;
    INSERT INTO Bookings(BookingDate, TableNumber, CustomerID, PlacedByStaffID)
    VALUES (booking_date, table_number, customer_id, staff_id);
    
    SELECT COUNT(BookingID) INTO booking_count
    FROM Bookings
    WHERE BookingDate = booking_date  AND TableNumber = table_number;
        
    IF booking_count = 1 THEN
		SET booking_status = CONCAT("Table ", table_number, " was free - booking confirmed");
        COMMIT;        
    ELSE
		SET booking_status = CONCAT("Table ", table_number, " is already booked - booking cancelled");
        ROLLBACK;
    END IF;
    
    SELECT booking_status AS "Booking status";
END$$

DELIMITER ;
;


-- test how it works
-- use the following SELECT query to verify data
--   |->  select * from Bookings where BookingDate = '2022-12-17'
--
CALL AddValidBooking('2022-12-17',6,33,1);
