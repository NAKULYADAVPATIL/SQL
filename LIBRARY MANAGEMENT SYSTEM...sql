====================== LIBRARY MANAGEMENT SYSTEM PROJECT ================================

-- Creating a Database LMS --

CREATE DATABASE LMS;

-- Database Selection Command (DDL) ----

USE LMS;

-- ======================== DATA DEFINATION LANGUAGE (DDL) ======================================

-- Creating Tables to Store the Data ------

-- 1.CATEGORIES TABLES ------

CREATE TABLE Categories (
CategoryID INT PRIMARY KEY AUTO_INCREMENT, 
CategoryName VARCHAR(50) UNIQUE NOT NULL
);

-- ======================================================================

-- 2.BOOKS TABLE ----

CREATE TABLE Books (
    BookID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(255) NOT NULL,
    Author VARCHAR(255) NOT NULL,
    CategoryID INT,
    Stock INT NOT NULL CHECK (Stock >= 0),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
        ON DELETE SET NULL
);

-- ==============================================================================

-- 3.MEMBERS TABLE

CREATE TABLE Members (
    MemberID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    MemberType ENUM('Student', 'Staff') NOT NULL,
    Phone VARCHAR(15) UNIQUE NOT NULL
);

-- ========================================================================

-- 4.Staff Table

CREATE TABLE Staff (
    StaffID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Position VARCHAR(100) NOT NULL,
    Phone VARCHAR(15) UNIQUE NOT NULL
);

-- ========================================================================

-- 5.BorrowingRecords Table

CREATE TABLE BorrowingRecords (
    RecordID INT PRIMARY KEY AUTO_INCREMENT,
    BookID INT,
    MemberID INT,
    BorrowDate DATE NOT NULL,
    ReturnDate DATE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID) ON DELETE CASCADE,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID) ON DELETE CASCADE
);

-- ==========================================================================

-- 6.MEMBER DELETION LOG TABLE (USED WITH BEFORE DELETE TRIGGER)

CREATE TABLE MemberDeletionLog (
    LogID INT AUTO_INCREMENT PRIMARY KEY,
    MemberID INT,
    Name VARCHAR(255),
    Email VARCHAR(255),
    MemberType ENUM('Student', 'Staff'),
    Phone VARCHAR(15),
    DeletedAt DATE
);

-- ===================================================================================

-- 7. STAFF DELETED TABLE (USED WITH AFTER DELETE TRIGGER)

CREATE TABLE DeletedStaffLogs (
    LogID INT PRIMARY KEY AUTO_INCREMENT,
    StaffID INT,
    Name VARCHAR(100),
    Position VARCHAR (100),
    DeletedAt DATETIME
);

-- ================================ TRIGGERS (STORED PROGRAM) ==============================================
-- 1. TRIGGER FOR MEMBER DELETION 

DELIMITER //
CREATE TRIGGER log_member_delete
BEFORE DELETE ON Members
FOR EACH ROW
BEGIN
    INSERT INTO MemberDeletionLog (MemberID, Name, Email, MemberType, Phone, DeletedAt)
    VALUES (OLD.MemberID, OLD.Name, OLD.Email, OLD.MemberType, OLD.Phone, CURDATE());
END;//
DELIMITER ;

-- ========================================================================================
-- 2. TRIGGER FOR STAFF DELETION

DELIMITER //
CREATE TRIGGER log_staff_delete
AFTER DELETE ON library_staff
FOR EACH ROW
BEGIN
    INSERT INTO DeletedStaffLogs (StaffID, Name, Position,DeletedAt)
    VALUES (OLD.StaffID, OLD.Name, OLD.Position, NOW());
END;
//
DELIMITER ;

-- ================================= INSERTING VALUES (DML) =======================================


