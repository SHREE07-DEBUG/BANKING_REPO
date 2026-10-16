create database Bankingdb;
use Bankingdb;

create table CUSTOMERS(
CUSTOMERID INT,
FIRSTNAME VARCHAR(50),
LASTNAME VARCHAR(50),
EMAIL VARCHAR(100),
PHONE VARCHAR(15),
ACCOUNTCREATIONDATE DATE
);

DESCRIBE CUSTOMERS;

-- ------------------------
-- LAB 2
-- ------------------------

CREATE TABLE Accounts (
    AccountID INT,
    AccountType VARCHAR(20),
    Balance DECIMAL(10,2)
);

CREATE TABLE Transactions (
    TransactionID INT,
    TransactionDate DATE,
    Amount DECIMAL(10,2),
    TransactionType VARCHAR(20)
);

CREATE TABLE Branches (
    BranchID INT,
    BranchName VARCHAR(100),
    BranchAddress VARCHAR(200),
    BranchPhone VARCHAR(15)
);

CREATE TABLE AccountBranches ( 
		AssignmentDate DATE
);

CREATE TABLE Loans (
    LoanID INT,
    LoanAmount DECIMAL(10,2),
    InterestRate DECIMAL(5,2),
    StartDate DATE,
    EndDate DATE
);

-- added dateofbirth column to customers table

alter table customers add column DateOfBirth date;

alter table customers modify Phone varchar(20);

alter table accounts add constraint chk_MinbBalance Check(Balance >=1000);

show create table accounts;

-- delete table using drop

drop table AccountBranches;

-- Now Connect Accounts Table using CustomerID from Customers table.

alter table accounts
add customerID INT;

-- connect customers and accounts table using FK

alter table accounts
add constraint FK_Accounts_Customers
foreign key (CustomerID)
references Customers(CustomerID);

-- modify the first name datatype not null to the customers table
alter table customers modify Firstname varchar(50) not null;

-- Email should be unique 
alter table customers add constraint uq_Email unique (Email);

-- 1. add primary key
alter table Branches add primary key (BranchID);

-- add column in account table 
alter table Accounts add BranchID int;

-- connect branches add accounts table using FK
alter table accounts 
add constraint FK_Accounts_Branches 
foreign key (BranchID)
references Branches(BranchID);

-- 2. add primary key 
alter table Accounts add primary key (AccountID);

-- add column in transaction table
alter table transactions add AccountID int;

-- connect accounts to transaction table
alter table transactions
add constraint FK_transaction_Accounts
foreign key (AccountID)
references Accounts(AccountID);

-- 3. add primary key 
alter table customers add primary key (CustomerID);
 
 -- add column in loans table
 alter table loans add CustomerID int;
 
 -- connect customer to loans table
 alter table loans
 add constraint FK_Loans_Customers
 foreign key(CustomerID)
 references customers(CustomerID);
 

-- -------------
-- LAB 3
-- -------------

insert into customers(CustomerID,FirstName,LastName,Email,Phone,DateOfBirth)
values
(101,'Rahul','Sharma','rahul@gmail.com','9876543210','1998-04-15');

insert into Accounts(AccountID,CustomerID,AccountType,Balance)
values
(201,101,"Saving",25000);

INSERT INTO Customers
(CustomerID, FirstName, LastName, Email, Phone, DateOfBirth)
VALUES
(102, 'Priya', 'Patil', 'priya@gmail.com', '9988776655', '2000-09-20'),
(103, 'Amit', 'Patel', 'amit.patel@gmail.com', '9876500001', '1995-06-18'),
(104, 'Sneha', 'Joshi', 'sneha.joshi@gmail.com', '9876500002', '1997-09-12'),
(105, 'Rohan', 'Kulkarni', 'rohan.k@gmail.com', '9876500003', '1993-11-25');

INSERT INTO Accounts
(AccountID, CustomerID, AccountType, Balance)
VALUES
(202, 102, 'Current', 40000),
(203, 103, 'Savings', 35000),
(204, 104, 'Current', 60000),
(205, 105, 'Savings', 45000);

