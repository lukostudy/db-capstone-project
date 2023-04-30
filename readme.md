Meta Database Engineer  
----------------------
Capstone Project
----------------

&nbsp;

author: lukostudy  
April, 2023

&nbsp;

Please read this file before running the scripts. 

&nbsp;

This file contains the folowing sections:  
-----------------------------------------
- Grading Guide  
- List of files with descriptions  
- How to run the scripts  - short guide
- Work log - some detatails about all exercises in the project  

&nbsp;

IMPORTANT!!!
------------
LittleLemonDB will be deleted and created from scratch!  
These scripts can be run only in a test environment!  
If you have a database named LittleLemonDB in your MySQL instance, the scripts will drop (delete) it!**

&nbsp;

There is a pretty big set of test data prepared for the database to make it a bit closer to reality and make the project more interesting.
There are around 21k records inserted into the database. It sounds like a big data set but in reality, it's not. It takes around 30s to load these records.

&nbsp;


# Grading guide

This guide relates to the **grading criteria** defined by the authors of the course.

&nbsp;

1. Was the GitHub repo successfully created?  
Here is a link to the GitHub repo:  
https://github.com/lukostudy/db-capstone-project


2. Is the appropriate project found in the GitHub repo?  
The information about the project is in this readme.md file (start point) and all other files.