INSERT INTO Categories (CategoryName) VALUES
('Fiction'), ('Non-Fiction'), ('Science'), ('Mathematics'), ('History'),
('Biographies'), ('Philosophy'), ('Technology'), ('Psychology'), ('Literature'),
('Business'), ('Art'), ('Politics'), ('Travel'), ('Cooking'), ('Religion'), 
('Self-Help'), ('Health'), ('Education'), ('Sports');


INSERT INTO Books VALUE
(1, 'Wings of Fire', 'A.P.J. Abdul Kalam', 6, 10), (2, 'The Alchemist', 'Paulo Coelho', 1, 8),
(3, 'Sapiens', 'Yuval Noah Harari', 2, 12),(4, 'Brief History of Time', 'Stephen Hawking', 3, 7), 
(5, 'Ramayana', 'Valmiki', 16, 15), (6, 'The Great Indian Novel', 'Shashi Tharoor', 1, 9),
(7, 'India After Gandhi', 'Ramachandra Guha', 5, 6), (8, 'Think and Grow Rich', 'Napoleon Hill', 11, 14), 
(9, 'The Art of War', 'Sun Tzu', 7, 10), (10, 'Rich Dad Poor Dad', 'Robert Kiyosaki', 11, 8), 
(11, 'The Monk Who Sold His Ferrari', 'Robin Sharma', 17, 11), (12, 'You Can Win', 'Shiv Khera', 17, 13),
(13, 'Cooking for Beginners', 'Tarla Dalal', 15, 5), (14, 'The Blue Umbrella', 'Ruskin Bond', 10, 20), 
(15, 'A Suitable Boy', 'Vikram Seth', 1, 7),(16, 'Mahabharata', 'Vyasa', 16, 9), 
(17, 'Panchatantra', 'Vishnu Sharma', 10, 8), (18, 'A Journey to the Center of the Earth', 'Jules Verne', 14, 6),
(19, 'The Secret', 'Rhonda Byrne', 17, 18), (20, 'Gitanjali', 'Rabindranath Tagore', 10, 10);


INSERT INTO Members (MemberID, Name, Email, MemberType, Phone) VALUES
(1, 'Aarav Gupta', 'aarav.gupta@gmail.com', 'Student', '9876543210'),
(2, 'Riya Sharma', 'riya.sharma@gmail.com', 'Student', '9876543211'),
(3, 'Vikram Singh', 'vikram.singh@gmail.com', 'Staff','9876543212'),
(4, 'Ananya Iyer', 'ananya.iyer@gmail.com', 'Student','9876543213'),
(5, 'Rahul Mehta', 'rahul.mehta@gmail.com', 'Staff', '9876543214'),
(6, 'Diya Patel', 'diya.patel@gmail.com', 'Student', '9876543215'),
(7, 'Arjun Nair', 'arjun.nair@gmail.com', 'Staff', '9876543216'),
(8, 'Neha Desai', 'neha.desai@gmail.com', 'Student','9876543217'),
(9, 'Rohan Joshi', 'rohan.joshi@gmail.com', 'Staff', '9876543218'),
(10, 'Meera Reddy', 'meera.reddy@gmail.com', 'Student','9876543219'),
(11, 'Ishaan Malhotra', 'ishaan.malhotra@gmail.com', 'Student','9876543220'),
(12, 'Tara Kapoor', 'tara.kapoor@gmail.com', 'Student','9876543221'),
(13, 'Aman Choudhary', 'aman.choudhary@gmail.com', 'Staff','9876543222'),
(14, 'Anushka Jain', 'anushka.jain@gmail.com', 'Student','9876543223'),
(15, 'Harsh Bansal', 'harsh.bansal@gmail.com', 'Staff','9876543224'),
(16, 'Priya Saxena', 'priya.saxena@gmail.com', 'Student','9876543225'),
(17, 'Karan Verma', 'karan.verma@gmail.com', 'Staff','9876543226'),
(18, 'Sneha Bhatt', 'sneha.bhatt@gmail.com', 'Student','9876543227'),
(19, 'Ravi Kumar', 'ravi.kumar@gmail.com', 'Staff', '9876543228'),
(20, 'Sanjana Deshmukh', 'sanjana.deshmukh@gmail.com', 'Student', '9876543229');