INSERT INTO Transactions
(TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES
(301, 201, '2025-05-10', 5000, 'Deposit'),
(302, 202, '2025-05-11', 2500, 'Withdraw'),
(303, 203, '2025-05-12', 10000, 'Deposit'),
(304, 204, '2025-05-13', 3000, 'Withdraw'),
(305, 205, '2025-05-14', 7000, 'Deposit');

INSERT INTO Branches
(BranchID, BranchName, BranchAddress, BranchPhone)
VALUES
(1, 'Mumbai Branch', 'Andheri, Mumbai', '0221111111'),
(2, 'Pune Branch', 'Shivaji Nagar, Pune', '0202222222'),
(3, 'Nashik Branch', 'College Road, Nashik', '0253222222'),
(4, 'Nagpur Branch', 'Sitabuldi, Nagpur', '0712333333'),
(5, 'Navi Mumbai Branch', 'Vashi, Navi Mumbai', '0224444444');

INSERT INTO Loans
(LoanID, LoanAmount, InterestRate, StartDate, EndDate, CustomerID)
VALUES
(301, 500000, 8.50, '2025-01-15', '2030-01-15', 101),
(302, 300000, 9.25, '2025-02-10', '2028-02-10', 102),
(303, 750000, 8.75, '2025-03-20', '2032-03-20', 103),
(304, 250000, 10.00, '2025-04-05', '2029-04-05', 104),
(305, 1000000, 7.95, '2025-05-12', '2035-05-12', 105);

-- Task 2: update Existing Bankinhg Records
update Customers set phone='9999999999' where CustomerID=101;

select * from Customers where CustomerID=101;

update Customers set Email="rahul.sharma@gmail.com" where CustomerID=101;

update Accounts set Balance='30000' where AccountID=201;

select * from Accounts where AccountID=201;

-- Task 3: Delete Banking Records and Verify Data
delete from Transactions where TransactionID=302;

select * from Transactions;

delete from Accounts where AccountID=202;

select * from Accounts;


-- ------------
-- LAB 4
-- ------------

-- Task 1: Review Customer Banking Information
select * from Customers;

select FirstName,LastName,Email,Phone from Customers;

select AccountID,AccountType,Balance from Accounts;

-- Task 2: Investigates Specific Customer Transactions
select * from Accounts where AccountType="Savings";

select * from Accounts where Balance > 25000;

select * from Transactions where Amount between 5000 and 20000;

select * from customers where customerID in (101,102,103);

select * from customers where FirstName like 'RN';

select * from Customers where FirstName Like 'R%';


-- ACTIVITY 

select * from Accounts where AccountType="Current";

select * from Accounts where Balance < 15000;

select * from Transactions where Amount between 1000 and 10000;

select * from Customers where customerID in (104,105);

select * from Customers where LastName Like 'S%';


-- Task 3: Generate Banking Reports for Management

select * from Customers order by FirstName asc;

select * from Accounts order by Balance desc;

select * from Accounts order by Balance desc;

select distinct AccountType from Accounts;

select * from Accounts order by Balance desc limit 3;

select * from Transactions limit 5 offset 2;

-- Activity 

select * from Customers order by LastName asc;

select * from Transactions order by Amount desc;

select distinct TransactionType from Transactions;

select * from Transactions limit 4 offset 3;

-- Task 4: Identify Missing Banking Information 

select * from Customers where phone is null;

select * from Customers where Email is not null;

select * from Customers where Email is not null;

-- ACTIVITY 

select * from Customers where Email is null;

select * from Accounts where Balance is not null;

-- Task 5: Categorize Customer Accounts Based on Balance 

select AccountID,Balance,
case
    when Balance >=50000 then "premium Account"
    when Balance >=25000 then "standard Account"
else "Basic Account"
end as "Accountcategory" from Accounts;

-- ACTIVITY 

select Amount,
case
	 when Amount >=8000 then "High Transaction"
     when Amount >=5000 then "Medium Transaction"
else"Low Transaction"
end as "Amountcategory" from Transactions;

-- Task 6: Analyze Customer Transactions using window Functions

select AccountID,Balance,
rank() over(order by balance desc) as Balancerank from Accounts;

select TransactionID,Amount,
sum(Amount) over(order by TransactionDate)as RunningTotal from Transactions;

select TransactionID,Amount,
avg(Amount) over()as AverageTransaction from Transactions;

-- ACTIVITY 



-- -------------
-- LAB 5
-- -------------

-- Task 1: Search Customers Based on Name
select * from Customers where FirstName like 'A%';

select * from Customers where Email like '%gmail%';

select * from Customers where LastName like '%kar';

-- ACTIVITY
select * from Customers where FirstName like 'R%';

select * from Customers where Email like '%yahoo%';

select * from Customers where LastName like '%p';

select * from Customers where phone like '%99';

-- Task 2: Filter Records for Selected Banking Categories

select * from Accounts where AccountType in ('Saving','Current');

select * from Transactions where TransactionType in ('Deposit','Withdrawal');

select * from customers where CustomerID in (101,102,105);

-- ACTIVITY 
select * from Accounts where AccountType in ('Saving','Salary');

select * from Transactions where Transactiontype in ('Deposite','Payment');

select * from Customers where CustomerID in (103,104);

select * from Accounts where AccountID in ('selected');

-- Task 3: Generate Sorted Banking Reports

select * from Customers order by LastName ASC;

select * from Accounts order by Balance DESC;

select * from Transactions order by TransactionDate DESC;

-- ACTIVITY 
select * from Customers order by LastName asc;

select * from Accounts order by AccountType DESC;

select * from Transactions order by Amount DESC;

select * from Customers order by DateOfBirth asc;

-- Task 4: Control Result Size for Faster Review

select * from Accounts order by Balance desc limit 5;

select * from Customers limit 3;

select * from Transactions limit 5 offset 3;

-- ---------
-- LAB 6
-- --------


-- Task 1: Apply String,math, and date function 

select * from Customers;

select FirstName,upper(firstName) as uppercaseName from Customers;

select firstName,lower(FirstName) as lowercaseName from Customers;

select FirstName,length(FirstName) as lengname from Customers;

select FirstName,left(FirstName,3) as Initials from Customers;

select concat(FirstName,' - ',LastName) as FullName from Customers;

select round (1256.75) as Rounded_Value;

select ceil (1256.25) as Ceiling_Value;

select floor (1256.75) as Floor_Value;

select abs(-2500) as Absolute_Value;

select mod(25,4) as Remainder;

select * from Customers;

select curdate();

select Now();

select CustomerID ,Year(DateOfBirth) as Birthyear from Customers;

select CustomerID ,Month(DateOfBirth) as BirthMonth from Customers;

select CustomerID, DATEDIFF(CURDATE(),DateOfBirth) AS Days FROM Customers;

select FirstName,DateOfBirth,if (year(DateOfBirth) <=1995,'adult','young') as category from Customers;

select FirstName,ifnull(Phone,'Not Available') as PhoneNumber from Customers;

select greatest(
'2000-09-20',
'1995-06-18',
'1997-09-12',
'1993-11-25'
) as LatestBirthDate;

select least(
'2000-09-20',
'1995-06-18',
'1997-09-12',
'1993-11-25'
) as LeastBirthDate;

select FirstName,nullif(FirstName,'Priya')as result from Customers;

-- Task 2: Analyze Overall Banki8ng Performance 

select avg(Balance) as avg_balance from Accounts;

select sum(Balance) as total_balance from Accounts;

select max(Balance) as highest_balance from Accounts;

select min(Balance) as lowest_balance from Accounts;

select count(*)as total_accounts from Accounts;

-- Task 3: Analyze Account-Wise Performance

select AccountType,sum(Balance)as Totalbalance from Accounts group by AccountType;

-- Task 4: Identify High-Performing Categories

select AccountType,sum(Balance) as Total_balance from Accounts group by AccountType having sum(Balance) > 25000;

-- ---------------
-- LAB 7
-- ---------------

select * from loans;

select loanid,customerid,loanamount,
rank() over(order by loanamount desc) as "loan_rank"
from loans; 

select loanid,customerid,loanamount,
dense_rank() over(order by loanamount desc) as "loan_denserank"
from loans;

select loanid,customerid,loanamount,
row_number() over(order by loanamount desc) as "loan_rownum"
from loans;

SELECT
    LoanID,
    CustomerID,
    LoanAmount,
    ROW_NUMBER() OVER(
        PARTITION BY CustomerID
        ORDER BY LoanAmount DESC
    ) AS RowNum
FROM Loans;

SELECT
    LoanID, CustomerID,LoanAmount,
    SUM(LoanAmount) OVER(
        ORDER BY LoanAmount DESC
    ) AS RunningTotal
FROM Loans;

SELECT
    LoanID,
    CustomerID,
    LoanAmount,
    LAG(LoanAmount) OVER(
        ORDER BY LoanAmount DESC
    ) AS PreviousLoanAmount
FROM Loans;

SELECT
    LoanID, CustomerID, LoanAmount,
    LEAD(LoanAmount) OVER(
        ORDER BY LoanAmount DESC
    ) AS NextLoanAmount
FROM Loans;

-- -----------
-- LAB 8
-- -----------

-- Task 1: Generate Accounts Transaction Reports

select 
a.accountid, a.accounttype, a.balance,
t.Transactionid,
t.Transactiondate,
t.Transactiontype,
t.amount
from accounts a
inner join Transactions t
on a.accountid = t.accountid;

-- Task 2: Display All Accounts Including Those Without Transactions

SELECT
    a.AccountID, a.AccountType, a.Balance,
    t.TransactionID,
    t.TransactionDate,
    t.TransactionType,
    t.Amount
FROM Accounts a
LEFT JOIN Transactions t
ON a.AccountID = t.AccountID;

-- Task 3: Generate Deposit Transaction Reports

SELECT
    a.AccountID, a.AccountType, a.Balance,
    t.TransactionID,
    t.TransactionDate,
    t.TransactionType,
    t.Amount
FROM Accounts a
INNER JOIN Transactions t
ON a.AccountID = t.AccountID
WHERE t.TransactionType = 'Deposit';

-- Task 4: Generate High Balance Account Transaction Reports

select
a.AccountID, a.AccountType, a.Balance,
t.TransactionID,
t.TransactionDate,
t.TransactionType,
t.Amount
from Accounts a
inner join Transactions t
on a.AccountID = t.AccountID
where a.Balance > 30000
order by a.Balance desc;

-- -----------
-- LAB 9
-- -----------

-- Task 1: Identify Transactions Above the Average Transaction Amount

select * from transactions;

select * from Transactions
where Amount >
(
select avg(Amount)
from Transactions
);

-- Task 2: Identify Accounts with Above-Average Balance

select * from Accounts
where Balance >
(select avg(Balance) from Accounts);

-- fetch all account details from account table where transaction type
-- is deposite in transactions table 

-- Task 3: Identify Deposit Accounts Using a Multi-Row Subquery

select * from Accounts
where AccountID in
(select AccountID
from Transactions
where TransactionType = 'Deposit'
);

-- Task 4: Identify the Account with the Highest Balance

SELECT
    AccountID,
    AccountType,
    Balance,
    CustomerID
FROM Accounts
WHERE Balance =
(
    SELECT MAX(Balance)
    FROM Accounts
);

-- -----------
-- LAB 10 
-- -----------

-- Task 1: Create a View for High-Balance Accounts 

create view High_Balance_Accounts as
select
AccountID,
AccountType,
Balance,
CustomerID
from Accounts
where Balance > 30000;

-- Task 2: Retrieve Data Using the View 

select * from High_Balance_Accounts;

-- Task 3: Modify the View to Include Transaction Details

create or replace view High_Balance_Accounts as
select
a.AccountID, a.AccountType, a.Balance, a.CustomerID,
t.TransactionID,
t.TransactionDate,
t.TransactionType,
t.Amount
from Accounts a
inner join Transactions t
on a.AccountID = t.AccountID
where a.Balance > 30000;

-- Task 4: Generate Banking Reports Using the View

select
AccountID,
AccountType,
Balance,
CustomerID,
TransactionID,
TransactionDate,
TransactionType,
Amount
from  High_Balance_Accounts
order by  Balance desc;