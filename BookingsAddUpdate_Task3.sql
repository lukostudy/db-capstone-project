-- Week2
-- Exercise: Create SQL queries to add and update bookings
-- -------------------------------------------------------

-- Task3
-- -----

USE LittleLemonDB;

DROP PROCEDURE IF EXISTS CancelBooking;



-- This procedure deletes the given booking record
-- The procedure checks:
-- if the given booking_id exists in the DB
--
DELIMITER $$
CREATE PROCEDURE CancelBooking(IN booking_id INT)
BEGIN
    DECLARE confirmation VARCHAR(100);
    DECLARE OkToDelete BOOL;
--    DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT "Booking NOT deleted (exception). " AS "Confirmation";
	SET OkToDelete = True;

	-- Checking if the booking to be cancelled(deleted) exists in the database
    --
    SELECT COUNT(*) INTO @BookingExists FROM Bookings WHERE BookingID = booking_id;
    
    IF @BookingExists = 0 THEN
		SET confirmation = CONCAT("Booking ", booking_id, " is not registered. Can NOT be cancelled.");
        SET OkToDelete = False;
	END IF;
	     
    -- Let's try to delete the given record
    IF OkToDelete = True THEN
		DELETE FROM Bookings WHERE BookingID = booking_id;
		SELECT IFNULL(ROW_COUNT(),0) INTO @DeletedRows;
		IF @DeletedRows = 1 THEN
			SET confirmation = CONCAT("Booking ", booking_id, " has been cancelled.");
			COMMIT;
		ELSE
			SET confirmation = CONCAT("Booking ", booking_id, " could NOT be cancelled.");
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
CALL CancelBooking(2345);