INSERT INTO Staff (StaffID, Name, Email, Position, Phone) VALUES
(1, 'Rajesh Kumar', 'rajesh.kumar@gmail.com', 'Librarian', '9876543230'),
(2, 'Sneha Reddy', 'sneha.reddy@gmail.com', 'Assistant Librarian', '9876543231'),
(3, 'Amit Sharma', 'amit.sharma@gmail.com', 'Clerk', '9876543232'),
(4, 'Pooja Iyer', 'pooja.iyer@gmail.com', 'Manager', '9876543233'),
(5, 'Rakesh Mehta', 'rakesh.mehta@gmail.com', 'Data Entry', '9876543234'),
(6, 'Ishita Desai', 'ishita.desai@gmail.com', 'Assistant', '9876543235'),
(7, 'Nikhil Joshi', 'nikhil.joshi@gmail.com', 'Supervisor', '9876543236'),
(8, 'Rohit Kapoor', 'rohit.kapoor@gmail.com', 'Library Assistant', '9876543237'),
(9, 'Sakshi Verma', 'sakshi.verma@gmail.com', 'Book Organizer', '9876543238'),
(10, 'Anil Gupta', 'anil.gupta@gmail.com', 'Library Technician', '9876543239'),
(11, 'Komal Bhatt', 'komal.bhatt@gmail.com', 'Assistant', '9876543240'),
(12, 'Manoj Choudhary', 'manoj.choudhary@gmail.com', 'System Administrator', '9876543241'),
(13, 'Divya Saxena', 'divya.saxena@gmail.com', 'Event Manager', '9876543242'),
(14, 'Aakash Jain', 'aakash.jain@gmail.com', 'Research Assistant', '9876543243'),
(15, 'Kavya Malhotra', 'kavya.malhotra@gmail.com', 'Library Cataloger', '9876543244'),
(16, 'Uday Bansal', 'uday.bansal@gmail.com', 'Maintenance', '9876543245'),
(17, 'Naina Bhatt', 'naina.bhatt@gmail.com', 'Clerk', '9876543246'),
(18, 'Mohit Kumar', 'mohit.kumar@gmail.com', 'Coordinator', '9876543247'),
(19, 'Simran Kapoor', 'simran.kapoor@gmail.com', 'Supervisor', '9876543248'),
(20, 'Aditya Desai', 'aditya.desai@gmail.com', 'Manager', '9876543249');


INSERT INTO BorrowingRecords (BookID, MemberID, BorrowDate, ReturnDate) VALUES
(4, 7, '2024-12-01', '2024-12-15'),
(9, 5, '2024-12-02', '2024-12-16'),
(2, 1, '2024-12-03', '2024-12-17'),
(6, 9, '2024-12-04', '2024-12-18'),
(10, 2, '2024-12-05', '2024-12-19'),
(1, 6, '2024-12-06', '2024-12-20'),
(11, 4, '2024-12-07', '2024-12-21'),
(5, 10, '2024-12-08', '2024-12-22'),
(3, 8, '2024-12-09', '2024-12-23'),
(13, 12, '2024-12-10', '2024-12-24'),
(7, 3, '2024-12-11', '2024-12-25'),
(8, 13, '2024-12-12', '2024-12-26'),
(12, 11, '2024-12-13', '2024-12-27');

-- ========================================== INSERTING SAMPLE DATA (DML) =======================================

-- Categories

INSERT INTO Categories (CategoryName) VALUES
('Science Fiction'),
('Mystery'),
('Romance'),
('Space Research');

-- Books.

INSERT INTO Books (Title, Author, CategoryID, Stock) VALUES
('Dune', 'Frank Herbert', 21, 5),
('Sherlock Holmes', 'Arthur Conan Doyle', 22, 8),
('Pride and Prejudice', 'Jane Austen', 23, 4),
('Cosmos', 'Carl Sagan', 24, 7);

