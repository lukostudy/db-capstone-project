-- Meta Database Engineer Capstone Project 
-- Run all scripts
-- 
-- This script runs all sql scripts created in this projects
-- You can use this script if you don't want to run the scripts one-by-one
-- It can also be used as a kind of a order guide
-- -----------------------------------------------------------------------------


-- create database and all the tables
source LittleLemonDB_CREATE.sql;

-- insert data into the database
-- this can take around 30s
-- around 21k records will be inserted
source LittleLemonDB_INSERT.sql;

-- exercise: [week2] Create a virtual table to summarize data
source CreateVirtualTable_Task1.sql;
source CreateVirtualTable_Task2.sql;
source CreateVirtualTable_Task3.sql;

-- exercise: [week2] Create optimized queries to manage and analyze data
source CreateOptimizedQueries_Task1.sql;
source CreateOptimizedQueries_Task2.sql;
source CreateOptimizedQueries_Task3.sql;

-- exercise: [week2] Create SQL queries to check available bookings based on user input
source BookingsCheck_Task1.sql;
source BookingsCheck_Task2.sql;
source BookingsCheck_Task3.sql;

-- exercise: [week2] Create SQL queries to add and update bookings
source BookingsAddUpdate_Task1.sql;
source BookingsAddUpdate_Task2.sql;
source BookingsAddUpdate_Task3.sql;
