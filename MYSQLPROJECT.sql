/*You are going to build a project based on the Library Management System. It
keeps track of all information about books in the library, their cost, status and
total number of books available in the library.
Create a database named library and create following TABLES in the database:
1. Branch
2. Employee
3. Customer
4. IssueStatus
5. ReturnStatus
6. Books
Attributes for the tables:
1. Branch
∙Branch_no - Set as PRIMARY KEY
∙Manager_Id
∙Branch_address
∙Contact_no
2. Employee
∙Emp_Id – Set as PRIMARY KEY
∙Emp_name
∙Position
∙Salary
∙Branch_no - Set as FOREIGN KEY and it should refer branch_no in
EMPLOYEE table
3. Customer
∙Customer_Id - Set as PRIMARY KEY
∙Customer_name
∙Customer_address
∙Reg_date
4. IssueStatus
Issue_Id - Set as PRIMARY KEY
∙Issued_cust – Set as FOREIGN KEY and it refer customer_id in
CUSTOMER table
∙Issued_book_name
∙Issue_date
∙Isbn_book – Set as FOREIGN KEY and it should refer isbn in
BOOKS table
5. ReturnStatus
∙Return_Id - Set as PRIMARY KEY
∙Return_cust
∙Return_book_name
∙Return_date
∙Isbn_book2 - Set as FOREIGN KEY and it should refer isbn in
BOOKS table
6. Books
∙ISBN - Set as PRIMARY KEY
∙Book_title
∙Category
∙Rental_Price
∙Status [Give yes if book available and no if book not available] ∙
Author
∙Publisher
Write the queries for the following:
1. Retrieve the book title, category, and rental price of all available
books.
2. List the employee names and their respective salaries in descending
order of salary.
3. Retrieve the book titles and the corresponding customers who have
issued those books.


4. Display the total count of books in each category.
5. Retrieve the employee names and their positions for the employees
whose salaries are above Rs.50,000.
6. List the customer names who registered before 2022-01-01 and have
not issued any books yet.
7. Display the branch numbers and the total count of employees in each branch
8. Display the names of customers who have issued books in the month
of June 2023.
9. Retrieve book_title from book table containing history. 
10. Retrieve the branch numbers along with the count of employees
for branches having more than 5 employees...*/

CREATE DATABASE LIBRARY;
USE LIBRARY;
CREATE TABLE BRANCH(Branch_no INT PRIMARY KEY,Manager_Id INT,Branch_address VARCHAR(30),Contact_no INT);
INSERT INTO BRANCH VALUES
(1,101,'BHARANIKKAVU NEAR HOSPITAL',04326789),
(2,102,'sasthamcotta',0432690),
(3,103,'karunagapally junction',9876540),
(4,104,'chakkuvally',78654321),
(5,105,'kundara NEAR jewellery',342167);
SELECT * FROM BRANCH;

CREATE TABLE EMPLOYEE(Emp_Id INT PRIMARY KEY,Emp_name VARCHAR(30),Position VARCHAR(30),SALARY INT,BRANCH_NO INT,FOREIGN KEY(BRANCH_NO) REFERENCES BRANCH(BRANCH_NO));
desc employee;
INSERT INTO EMPLOYEE VALUES
(110,'ACHU','TEAM LEADER',28000,2),
(111,'ABHI','ADMINISTRATOR',58000,1),
(112,'AMMU','BUSSINESS ANALYST',38000,2),
(113,'ATHUL','CHIEF INFO OFFICER',48000,4),
(114,'APPU','TEAM LEADER',38000,5);
SELECT * FROM EMPLOYEE;

CREATE TABLE CUSTOMERS(CUS_Id INT PRIMARY KEY,CUS_name VARCHAR(30),CUS_ADDRESS VARCHAR(30),REG_DATE DATE );
INSERT INTO CUSTOMERS VALUES
(120,'NIKHIL','PUTHENHOUSE','2020-05-20'),
(121,'MALU','PUTHENTERUVU','2021-05-20'),
(122,'SANKAR','KOCHVEETIL','2022-11-13'),
(123,'NIKHILA','PUTHENHOUSE','2024-01-05'),
(124,'KALLU','PUTHENHOUSE','2019-03-30');
SELECT * FROM CUSTOMERS;