-- Members

INSERT INTO Members (Name, Email, MemberType, Phone) VALUES
('Ravi Gupta', 'rgupta@example.com', 'Student', '8452136794'),
('Ashish Pandey', 'apandey@example.com', 'Staff', '7458213654');

-- Staff

INSERT INTO Staff (Name, Email, Position, Phone) VALUES
('Akash Chopra', 'akchopra@gmail.com', 'Librarian', '9487961148'),
('Sumit Tyagi', 'styagi@gmail.com', 'Book Organizer', '8654792153');

-- BorrowingRecords

INSERT INTO BorrowingRecords (BookID, MemberID, BorrowDate, ReturnDate) VALUES
(14, 15, '2024-12-14', '2024-12-28'),
(15, 8,  '2024-12-15', '2024-12-29'),
(16, 6,  '2024-12-16', '2024-12-30'),
(17, 9,  '2024-12-17', '2024-12-31'),
(18, 2,  '2024-12-18', '2025-01-01'),
(19, 5,  '2024-12-19', '2025-01-02'),
(20, 12, '2024-12-20', '2025-01-03'),
(21, 3,  '2024-12-21', '2025-01-04'),
(22, 10, '2024-12-22', '2025-01-05'),
(23, 4,  '2024-12-23', '2025-01-06');

-- ===============================================================

INSERT INTO Members (Name, Email, MemberType, Phone) VALUES
('Kirti Sharma', 'ksharma@gmail.com', 'Student','6541257893'),
('Mayur More', 'mmore@example.com', 'Staff', '6421578923');

-- TO CHECK WHERE THE MEMBERDELETIONLOG GETS TRIGGERED AFTER DELETE OR NOT

Delete from Members where MemberID = 24;  -- (DML)
-- ================================================================
-- To Avoid Confusion Between Staff Table and Member Type --------

   ALTER TABLE Satff RENAME TO library_staff;  -- (DDL)
   
-- ====================== STORE PROCEDURES (STORED PROGRAM) =======================

-- 1. FOR BORROWING A BOOK ........

DELIMITER //
CREATE PROCEDURE BorrowBook(
    IN p_MemberID INT,
    IN p_BookID INT
)
BEGIN
    DECLARE availableStock INT;

    -- Check stock
    SELECT Stock INTO availableStock FROM Books WHERE BookID = p_BookID;

    IF availableStock > 0 THEN
        -- Record borrowing
        INSERT INTO BorrowingRecords (BookID, MemberID, BorrowDate)
        VALUES (p_BookID, p_MemberID, CURDATE());

        -- Reduce stock
        UPDATE Books SET Stock = Stock - 1 WHERE BookID = p_BookID;
    ELSE
        -- If no stock, show error
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Book not available';
    END IF;
END;//
DELIMITER ;


call BorrowBook(8,19);

-- ==============================================================================

-- 2. FOR RETURNING A BOOK ........

DELIMITER //
CREATE PROCEDURE ReturnBook(
    IN p_MemberID INT,
    IN p_BookID INT
)
BEGIN
    DECLARE recordCount INT;

    -- Check if there’s an active borrow (unreturned book)
    SELECT COUNT(*) INTO recordCount
    FROM BorrowingRecords
    WHERE BookID = p_BookID AND MemberID = p_MemberID AND ReturnDate IS NULL;

    IF recordCount > 0 THEN
        -- Update the first unreturned borrow record
        UPDATE BorrowingRecords
        SET ReturnDate = CURDATE()
        WHERE BookID = p_BookID AND MemberID = p_MemberID AND ReturnDate IS NULL
        LIMIT 1;

        -- Increase book stock by 1
        UPDATE Books
        SET Stock = Stock + 1
        WHERE BookID = p_BookID;

    ELSE
        -- Raise an error if no active borrow found
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No active borrow record found for this book and member';
    END IF;

END;
//
DELIMITER ;

