-- Week2
-- Exercise: Create SQL queries to check available bookings based on user input
-- ----------------------------------------------------------------------------

-- Task2
-- Create a stored procedure called CheckBooking to check whether a table in the restaurant is already booked.

USE LittleLemonDB;
DROP procedure IF EXISTS CheckBooking;


DELIMITER $$

CREATE PROCEDURE CheckBooking(IN booking_date DATE, IN table_number INT)
BEGIN
    DECLARE booking_count INT;
    DECLARE booking_status VARCHAR(50);
    
    SELECT COUNT(BookingID) INTO booking_count
    FROM Bookings
    WHERE BookingDate = booking_date  AND TableNumber = table_number;
        
    IF booking_count = 0 THEN
		SET booking_status = CONCAT("Table ", table_number, " is free");
    ELSE
		SET booking_status = CONCAT("Table ", table_number, " is already booked");
    END IF;
    
    SELECT booking_status AS "Booking status";
END$$

DELIMITER ;
;

-- check how it works
--
CALL CheckBooking('2022-11-12',3);
