# Project Title: Library Management System (LMS)

Project Duration - 1 months 

## Project Overview: 

The Library Management System (LMS) is a MySQL-based project that manages library resources such as books, members, borrowing records, and staff details. It incorporates relational database concepts, DML/DDL operations, and advanced SQL features like views, stored procedures, triggers, and transactions.

## Key Features: 

### 1.Database Design:

● A normalized schema for efficient storage and retrieval. 

● Create Tables for books, members, staff, borrow records, and book categories. 

### 2.Data Integrity: 

● Constraints like FOREIGN KEY, CHECK, and UNIQUE. 

● Triggers for consistent updates (e.g., decrementing book stock on borrowing). 

### 3.CRUD Operations:

● End-to-end operations for adding, updating, and deleting books, members, and borrowing records.

### 4.Advanced SQL 

● Use of stored procedures for routine tasks.
● Views for simplified reporting. 
● Transactions 
● Ensures atomic operations for borrowing and returning books. 
● Aggregated insights like most borrowed books or overdue fines.

## STORE PROCEDURES 

#### -- To Borrow a Book

CALL BorrrowBook (memeber_id,book_id);

#### -- To Return a Book

CALL ReturnBook (memeber_id,book_id);

#### -- To Add a New Book To the Books Table

CALL Add_New_Book(Title, Author, CategoryID, Stock);

#### -- To Borrow Multiple Books At the Same Time

Borrow_mul_Books (memberID, bookID1, bookID2 );

## VIEWS

--  1. Most Borrowed Books

select * from MostBorrowedBooks;

-- 2. Members With Active Borrowings

select * from ActiveBorrowings;

-- 3. Overdue Books

select * from CurrentOverdueBooks;

-- 4. Fines Summary

select * from FinesSummary;

-- 5. Best Borrowed Categories

select * from TopBorrowedCategories;

-- Use of trancations ,commit and rollback for better data integrity within the dataset


## FLOW OF QUERIES

1. A Book is Borrowed.

2. BorrowingRecords Table gets updated automaticaly with the help of Store Procedure.

3. ReturnDate is gets Set to NULL.

4. Members Table Gets updated automaticaly with the help of trigger in TotalBorrowed Column.

5. When a Book is Returned, then BorrowingRecords Table gets updated automaticaly with the help of Store Procedure.

6. If the Returnedate is Greater than 14 days Then Accordind to the Trigger for Due Amount The Due_amount Column gets updated.


## EER DIAGRAM

![image](https://github.com/user-attachments/assets/800cfb12-4034-410c-b5db-93c16dbf91bf)

 





