call returnbook(8,19);

-- ===========================================================================================

-- 3. TO BORROW MULTIPLE BOOKS

DELIMITER $$

CREATE PROCEDURE Borrow_mul_Books (IN memberID INT, IN bookID1 INT, IN bookID2 INT)
BEGIN
    DECLARE successCount INT DEFAULT 0;

    START TRANSACTION;

    -- Attempt to borrow book 1
    UPDATE Books SET Stock = Stock - 1 WHERE BookID = bookID1 AND Stock > 0;
    IF ROW_COUNT() > 0 THEN
        INSERT INTO BorrowingRecords (BookID, MemberID, BorrowDate)
        VALUES (bookID1, memberID, CURDATE());
        SET successCount = successCount + 1;
    END IF;

    -- Attempt to borrow book 2
    UPDATE Books SET Stock = Stock - 1 WHERE BookID = bookID2 AND Stock > 0;
    IF ROW_COUNT() > 0 THEN
        INSERT INTO BorrowingRecords (BookID, MemberID, BorrowDate)
        VALUES (bookID2, memberID, CURDATE());
        SET successCount = successCount + 1;
    END IF;

    -- If both books were successfully borrowed
    IF successCount = 2 THEN
        COMMIT;
    ELSE
        ROLLBACK;
    END IF;

END$$

DELIMITER ; 

-- ===================================================================================
-- 4. TO ADD A NEW BOOK TO THE LIBRARY

DELIMITER //
CREATE PROCEDURE Add_New_Book(
    IN b_Title VARCHAR(255),
    IN b_Author VARCHAR(255),
    IN b_CategoryID INT,
    IN b_Stock INT
)
BEGIN
    INSERT INTO Books (Title, Author, CategoryID, Stock) 
    VALUES (b_Title, b_Author, b_CategoryID, b_Stock);
END //
DELIMITER ;

CALL Add_New_Book("The Power of Habbit", 'Charles Duhigg', 17, 5);

-- ============================================================

-- ADDING A NEW COLUMN TO THE BORROWINGRECORDS TABLE

ALTER TABLE BorrowingRecords ADD DueAmount VARCHAR(20); -- (DDL)

-- ===============================================================

SET SQL_SAFE_UPDATES = 0 ;    -- DISABLING SAFE UPADTE MODE TO UPDATE THE TABLE

-- UPDATING THE BORROWINGRECORDS TABLE BEFORE CREATING A DUE AMOUNT TRIGGER

UPDATE BorrowingRecords
SET DueAmount = 
    CASE
        WHEN DATEDIFF(ReturnDate, BorrowDate) > 30 THEN 'book price'
        WHEN DATEDIFF(ReturnDate, BorrowDate) BETWEEN 20 AND 30 THEN '400'
        WHEN DATEDIFF(ReturnDate, BorrowDate) > 14 THEN '100'
        ELSE '0'
    END
WHERE ReturnDate IS NOT NULL;
-- ===================================================================
-- 3. TRIGGER FOR CALCULATING DUE AMOUNT

DELIMITER //
CREATE TRIGGER calculate_due_amount
BEFORE UPDATE ON BorrowingRecords
FOR EACH ROW
BEGIN
    DECLARE diffDays INT;

    -- Only run if ReturnDate is not null and changing from null
    IF NEW.ReturnDate IS NOT NULL AND OLD.ReturnDate IS NULL THEN
        SET diffDays = DATEDIFF(NEW.ReturnDate, NEW.BorrowDate);

        -- Set DueAmount based on the date difference
        IF diffDays > 30 THEN
            SET NEW.DueAmount = 'book price';

        ELSEIF diffDays BETWEEN 20 AND 30 THEN
            SET NEW.DueAmount = '400';

        ELSEIF diffDays > 14 THEN
            SET NEW.DueAmount = '100';

        ELSE
            SET NEW.DueAmount = '0';
        END IF;
    END IF;

END;
//
DELIMITER ;

