-- Week2
-- Exercise: Create SQL queries to add and update bookings
-- -------------------------------------------------------

-- Task 1
-- ------


USE LittleLemonDB;

DROP FUNCTION IF EXISTS isFreeBookingID;
DROP FUNCTION IF EXISTS isFreeTableNumber;
DROP PROCEDURE IF EXISTS AddBookingByStaff;
DROP PROCEDURE IF EXISTS AddBooking;


-- This constraint improves data consistency
-- it implements the requirement of max one booking of a table per day
--
ALTER TABLE Bookings DROP CONSTRAINT Bookings_DateTable_UNQ;
ALTER TABLE Bookings ADD CONSTRAINT Bookings_DateTable_UNQ UNIQUE (BookingDate, TableNumber);


DELIMITER $$

-- This function checks BookingID
-- returns True if the given BookingID is not in use
CREATE FUNCTION isFreeBookingID(booking_id INT)
	RETURNS BOOL
    READS SQL DATA
BEGIN
	DECLARE RowCount INT;
    
    SELECT IFNULL(COUNT(BookingID),0) INTO RowCount FROM Bookings WHERE BookingID = booking_id;
    IF RowCount = 0 THEN
		RETURN True;
	ELSE
		RETURN False;
	END IF;
END
$$

-- This function checks TableNumber on the given date
-- returns True is the table number is free on the given day
--
CREATE FUNCTION isFreeTableNumber(booking_date DATE, table_number INT)
	RETURNS BOOL
    READS SQL DATA
BEGIN
	DECLARE RowCount INT;
    
    SELECT IFNULL(COUNT(BookingID),0) INTO RowCount
		FROM Bookings
		WHERE BookingDate = booking_date and TableNumber = table_number;
    IF RowCount = 0 THEN
		RETURN True;
	ELSE
		RETURN False;
	END IF;
END
$$



-- The procedure adds a new given booking record to the Bookings table
--
-- This procedure has one more parameter (staff_id) since the designed data model requires it
-- Each Booking should have registerred who placed the booking
--
-- If the booking can't be inserted a relevant message is returned
-- The procedure checks booking_id and boooking_date plus table_number ... enough for the purpose of the exercise
-- The procedure does not check other parameters like customer_id ... which can be easily added ...
-- Data validation could be also based on exceptions raised by the MYSQL server
--
CREATE PROCEDURE AddBookingByStaff(IN booking_id INT, IN customer_id INT, IN table_number INT, IN booking_date DATE, IN staff_id INT)
BEGIN
	
    DECLARE InsRows INT;
    DECLARE confirmation VARCHAR(100);
    DECLARE OkToInsert BOOL;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT "New Booking NOT added (exception). " AS "Confirmation";

	-- Let's check if the new booking can be inserted
    --
    IF isFreeBookingID(booking_id) = False  THEN
		SET OkToInsert = False;
        SET confirmation = CONCAT("BookingID ", booking_id, " in use. Can't insert a new booking.");
	ELSEIF  isFreeTableNumber(booking_date, table_number) = False THEN
		SET OkToInsert = False;
        SET confirmation = CONCAT("Table number ", table_number, " on ", booking_date, " is booked. Can't insert a new booking.");    
	ELSE
		SET OkToInsert = True;
	END IF;
        
    -- It looks like we can insert the new booking. Let's try
    --
    IF OkToInsert = True THEN
		INSERT INTO Bookings(BookingID, CustomerID, BookingDate, TableNumber, PlacedByStaffID)
			VALUES (booking_id, customer_id, booking_date, table_number, staff_id);
    
		SELECT IFNULL(ROW_COUNT(),0) INTO InsRows;
    
		IF InsRows = 1 THEN
			SET confirmation = CONCAT("New booking added.");
			COMMIT;
		ELSE
			SET confirmation = CONCAT("New booking NOT added.");
		END IF;
    END IF;
	
    SELECT confirmation;
END
$$


-- The procedure adds a new given booking record to the Bookings table
--
-- This version of the procedure keeps only the parameters specified in the task
-- PalcedByStaffID for the new booking is set to 1 by default
--
-- see also the comment before procedure AddBookingByStaff
--
CREATE PROCEDURE AddBooking(IN booking_id INT, IN customer_id INT, IN table_number INT, IN booking_date DATE)
BEGIN
	CALL AddBookingByStaff(booking_id, customer_id, table_number, booking_date, 1);
END
$$

DELIMITER ;



-- test how it works
--
CALL AddBooking(21018,3,4,'2023-04-05');