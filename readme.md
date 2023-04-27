Meta Database Engineer
Capstone Project

author: lukostudy

work in progress ...  
.

# Week1
## Exercise: Create an ER diagram data model and implement it in MySQL 

### Task1  
```
LittleLemonDM.mwb - MySQL Workbench model file  
LittleLemonDM.png - ER diagram of the model  
```

### Task2  
```
LittleLemonDB_CREATE.sql - creates the tables and foreign keys  
LittleLemonDB_INSERT.sql - inserts data  
```

### Task3
```
show databases; - LittleLemonDB is on the list  
a few test queries has been run - worked fine  
```

# Week2
## Exercise: Create a virtual table to summarize data
### Task1
```
CreateVirtualTable_Task1.sql
- creates OrdersView that presents orders with quantity > 2
```
### Task2
```
CreateVirtualTable_Task2.sql  
- SQL query that presents customers with orders that cost more than $150
```
### Task3
```
CreateVirtualTable_Task3.sql
- SQL query that presents menu items for which more than 2 orders have been placed
```
## Exercise: Create optimized queries to manage and analyze data
### Task1
```
CreateOptimizedQueries_Task1.sql
- creates a procedure that displays the maximum ordered quantity in the Orders table. 
```
### Task2
```
CreateOptimizedQueries_Task2.sql
- creates a prepared statement called GetOrderDetail.
```
### Task3
```
CreateOptimizedQueries_Task3.sql
- creates a stored procedure called CancelOrder.
```
## Exercise: Create SQL queries to check available bookings based on user input
### Task1
```
Remarks:
1.
In the designed and implemented LittleLemonDB there have been already many Bookings records generated and used by the author to test the database. To run Task1, all records related to the dates and BookingIDs used in the task are deleted at the beginning of the SQL script prepared for Task1.
2.
Index was added for BookingDate in the Bookings table to improve efficiency since BookingDate can be used extensively for searching. This update was also made in the LittleLemodDM.mwb file. 
3.
The designed and implemented Bookings table stores also information about the Staff person who made the booking. Thus the INSERT SQL statements contain one more column to fill.

BookingsCheck_Task1.sql
- create the index mentioned in the remarks
- delete records mentioned in the remarks
- run INSERT statements
- select inserted records from the Booking table
```
### Task2
BookingsCheck_Task2.sql
- create CheckBooking procedure

### Task3
BookingsCheck_Task3.sql
- create AddValidBooking procedure

## Exercise: Create SQL queries to add and update bookings
### Task1
```
BookingsAddUpdate_Task1.sql
- implement a few supporting functions
- add one unique constraint to improve data consistency
- implement procedure AddBooking
- more details in comments in the file with the code
```
### Task2
```
BookingsAddUpdate_Task2.sql
- implement procedure UpdateBooking
- more details in comments in the file with the code
```
### Task3
```
BookingsAddUpdate_Task3.sql
- implement procedure CancelBooking
- more details in comments in the file with the code
```

# Week3
## Exercise: Set up the Tableau Workspace for data analysis
### Task1
```
- data_LittleLemon.xlsx loaded into Tableau
- Tableau file: data_LittleLemon_visualisation.twb is used for all the following tasks
- data filter added: country = US  
```
### Task2
```
- column Full Name split into two columns: First Name, Last Name
```
### Task3
```
- add calculated column Profit
```

## Exercise: Create interactive dashboard for sales and profits
### Task1
```
- Create a bar chart that shows customers sales
```
### Task2
```
- create a line chart to show the sales trend from 2019 to 2022
```
### Task3
```
- create a Bubble chart of sales for all customers
```
### Task4
```
- compare the sales of the three different cuisines
```