call BorrowBook(5,5);

call Returnbook(5,5);

-- TO CHECK IF THE DUE AMOUNT TRIGGER GETS TRIGGERED ...

update borrowingrecords set returndate = '2025-05-17' where recordid = 31;

-- ========================== POPULATING BOOKS TABLE ==================================================

INSERT INTO books (Title, Author, CategoryID, Stock) VALUES
('The Silent Patient', 'Alex Michaelides', 22, 7),
('Atomic Habits', 'James Clear', 17, 10),
('21 Lessons for the 21st Century', 'Yuval Noah Harari', 2, 9),
('The Subtle Art of Not Giving a F*ck', 'Mark Manson', 17, 8),
('The Theory of Everything', 'Stephen Hawking', 3, 6),
('Zero to One', 'Peter Thiel', 11, 5),
('The Psychology of Money', 'Morgan Housel', 9, 7),
('The Art of Happiness', 'Dalai Lama', 6, 10),
('Cosmos', 'Carl Sagan', 3, 8),
('Ikigai', 'Héctor García', 17, 12),
('Think and Grow Rich', 'Napoleon Hill', 11, 9),
('The Origin of Species', 'Charles Darwin', 3, 5),
('The Book Thief', 'Markus Zusak', 1, 7),
('The Midnight Library', 'Matt Haig', 1, 8),
('Deep Work', 'Cal Newport', 17, 9),
('Steve Jobs', 'Walter Isaacson', 6, 6),
('Man’s Search for Meaning', 'Viktor E. Frankl', 9, 10),
('The Power of Now', 'Eckhart Tolle', 7, 8),
('Relativity: The Special & General Theory', 'Albert Einstein', 3, 4),
('Love in the Time of Cholera', 'Gabriel García Márquez', 23, 7);

-- ================================================================
ALTER TABLE Members ADD TotalBorrowed INT DEFAULT 0;  -- (DDL)

-- THE TOTAL_BORROWED COLUMN IS ADDED AFTER DATA INSERSTION SO WE HAVE TO UPDATE THE COLUMN DATA BEFORE CREATING A TRIGGER

set sql_safe_updates = 0;      -- DISABLING SAFE UPADTE MODE TO UPDATE THE TABLE

UPDATE Members m
SET TotalBorrowed = (
    SELECT COUNT(*)
    FROM BorrowingRecords br
    WHERE br.MemberID = m.MemberID
);

-- ====================================================================
-- 4. TRIGGER FOR CALCULATING BORROW_COUNT FOR EACH MEMBER

DELIMITER //
CREATE TRIGGER trg_increment_borrow_count
AFTER INSERT ON BorrowingRecords
FOR EACH ROW
BEGIN
    UPDATE Members
    SET TotalBorrowed = TotalBorrowed + 1
    WHERE MemberID = NEW.MemberID;
END;
//
DELIMITER ;

SHOW TRIGGERS;
-- ====================================================================
call returnbook (16,26);

call borrowbook(23,10);

call returnbook (23,10);
-- =================================================================
-- TO CHECK THE TRIGGER FOR DELETED_STAFF_LOGS

delete from library_staff where staffid = 9;

delete from library_staff where staffid = 19;

-- ================================ VIEWS (CREATING DDL USING DQL) ======================================
--  1. Most Borrowed Books

CREATE VIEW MostBorrowedBooks AS
SELECT 
    b.BookID, 
    b.Title, 
    COUNT(*) AS TimesBorrowed
FROM 
    Books b
JOIN 
    BorrowingRecords br ON b.BookID = br.BookID
GROUP BY 
    b.BookID, b.Title
ORDER BY 
    TimesBorrowed DESC;
    
select * from MostBorrowedBooks;
-- =========================================================
-- 2. Members With Active Borrowings

CREATE VIEW ActiveBorrowings AS
SELECT
	m.MemberID, 
    m.NAME, 
    COUNT(br.RecordID) AS active_borrowings