CREATE TABLE BOOKZZ(ISBN INT PRIMARY KEY,Book_title VARCHAR(30),Category VARCHAR(30),Rental_Price INT,Status VARCHAR(5),Author VARCHAR(30),Publisher VARCHAR(30));
 INSERT INTO BOOKZZ VALUES 
 (0987,'WINGS OF FIRE','AUTOBIOGRAPHY',2500,'YES','ABDUL KALAM','Universities Press'),
 (1408,'A passage to India','ESSAY',2000,'YES','E.M.Forster','EUROPA EDITION'),
 (1038,'ORIKAL','NOVEL',550,'NO','N MOHANAN','DC BOOKS'),
 (1502,'HARRY POTTER','SERIES',2500,'YES','J K ROWLING','Bloomsbury'),
  (2506,'THE BOOK OF NAMES','NOVEL',700,'YES','JILL','PARIS EDITION');
 SELECT * FROM BOOKZZ;

CREATE TABLE ISSUESTATUS(Issue_Id INT PRIMARY KEY,ISSUED_CUST INT,FOREIGN KEY(ISSUED_CUST) REFERENCES CUSTOMERS(CUS_ID),Issued_book_name VARCHAR(30),Issue_date DATE,
ISBN_BOOK INT,fOREIGN KEY(ISBN_BOOK) REFERENCES BOOKZZ(ISBN));

INSERT INTO  ISSUESTATUS VALUES
(1000,120,'WINGS OF FIRE','2023-06-25',0987),
(1001,122,'ORIKAL','2022-03-25',1038), 
(1002,124,'THE BOOK OF NAMES','2023-11-14',2506),
(1003,121,'HARRY POTTER','2019-06-28',1502),
(1004,124,'A passage to India','2022-12-12',1408);
SELECT * FROM ISSUESTATUS;

CREATE TABLE ReturnStatus(Return_Id INT PRIMARY KEY,Return_cust VARCHAR(30),Return_book_name VARCHAR(30),Return_date DATE,Isbn_book2 INT,fOREIGN KEY(ISBN_BOOK2) REFERENCES BOOKZZ(ISBN));
INSERT INTO ReturnStatus VALUES
(10001,'MALU','HARRY POTTER','2019-12-28',1502),
(10002,'sankar','ORIKAL','2023-1-28',1038),
(10003,'KALLU','A passage to India','2023-03-15',1408),
(10004,'NIKHIL','WINGS OF FIRE','2023-12-13',0987),
(10005,'KALLU','THE BOOK OF NAMES','2024-02-18',2506);
SELECT * FROM ReturnStatus;

#1. Retrieve the book title, category, and rental price of all available books.
     SELECT Book_title,Category,Rental_Price FROM BOOKZZ;
  
#2. List the employee names and their respective salaries in descending order of salary.
     SELECT Emp_name,SALARY FROM EMPLOYEE ;

#3. Retrieve the book titles and the corresponding customers who have issued those books.
     SELECT ISSUED_BOOK_NAME,ISSUED_CUST FROM ISSUESTATUS;

#4. Display the total count of books in each category.
      SELECT COUNT(*) FROM BOOKZZ ;
      
#5.Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000.
       SELECT EMP_NAME,POSITION FROM EMPLOYEE WHERE SALARY>50000;
       
#6.List the customer names who registered before 2022-01-01 and have not issued any books yet.
      SELECT CUSTOMERS.CUS_NAME FROM CUSTOMERS LEFT JOIN ISSUESTATUS ON CUSTOMERS.CUS_ID=ISSUESTATUS.ISSUED_CUST WHERE
      CUSTOMERS.REG_DATE<'2022-01-01' AND ISSUESTATUS.ISSUED_BOOK_NAME IS NULL;

#7.Display the branch numbers and the total count of employees in each branch
     SELECT Branch_no,COUNT(*) FROM BRANCH GROUP BY BRANCH_NO;

#8.Display the names of customers who have issued books in the month of June 2023.
    SELECT issued_cust,ISSUED_BOOK_NAME FROM ISSUESTATUS WHERE ISSUE_DATE='2023-06-25'; 

#9.Retrieve book_title from book table containing history. 
     SELECT book_title from bookzz where category ='history';
#10.Retrieve the branch numbers along with the count of employees for branches having more than 5 employees...*/
	SELECT Branch_no,COUNT(*) FROM BRANCH GROUP BY BRANCH_NO HAVING COUNT(*)>5;


