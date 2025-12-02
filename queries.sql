create database CustomerAnalysis;
use CustomerAnalysis;

create table customers(
    customerid int primary key,
    name varchar(100),
    age int,
    gender varchar(10),
    region varchar(50),
    joindate date,
    lastpurchasedate date,
    totalorders int,
    avgordervalue decimal(10,2),
    totalspend decimal(15,2)
);

-- load file
load data local infile 'C:\ProgramData\MySQL\MySQL Server 9.0\Uploads\Customer.Analysis.sample.csv'
into table customers
fields terminated by ',' 
enclosed by '"'
lines terminated by '\n'
ignore 1 rows

select count(*) as totalrecords from customers;

-- check sample data
select * from customers limit 10;


-- check the revenue generate
select region, sum(totalspend) as totalrevenue
from customers
group by region;

-- gender-wise revenue
select gender, sum(totalspend) as totalrevenue
from customers
group by gender;

-- Calculate average age of customers
select avg(Age) from Customers;

--  Calculate total revenue by region
select  Region, sum(TotalSpend) as TotalRevenue
from Customers
group by Region
order by TotalRevenue desc;

-- Find top 10 customers by total spend
select Name, TotalSpend
from Customers
order by TotalSpend desc
limit 10;

--  Average revenue per customer
select avg(TotalSpend) as AvgRevenue from Customers;

-- age groups banane ke liye
select
    case 
        when age < 25 then 'young'
        when age between 25 and 40 then 'adult'
        else 'senior'
    end as agegroup,
    count(*) as totalcustomers
from customers
group by agegroup;

--  latest purchase date check karna
select max(lastpurchasedate) as recentpurchase 
from customers;

-- oldest join date check karna
select min(joindate) as oldestjoin 
from customers;

--  month-wise new customers count
select month(joindate) as monthnumber, count(*) as newcustomers
from customers
group by month(joindate)
order by monthnumber;