FROM  
    Members m
JOIN
     BorrowingRecords br ON m.MemberID = br.MemberID
WHERE 
	br.ReturnDate IS NULL
GROUP BY
     m.MemberID, m.NAME;
     
select * from ActiveBorrowings;
-- =============================================================
-- 3. Overdue Books

CREATE VIEW CurrentOverdueBooks AS
SELECT 
      br.RecordID, b.title, m.name, br.DueAmount
FROM 
    BorrowingRecords br
JOIN 
    Books b ON br.BookId = b.BookId
JOIN 
	Members m ON br.MemberId = m.MemberId
WHERE 
     br.ReturnDate IS NULL AND br.DueAmount > 0;

select * from CurrentOverdueBooks;
-- ===========================================================
-- 4. Members with Pending Fines

CREATE VIEW MembersWithFines AS
SELECT 
     DISTINCT m.MemberId, m.NAME
FROM 
    Members m
JOIN 
    BorrowingRecords br ON m.MemberId = br.MemberId
WHERE 
     DueAmount > 0 OR DueAmount = "book price";

select * from MembersWithFines;
-- ===========================================================
-- 5. Book Availability Summary

CREATE VIEW BookAvailability AS
SELECT 
      BookID, title, Stock
FROM 
    Books
where 
     Stock > 0;

select * from BookAvailability;
-- ===============================================================
-- 6. Borrowing History

CREATE VIEW BorrowingHistory AS
SELECT 
     br.RecordID, m.name AS member_name, b.title AS book_title, br.borrowdate, br.DueAmount, br.returndate
FROM 
    BorrowingRecords br
JOIN 
    Members m ON br.memberid = m.memberid
JOIN 
    Books b ON br.bookid = b.bookid;

select * from Borrowinghistory;
-- ========================================================================
-- 7. Fines Summary

CREATE VIEW FinesSummary AS
SELECT 
      m.memberid, m.name, SUM(br.dueamount) AS total_fines
FROM 
    Members m
JOIN 
    BorrowingRecords br ON m.memberid = br.memberid
GROUP BY 
     m.memberid, m.name;

select * from FinesSummary;
-- =======================================================================

-- 8. Books by Category
CREATE VIEW BooksByCategory AS
SELECT 
     b.CategoryID, c.Categoryname, COUNT(b.bookid) AS total_books
FROM 
    Books b
JOIN 
    Categories c ON b.CategoryID = c.CategoryID
GROUP BY 
      CategoryID;

select * from BooksByCategory;
-- =============================================================================
-- 9. Borrowings Per Month

CREATE VIEW BorrowingsPerMonth AS
SELECT 
      DATE_FORMAT(borrowdate, '%Y-%m') AS month, COUNT(recordid) AS total_borrowings
FROM  
    BorrowingRecords
GROUP BY 
      month
ORDER BY 
       month DESC;

select * from BorrowingsPerMonth;
-- =============================================================================
-- 10. Members With No Borrowings

CREATE VIEW MembersWithNoBorrowings AS
SELECT 
      memberid, name
FROM 
	Members
WHERE 
	totalborrowed = 0;

select * from MembersWithNoBorrowings;
-- =============================================================================
-- 11. Best Borrowed Categories

CREATE VIEW TopBorrowedCategories AS
SELECT 
    c.categoryid,
    c.categoryname,
    COUNT(br.recordid) AS total_borrowings
FROM 
    Categories c
JOIN 
     Books b ON c.categoryid = b.categoryid
JOIN 
     BorrowingRecords br ON b.bookid = br.bookid
GROUP BY 
      c.categoryid, c.categoryname
ORDER BY 
      total_borrowings DESC;

select * from TopBorrowedCategories;
-- ============================== TRANSACTIONS (TCL)  ===================================

-- Transaction for Returning a Book and Updating DueAmount Manually

-- If you want to simulate returning a book, setting ReturnDate and DueAmount together — and rollback if any issue arises.

START TRANSACTION;

