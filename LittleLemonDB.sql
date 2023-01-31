-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `LittleLemonDB` ;

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LittleLemonDB` DEFAULT CHARACTER SET utf8mb3 ;
USE `LittleLemonDB` ;

-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Customers` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(45) NOT NULL,
  `Surname` VARCHAR(45) NOT NULL,
  `Phone` INT UNSIGNED NOT NULL,
  `Email` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`StaffRoles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`StaffRoles` (
  `ID` TINYINT UNSIGNED NOT NULL,
  `Name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Staff` (
  `ID` SMALLINT UNSIGNED NOT NULL,
  `FirstName` VARCHAR(50) NOT NULL,
  `LastName` VARCHAR(50) NOT NULL,
  `RoleID` TINYINT UNSIGNED NULL DEFAULT NULL,
  `Salary` DECIMAL(9,2) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  INDEX `StaffRoles_FK_idx` (`RoleID` ASC) VISIBLE,
  CONSTRAINT `Staff_StaffRoles_FK`
    FOREIGN KEY (`RoleID`)
    REFERENCES `LittleLemonDB`.`StaffRoles` (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Tables`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Tables` (
  `ID` TINYINT UNSIGNED NOT NULL,
  `MaxNumOfGuests` TINYINT NOT NULL,
  `Description` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Bookings` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `CustomerID` INT UNSIGNED NOT NULL,
  `PlacedDateTime` DATETIME NOT NULL,
  `BookingDate` DATE NOT NULL,
  `BookingTime` TIME NOT NULL,
  `TableID` TINYINT UNSIGNED NOT NULL,
  `NumOfGuests` TINYINT UNSIGNED NOT NULL,
  `Remarks` VARCHAR(1000) NULL DEFAULT NULL,
  `PlacedByStaffID` SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `CustomersFK_idx` (`CustomerID` ASC) VISIBLE,
  INDEX `StaffFK_idx` (`PlacedByStaffID` ASC) VISIBLE,
  INDEX `TablesFK_idx` (`TableID` ASC) VISIBLE,
  CONSTRAINT `Bookings _Customers_FK`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `LittleLemonDB`.`Customers` (`ID`),
  CONSTRAINT `Bookings _Staff_FK`
    FOREIGN KEY (`PlacedByStaffID`)
    REFERENCES `LittleLemonDB`.`Staff` (`ID`),
  CONSTRAINT `Bookings _Tables_FK`
    FOREIGN KEY (`TableID`)
    REFERENCES `LittleLemonDB`.`Tables` (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Cuisines`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Cuisines` (
  `ID` TINYINT NOT NULL,
  `Name` VARCHAR(50) NOT NULL,
  `Description` VARCHAR(1000) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`MenuItemsCategories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`MenuItemsCategories` (
  `ID` TINYINT UNSIGNED NOT NULL,
  `Name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`MenuItems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`MenuItems` (
  `ID` SMALLINT UNSIGNED NOT NULL,
  `Name` VARCHAR(100) NOT NULL,
  `Description` VARCHAR(1000) NULL DEFAULT NULL,
  `MenuCategoryID` TINYINT UNSIGNED NOT NULL,
  `Price` DECIMAL(6,2) UNSIGNED NOT NULL,
  `Available` TINYINT(1) NULL DEFAULT NULL COMMENT '1 - TRUE :  available\\n0 - FALSE : not available',
  `CuisineID` TINYINT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `CuisinesFK_idx` (`CuisineID` ASC) VISIBLE,
  INDEX `MenuItemsCategoriesFK_idx` (`MenuCategoryID` ASC) VISIBLE,
  CONSTRAINT `MenuItems_Cuisines_FK`
    FOREIGN KEY (`CuisineID`)
    REFERENCES `LittleLemonDB`.`Cuisines` (`ID`),
  CONSTRAINT `MenuItems_MenuItemsCategories_FK`
    FOREIGN KEY (`MenuCategoryID`)
    REFERENCES `LittleLemonDB`.`MenuItemsCategories` (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`OrderDeliveryStatuses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`OrderDeliveryStatuses` (
  `ID` TINYINT NOT NULL,
  `Name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Orders` (
  `ID` INT UNSIGNED NOT NULL,
  `TableID` TINYINT UNSIGNED NOT NULL,
  `CustomerID` INT UNSIGNED NULL DEFAULT NULL,
  `OrderDateTime` DATETIME NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `TablesFK_idx` (`TableID` ASC) VISIBLE,
  INDEX `CustomersFK_idx` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `Orders_Customers_FK`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `LittleLemonDB`.`Customers` (`ID`),
  CONSTRAINT `Orders_Tables_FK`
    FOREIGN KEY (`TableID`)
    REFERENCES `LittleLemonDB`.`Tables` (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`OrdersMenuItems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`OrdersMenuItems` (
  `OrderID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `MenuItemID` SMALLINT UNSIGNED NOT NULL,
  `Price` DECIMAL(6,2) UNSIGNED NOT NULL,
  `Quantity` SMALLINT UNSIGNED NOT NULL,
  `DeliveryStatusID` TINYINT NOT NULL,
  `DeliveryDateTime` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`OrderID`, `MenuItemID`),
  INDEX `MenuItemID_idx` (`MenuItemID` ASC) VISIBLE,
  INDEX `DeliveryStatusID_idx` (`DeliveryStatusID` ASC) VISIBLE,
  CONSTRAINT `OrdersMenuItems_DeliveryStatus_FK`
    FOREIGN KEY (`DeliveryStatusID`)
    REFERENCES `LittleLemonDB`.`OrderDeliveryStatuses` (`ID`),
  CONSTRAINT `OrdersMenuItems_MenuItem_FK`
    FOREIGN KEY (`MenuItemID`)
    REFERENCES `LittleLemonDB`.`MenuItems` (`ID`),
  CONSTRAINT `OrdersMenuItems_Orders_FK`
    FOREIGN KEY (`OrderID`)
    REFERENCES `LittleLemonDB`.`Orders` (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