3. Does it include an appropriate ER diagram showing the connections between the tables?  
The diagram is presented in the file: 
[LittleLemonDM.png](https://github.com/lukostudy/db-capstone-project/blob/master/LittleLemonDM.png)  
It can be also viewed in the MySQL Workbench project file 
[LittleLemonDB.nwb](https://github.com/lukostudy/db-capstone-project/blob/master/LittleLemonDM.mwb)

4. Was the procedures:
        GetMaxQuantity()
        ManageBooking()
        UpdateBooking()
        AddBooking()
        CancelBooking()
    properly implemented?  
    GetMaxQuantity() implemented in file: [CreateOptimizedQueries_Task1.sql](https://github.com/lukostudy/db-capstone-project/blob/master/CreateOptimizedQueries_Task1.sql)  
    ManageBooking()  - not defined in the project - see more details below.  
    UpdateBooking() implemented in file: [BookingsAddUpdate_Task2.sql](https://github.com/lukostudy/db-capstone-project/blob/master/BookingsAddUpdate_Task2.sql)    
    AddBooking() implemented in file: [BookingsAddUpdate_Task1.sql](https://github.com/lukostudy/db-capstone-project/blob/master/BookingsAddUpdate_Task1.sql)    
    CancelBooking() implemented in file: [BookingsAddUpdate_Task3.sql](https://github.com/lukostudy/db-capstone-project/blob/master/BookingsAddUpdate_Task3.sql)  
    
    **The issue with ManageBooking():**  
    There isn't such a procedure like ManageBooking() defined in the capstone project specification.
    Therefore it's not implemented. It's probably a bug in the description of the peer-graded assignment. 
    There are three more procedures defined in the project related to booking which are listed below.  

    AddValidBooking() implemented in file: [BookingsCheck_Task3.sql](https://github.com/lukostudy/db-capstone-project/blob/master/BookingsCheck_Task3.sql)  
    CheckBooking() implemented in file: [BookingsCheck_Task2.sql](https://github.com/lukostudy/db-capstone-project/blob/master/BookingsCheck_Task2.sql)  
    UpdateBooking() implemented in files [BookingsAddUpdate_Task2.sql](https://github.com/lukostudy/db-capstone-project/blob/master/BookingsAddUpdate_Task2.sql)  



&nbsp;



# List of files

## SQL scripts
These two scripts will create the ```LittleLemonDB``` database and insert data into the created database.  
**Be aware that if** ```LittleLemonDB``` **exists, it will be DROPPED (DELETED) before the new db is created!**  
There are 21k records to be inserted. It can take around 30 seconds to run the scripts.  
```
LittleLemonDB_CREATE.sql
LittleLemonDB_INSERT.sql
```
Each one of the following SQL scripts contains SQL script for one task defined in the capstone project.  
Each file's name contains a shortened version of an exercise name and a task number.
```
CreateVirtualTable_Task1.sql
CreateVirtualTable_Task2.sql
CreateVirtualTable_Task3.sql

CreateOptimizedQueries_Task1.sql
CreateOptimizedQueries_Task2.sql
CreateOptimizedQueries_Task3.sql

BookingsCheck_Task1.sql
BookingsCheck_Task2.sql
BookingsCheck_Task3.sql

BookingsAddUpdate_Task1.sql
BookingsAddUpdate_Task2.sql
BookingsAddUpdate_Task3.sql
```
**Run all scripts at once.**  
You can run all SQL scripts listed above using the following script.
**Be aware that this script includes creating the database and inserting the records.**
```
run_all_scripts.sql
```

## Tableu and xlsx files
The xlsx file contains source data for the exercises and 
the twb file contains the results of the exercise "Create an interactive dashboard for sales and profits" in Week 3.
More details in the Work Log.
```
data_LittleLemon.xlsx
data_LittleLemon_visualisation.twb
```
## Jupyter Notebook files
The results of the exercise "Add query functions" in Week 3. More details in the Work log.
```
DatabaseClient.ipynb
```
This file is out of the scope of the project. It prepares this big set of test data for the database.
It's not needed to run this file because all INSERT statements are ready to use in the sql file,
which was generated with this file.
```
prepare_data_for_DB.ipynb
```

&nbsp;

# How to run the scripts:  
Prerequisites:  
1. MySQL instance running that can be used for testing
2. MySQL account with admin privileges that allow to drop and create all database objects.

You can use MySQL shell (mysqlsh) or MySQL Workbench.

&nbsp;

## MySQL shell (mysqlsh)  
When MySQL shell is started, run the ```\connect``` command using a proper username and server IP/hostname.  
Example with local MySQL instance and admin user:
```
\connect admin@127.0.0.1
```
Change your current directory to the one where the scripts are located. You can do it by using the command:
```
\system cd "the_directory_path"
```
for example:
```
\system cd "/Users/user1/working_directory"
```
Make sure that you can see the scripts by running the command:
(in Windows replace "ls" with "dir")
```
\system ls
```
Switch to SQL mode with the command:
```
\sql
```
Now, when you are connected in SQL mode, you can run every script, running a command:
```
source script_name
```
for example:  
```
source LittleLemonDB_CREATE.sql
```

&nbsp;

## MySQL Workbench
Create a new or use an existing connection to the database using a proper username and a server IP/hostname.  
Once you have the connection up and running, you can open a script you want to run using ```File -> [Open SQL Script]``` option or a relevant icon.   
When the script you want to run is open, you can run it using "thunder" icon or 
```Query -> [Execute (All or selection)]``` option.


&nbsp;


# Work log

```text
===================================================================
Week 1
======

-------------------------------------------------------------------
Exercise: Create an ER diagram data model and implement it in MySQL 
--------

Task 1  
------
LittleLemonDM.mwb - MySQL Workbench model file  
LittleLemonDM.png - ER diagram of the model  

Task 2
------
LittleLemonDB_CREATE.sql - creates the tables and foreign keys  
LittleLemonDB_INSERT.sql - inserts data

Task 3
------
show databases - LittleLemonDB is on the list  
a few test queries have been run - worked fine  


===================================================================
Week 2
======

-------------------------------------------------------------------
Exercise: Create a virtual table to summarize data
---------

Task 1
------
CreateVirtualTable_Task1.sql
- creates OrdersView that presents orders with quantity > 2

Task 2
------
CreateVirtualTable_Task2.sql  
- SQL query that presents customers with orders that cost more than $150

Task 3
------
CreateVirtualTable_Task3.sql
- SQL query that presents menu items for which more than 2 orders have been placed


-------------------------------------------------------------------
Exercise: Create optimized queries to manage and analyze data
---------

Task 1
------
CreateOptimizedQueries_Task1.sql
- creates a procedure that displays the maximum ordered quantity in the Orders table. 

Task 2
------
CreateOptimizedQueries_Task2.sql
- creates a prepared statement called GetOrderDetail.

Task 3
------
CreateOptimizedQueries_Task3.sql
- creates a stored procedure called CancelOrder.

-------------------------------------------------------------------
Exercise: Create SQL queries to check available bookings based on user input
---------

Task 1
------
Remarks:
1. In the designed and implemented LittleLemonDB there have been already many Bookings records generated and used by the author to test the database. To run Task1, all records related to the dates and BookingIDs used in the task are deleted at the beginning of the SQL script prepared for Task1.
2. Index was added for BookingDate in the Bookings table to improve efficiency since BookingDate can be used extensively for searching. This update was also made in the LittleLemodDM.mwb file. 
3. The designed and implemented Bookings table stores also information about the Staff person who made the booking. Thus the INSERT SQL statements contain one more column to fill.

BookingsCheck_Task1.sql
- create the index mentioned in the remarks
- delete records mentioned in the remarks
- run INSERT statements
- select inserted records from the Booking table

Task 2
------
BookingsCheck_Task2.sql
- create CheckBooking procedure

Task 3
------
BookingsCheck_Task3.sql
- create AddValidBooking procedure

-------------------------------------------------------------------
Exercise: Create SQL queries to add and update bookings
---------

Task 1
------
BookingsAddUpdate_Task1.sql
- implement a few supporting functions
- add one unique constraint to improve data consistency
- implement procedure AddBooking
- more details in comments in the file with the code

Task 2
------
BookingsAddUpdate_Task2.sql
- implement procedure UpdateBooking
- more details in comments in the file with the code

Task 3
------
BookingsAddUpdate_Task3.sql
- implement procedure CancelBooking
- more details in comments in the file with the code



===================================================================
Week 3
======

-------------------------------------------------------------------
Exercise: Set up the Tableau Workspace for data analysis
---------

Task 1,2,3
----------
- data_LittleLemon.xlsx loaded into Tableau
- data filter added: country = US  
- column Full Name split into two columns: First Name, Last Name
- add calculated column Profit
The results are in the file: 
data_LittleLemon_visualisation.twb

-------------------------------------------------------------------
Exercise: Create interactive dashboard for sales and profits
---------

Task 1,2,3,4,5
--------------
- Create a bar chart that shows customers sales
- create a line chart to show the sales trend from 2019 to 2022
- create a Bubble chart of sales for all customers
- compare the sales of the three different cuisines
- create an interactive dashboard that combines the Bar chart called Customers Sales and the Sales Bubble Chart
The results are in the file: 
data_LittleLemon_visualisation.twb


-------------------------------------------------------------------
Exercise: Set up the client project
---------
Task 1,2,3
----------
- checking python version
- jupyter notebook installed
- mysql-connector-python installed
- mysql-connection verified successfully
All the above tasks were completed.


-------------------------------------------------------------------
Exercise: Add query functions
---------
Task 1,2,3
----------
- connect with your database
- query the database to show all tables within the database
- query the database to show customers with orders over 60$
The results are in the file:
DatabaseClient.ipynb

```