-- Returning RecordID 25

-- Update return date
UPDATE BorrowingRecords
SET ReturnDate = CURDATE()
WHERE RecordID = 25;

-- Update DueAmount based on difference
UPDATE BorrowingRecords
SET DueAmount = 
    CASE
        WHEN DATEDIFF(ReturnDate, BorrowDate) > 30 THEN 'book price'
        WHEN DATEDIFF(ReturnDate, BorrowDate) BETWEEN 20 AND 30 THEN '400'
        WHEN DATEDIFF(ReturnDate, BorrowDate) > 14 THEN '100'
        ELSE '0'
    END
WHERE RecordID = 25;

-- Increase stock
UPDATE Books
SET Stock = Stock + 1
WHERE BookID = (SELECT BookID FROM BorrowingRecords WHERE RecordID = 25);

COMMIT;
-- ==================================================================================

-- Transaction for borrowing multiple books--------

-- If any Member wants to borrow multiple books at the same time then use this procedure ---

DELIMITER $$

CREATE PROCEDURE Borrow_mul_Books (IN memberID INT, IN bookID1 INT, IN bookID2 INT)
BEGIN
    DECLARE successCount INT DEFAULT 0;

    START TRANSACTION;

    -- Attempt to borrow book 1
    UPDATE Books SET Stock = Stock - 1 WHERE BookID = bookID1 AND Stock > 0;
    IF ROW_COUNT() > 0 THEN
        INSERT INTO BorrowingRecords (BookID, MemberID, BorrowDate)
        VALUES (bookID1, memberID, CURDATE());
        SET successCount = successCount + 1;
    END IF;

    -- Attempt to borrow book 2
    UPDATE Books SET Stock = Stock - 1 WHERE BookID = bookID2 AND Stock > 0;
    IF ROW_COUNT() > 0 THEN
        INSERT INTO BorrowingRecords (BookID, MemberID, BorrowDate)
        VALUES (bookID2, memberID, CURDATE());
        SET successCount = successCount + 1;
    END IF;

    -- If both books were successfully borrowed
    IF successCount = 2 THEN
        COMMIT;
    ELSE
        ROLLBACK;
    END IF;

END$$

DELIMITER ;

-- ===========================================================================================

-- Simple Transaction with SAVEPOINT, COMMIT, and ROLLBACK

-- Member 7 wants to borrow BookID 5 and BookID 6.
-- If Book 6 is out of stock, rollback to the point after borrowing Book 5 (don’t lose that).


START TRANSACTION;

-- Borrow Book 5
UPDATE Books SET Stock = Stock - 1 WHERE BookID = 5 AND Stock > 0;
SAVEPOINT after_book5;

-- Borrow Book 6
UPDATE Books SET Stock = Stock - 1 WHERE BookID = 6 AND Stock > 0;


ROLLBACK TO after_book5;

-- ===================================================================================
-- Multiple SAVEPOINTS in a Transaction

START TRANSACTION;

-- Add new members
INSERT INTO Members (MemberName, Contact) VALUES ('Amit', '9876543210');
SAVEPOINT after_amit;

INSERT INTO Members (MemberName, Contact) VALUES ('Nita', '8765432109');
SAVEPOINT after_nita;

-- Borrowing attempt
UPDATE Books SET Stock = Stock - 1 WHERE BookID = 7 AND Stock > 0;
SAVEPOINT after_book7;

ROLLBACK TO after_nita;

-- ======================================================================================
--  Rolling Back Entire Transaction

START TRANSACTION;

UPDATE Books SET Stock = Stock - 1 WHERE BookID = 1 AND Stock > 0;
UPDATE Books SET Stock = Stock - 1 WHERE BookID = 2 AND Stock > 0;

-- Simulate a failure or check
SELECT 1 FROM Books WHERE BookID = 2 AND Stock < 0;

-- If stock went negative (invalid), rollback entire transaction
ROLLBACK;
-- ==========================================================================================













