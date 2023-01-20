--SQL Queries: AdventureWorks Part-I 100 exercises

Use AdventureWorks2014

--1. From the following table write a query in SQL to retrieve all rows and columns from the employee table in the Adventureworks database. Sort the result set in ascending order on jobtitle.

select * from HumanResources.Employee 
order by JobTitle asc

--2. From the following table write a query in SQL to retrieve all rows and columns from the employee table using table aliasing in the Adventureworks database. Sort the output in ascending order on lastname

select * from Person.Person as person
order by LastName

--3. From the following table write a query in SQL to return all rows and a subset of the columns (FirstName, LastName, businessentityid) from the person table in the AdventureWorks database. The third column heading is renamed to Employee_id. Arranged the output in ascending order by lastname

select FirstName, LastName, businessentityid as EmployeeID from Person.Person as p
order by p.LastName


--4. From the following table write a query in SQL to return only the rows for product that have a sellstartdate that is not NULL and a productline of 'T'. Return productid, productnumber, and name. Arranged the output in ascending order on name