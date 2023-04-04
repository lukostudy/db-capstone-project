-- MySQL Workbench Forward Engineering


-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `LittleLemonDB` ;

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LittleLemonDB` DEFAULT CHARACTER SET utf8mb4 ;
USE `LittleLemonDB` ;

-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Countries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Countries` (
  `CountryCode` CHAR(2) NOT NULL,
  `Name` VARCHAR(50) NOT NULL,
  `NumCode` VARCHAR(8) NOT NULL,
  `ISOCode3` VARCHAR(3) NOT NULL,
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC) VISIBLE,
  UNIQUE INDEX `ISOCode2_UNIQUE` (`CountryCode` ASC) VISIBLE,
  UNIQUE INDEX `ISOCode3_UNIQUE` (`ISOCode3` ASC) VISIBLE,
  PRIMARY KEY (`CountryCode`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Customers` (
  `CustomerID` INT NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(50) NOT NULL,
  `LastName` VARCHAR(50) NULL,
  `City` VARCHAR(50) NULL,
  `CountryCode` CHAR(2) NULL,
  `PhoneCountryCode` CHAR(2) NULL,
  `PhoneNumber` CHAR(10) NOT NULL,
  `Email` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`CustomerID`),
  INDEX `CustomersCountryCode_Country_FK_idx` (`CountryCode` ASC) VISIBLE,
  INDEX `CustomersPhoneCountryCode_Countries_FK_idx` (`PhoneCountryCode` ASC) VISIBLE,
  CONSTRAINT `CustomersCountryCode_Countries_FK`
    FOREIGN KEY (`CountryCode`)
    REFERENCES `LittleLemonDB`.`Countries` (`CountryCode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `CustomersPhoneCountryCode_Countries_FK`
    FOREIGN KEY (`PhoneCountryCode`)
    REFERENCES `LittleLemonDB`.`Countries` (`CountryCode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`StaffRoles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`StaffRoles` (
  `ID` TINYINT NOT NULL,
  `Name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Staff` (
  `StaffID` SMALLINT NOT NULL,
  `FirstName` VARCHAR(50) NOT NULL,
  `LastName` VARCHAR(50) NOT NULL,
  `RoleID` TINYINT NULL DEFAULT NULL,
  `Salary` DECIMAL(9,2) NULL DEFAULT NULL,
  PRIMARY KEY (`StaffID`),
  INDEX `StaffRoles_FK_idx` (`RoleID` ASC) VISIBLE,
  CONSTRAINT `Staff_StaffRoles_FK`
    FOREIGN KEY (`RoleID`)
    REFERENCES `LittleLemonDB`.`StaffRoles` (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Bookings` (
  `BookingID` INT NOT NULL AUTO_INCREMENT,
  `CustomerID` INT NOT NULL,
  `BookingDate` DATE NOT NULL,
  `TableNumber` TINYINT NOT NULL,
  `PlacedByStaffID` SMALLINT NOT NULL,
  PRIMARY KEY (`BookingID`),
  INDEX `CustomersFK_idx` (`CustomerID` ASC) VISIBLE,
  INDEX `StaffFK_idx` (`PlacedByStaffID` ASC) VISIBLE,
  CONSTRAINT `Bookings _Customers_FK`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `LittleLemonDB`.`Customers` (`CustomerID`),
  CONSTRAINT `Bookings _Staff_FK`
    FOREIGN KEY (`PlacedByStaffID`)
    REFERENCES `LittleLemonDB`.`Staff` (`StaffID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`DeliveryStatuses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`DeliveryStatuses` (
  `DeliveryStatusID` TINYINT NOT NULL,
  `Name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`DeliveryStatusID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Cuisines`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Cuisines` (
  `CuisineID` TINYINT NOT NULL,
  `Name` VARCHAR(20) NULL,
  PRIMARY KEY (`CuisineID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Menus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Menus` (
  `MenuID` SMALLINT NOT NULL,
  `Name` VARCHAR(10) NOT NULL,
  `CuisineID` TINYINT NOT NULL,
  PRIMARY KEY (`MenuID`),
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC) VISIBLE,
  INDEX `fk_Menus_Cuisines1_idx` (`CuisineID` ASC) VISIBLE,
  CONSTRAINT `Menus_Cuisines_FK`
    FOREIGN KEY (`CuisineID`)
    REFERENCES `LittleLemonDB`.`Cuisines` (`CuisineID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Orders` (
  `OrderID` INT NOT NULL,
  `CustomerID` INT NOT NULL,
  `MenuID` SMALLINT NOT NULL,
  `TotalCost` DECIMAL(6,2) NOT NULL,
  `Quantity` SMALLINT NOT NULL,
  `OrderDate` DATE NOT NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `CustomersFK_idx` (`CustomerID` ASC) VISIBLE,
  INDEX `fk_Orders_Menus1_idx` (`MenuID` ASC) VISIBLE,
  CONSTRAINT `Orders_Customers_FK`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `LittleLemonDB`.`Customers` (`CustomerID`),
  CONSTRAINT `Orders_Menus_FK`
    FOREIGN KEY (`MenuID`)
    REFERENCES `LittleLemonDB`.`Menus` (`MenuID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`OrdersDeliveryStatuses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`OrdersDeliveryStatuses` (
  `OrderID` INT NOT NULL,
  `DeliveryStatusID` TINYINT NOT NULL,
  `StatusDate` DATE NULL,
  PRIMARY KEY (`OrderID`, `DeliveryStatusID`),
  INDEX `OrdersDeliveryStatuses_DeliveryStatuses_FK_idx` (`DeliveryStatusID` ASC) VISIBLE,
  CONSTRAINT `OrdersDeliveryStatuses_Orders_FK`
    FOREIGN KEY (`OrderID`)
    REFERENCES `LittleLemonDB`.`Orders` (`OrderID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `OrdersDeliveryStatuses_DeliveryStatuses_FK`
    FOREIGN KEY (`DeliveryStatusID`)
    REFERENCES `LittleLemonDB`.`DeliveryStatuses` (`DeliveryStatusID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`MenuItems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`MenuItems` (
  `MenuItemID` INT NOT NULL,
  `Name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`MenuItemID`),
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`MenuSelectionCategory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`MenuSelectionCategory` (
  `MenuSelCatID` TINYINT NOT NULL,
  `Name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`MenuSelCatID`),
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`MenusSelection`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`MenusSelection` (
  `MenuID` SMALLINT NOT NULL,
  `MenuSelCatID` TINYINT NOT NULL,
  `MenuItemID` INT NOT NULL,
  INDEX `fk_MenuSelection_Menus1_idx` (`MenuID` ASC) VISIBLE,
  INDEX `fk_MenuSelection_MenuSelectionCategory1_idx` (`MenuSelCatID` ASC) VISIBLE,
  INDEX `fk_MenuSelection_MenuItems1_idx` (`MenuItemID` ASC) VISIBLE,
  CONSTRAINT `MenuSelection_Menus_FK`
    FOREIGN KEY (`MenuID`)
    REFERENCES `LittleLemonDB`.`Menus` (`MenuID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `MenuSelection_MenuSelectionCategory_FK`
    FOREIGN KEY (`MenuSelCatID`)
    REFERENCES `LittleLemonDB`.`MenuSelectionCategory` (`MenuSelCatID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `MenuSelection_MenuItems_FK`
    FOREIGN KEY (`MenuItemID`)
    REFERENCES `LittleLemonDB`.`MenuItems` (`MenuItemID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


