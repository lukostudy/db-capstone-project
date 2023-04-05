-- Week2
-- Exercise: Create SQL queries to add and update bookings
-- -------------------------------------------------------

-- Task2
-- -----

USE LittleLemonDB;

DROP PROCEDURE IF EXISTS UpdateBooking;



-- This procedure updates the date for the given booking 
-- The procedure checks:
-- if the given booking_id exists in the DB
-- if the table in the given booking is booked on the new date
-- The procedure does not give a possibility to change a table number
-- which is in accordance with the task specification
--
DELIMITER $$
CREATE PROCEDURE UpdateBooking(IN booking_id INT,booking_date DATE)
BEGIN
    DECLARE UpdatedRows INT;
    DECLARE confirmation VARCHAR(100);
    DECLARE OkToUpdate BOOL;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT "Booking NOT updated (exception). " AS "Confirmation";
	SET OkToUpdate = True;

	-- Checking if the booking to be updated exists in the database
    --
    SELECT COUNT(*) INTO @BookingExists FROM Bookings WHERE BookingID = booking_id;
    
    IF @BookingExists = 0 THEN
		SET confirmation = CONCAT("Booking ", booking_id, " is not registered. Can NOT be updated.");
        SET OkToUpdate = False;
	END IF;
	 
    -- Checking bookings on the new booking day 
    --
	IF OkToUpdate = True THEN
		SELECT BookingDate, TableNumber INTO @SelBookingDate, @SelTableNumber
			FROM Bookings
			WHERE BookingID = booking_id
		;
	END IF;
    
    IF OkToUpdate IS True THEN
		SELECT COUNT(BookingID) INTO @TableBooked
			FROM Bookings
			WHERE BookingDate = booking_date and TableNumber = @SelTableNumber
        ;
		IF @TableBooked > 0 THEN
			SET OkToUpdate = False;
            SET confirmation = CONCAT("Table ", @SelTableNumber, " is booked on ", booking_date,  ". Booking ", booking_id ," can NOT be updated.");
		END IF
        ;
	END IF;
    
    -- Let's try to update the given booking record
    IF OkToUpdate = True THEN
		UPDATE Bookings
			SET BookingDate = booking_date
            WHERE BookingID = booking_id
        ;
		SELECT IFNULL(ROW_COUNT(),0) INTO UpdatedRows;
		IF UpdatedRows = 1 THEN
			SET confirmation = CONCAT("Booking ", booking_id, " has been updated.");
			COMMIT;
		ELSE
			SET confirmation = CONCAT("Booking ", booking_id, " could NOT be updated.");
		END IF
        ;
    END IF
    ;
    
    -- return confirmation
    -- 
    SELECT confirmation;
END
$$

DELIMITER ;



-- test how it works
--
CALL UpdateBooking(239,'2021-08-25');
