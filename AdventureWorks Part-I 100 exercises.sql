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

Select productid, productnumber, name From production.Product  
where sellstartdate is not null and productLine='T' 
order by name 

--5. From the following table write a query in SQL to return all rows from the salesorderheader table in Adventureworks database and calculate the percentage of tax on the subtotal have decided. Return salesorderid, customerid, orderdate, subtotal, percentage of tax column. Arranged the result set in ascending order on subtotal

select salesorderid, customerid, orderdate, sum(SubTotal) as subtotal ,  sum(TaxAmt)/sum(SubTotal)*100 as percentage_of_tax  from Sales.SalesOrderHeader
group by salesorderid, customerid, orderdate 
order by  sum(SubTotal) desc


--6. From the following table write a query in SQL to create a list of unique jobtitles in the employee table in Adventureworks database. Return jobtitle column and arranged the resultset in ascending order.
--HumanResources.Employee

select DISTINCT JobTitle from  HumanResources.Employee
order by JobTitle


--7. From the following table write a query in SQL to calculate the total freight paid by each customer. Return customerid and total freight. Sort the output in ascending order on customerid.  Go to the editor
--Sample table: sales.salesorderheader

select CustomerID,sum(Freight) as total_freight from sales.salesorderheader
group by CustomerID
order by CustomerID

--8. From the following table write a query in SQL to find the average and the sum of the subtotal for every customer. Return customerid, average and sum of the subtotal. Grouped the result on customerid and salespersonid. Sort the result on customerid column in descending order.  Go to the editor
--Sample table: sales.salesorderheader

select soh.CustomerID,soh.SalesPersonID,avg(SubTotal) as Avg_subtotal,sum(SubTotal) as sum_total from sales.salesorderheader as soh
group by soh.CustomerID,soh.SalesPersonID
order by soh.CustomerID desc

--9. From the following table write a query in SQL to retrieve total quantity of each productid which are in shelf of 'A' or 'C' or 'H'. Filter the results for sum quantity is more than 500. Return productid and sum of the quantity. Sort the results according to the productid in ascending order.  Go to the editor
--Sample table: production.productinventory

select ProductID,sum(Quantity) as 'total_quantity' from production.productinventory
where Shelf in ('A','C','H') 
group by ProductID
having sum(Quantity)>500
order by ProductID


--10. From the following table write a query in SQL to find the total quentity for a group of locationid multiplied by 10.  Go to the editor
--Sample table: production.productinventory

select sum(Quantity) as total_quantity from production.productinventory
group by LocationID *10



--11. From the following tables write a query in SQL to find the persons whose last name starts with letter 'L'. Return BusinessEntityID, FirstName, LastName, and PhoneNumber. Sort the result on lastname and firstname.  Go to the editor
--Sample table: Person.PersonPhone
--Sample table: Person.Person

select pp.BusinessEntityID, p.FirstName, p.LastName, pp.PhoneNumber from Person.PersonPhone as pp
join Person.Person as p on pp.BusinessEntityID=p.BusinessEntityID
where LastName like 'L%'
order by p.LastName, p.FirstName

select top(2) * from Person.PersonPhone 
select top(2) * from Person.Person

--12. From the following table write a query in SQL to find the sum of subtotal column. Group the sum on distinct salespersonid and customerid. Rolls up the results into subtotal and running total. Return salespersonid, customerid and sum of subtotal column i.e. sum_subtotal.  Go to the editor
--Sample table: sales.salesorderheader


select salespersonid, customerid, sum(SubTotal) as sum_subtotal from sales.salesorderheader
where salespersonid is not null
group by salespersonid, customerid 
order by salespersonid 


--13. From the following table write a query in SQL to find the sum of the quantity of all combination of group of distinct locationid and shelf column. Return locationid, shelf and sum of quantity as TotalQuantity.  Go to the editor
---Sample table: production.productinventory
--Incomplete

select LocationID,Shelf, sum(Quantity) as totalquantitiy from production.productinventory
group by  LocationID,Shelf


--14. From the following table write a query in SQL to find the sum of the quantity with subtotal for each locationid. Group the results for all combination of distinct locationid and shelf column. Rolls up the results into subtotal and running total. Return locationid, shelf and sum of quantity as TotalQuantity
--Sample table: production.productinventory
--Incomplete

select LocationID,Shelf, sum(Quantity) as totalquantitiy from production.productinventory
group by ROLLUP( LocationID)


--15. From the following table write a query in SQL to find the total quantity for each locationid and calculate the grand-total for all locations. Return locationid and total quantity. Group the results on locationid.  Go to the editor
--Sample table: production.productinventory

SELECT 
   LocationID, SUM(quantity)
FROM
    production.productinventory
GROUP BY ROLLUP (LocationID)
Order by SUM(quantity) desc


--16. From the following table write a query in SQL to retrieve the number of employees for each City. Return city and number of employees. Sort the result in ascending order on city.  Go to the editor

--Sample table: Person.BusinessEntityAddress

select City, count(bea.addressid) as noofemployees from Person.Address as a
left join Person.BusinessEntityAddress as bea on a.AddressID=bea.AddressID
group by City 
order by City


--17. From the following table write a query in SQL to retrieve the total sales for each year. Return the year part of order date and total due amount. Sort the result in ascending order on year part of order date.  Go to the editor
--Sample table: Sales.SalesOrderHeader

select year(OrderDate) as year,sum(TotalDue) as OrderAmount from sales.SalesOrderHeader
GROUP by year(OrderDate)
order by year

--18. From the following table write a query in SQL to retrieve the total sales for each year. Filter the result set for those orders where order year is on or before 2016. Return the year part of orderdate and total due amount. Sort the result in ascending order on year part of order date.  Go to the editor
--Sample table: Sales.SalesOrderHeader


select year(OrderDate) as year,sum(TotalDue) as totadueorder from sales.SalesOrderHeader
GROUP by year(OrderDate)
order by year 


--19. From the following table write a query in SQL to find the contacts who are designated as a manager in various departments. Returns ContactTypeID, name. Sort the result set in descending order.  Go to the editor
--Sample table: Person.ContactType

select *  from Person.ContactType 
where name like '%Manager%'


--20. From the following tables write a query in SQL to make a list of contacts who are designated as 'Purchasing Manager'. Return BusinessEntityID, LastName, and FirstName columns. Sort the result set in ascending order of LastName, and FirstName.  Go to the editor
--Sample table: Person.BusinessEntityContact
--Incomplete

select bei.BusinessEntityID, p.LastName, p.FirstName  from  Person.ContactType as CT
join Person.BusinessEntityContact as bei on bei.ContactTypeID = CT.ContactTypeID
join Person.Person as p on bei.BusinessEntityID=p.BusinessEntityID
where CT.Name='Purchasing Manager'
order by p.LastName,p.FirstName

--21. From the following tables write a query in SQL to retrieve the salesperson for each PostalCode who belongs to a territory and SalesYTD is not zero. Return row numbers of each group of PostalCode, last name, salesytd, postalcode column. Sort the salesytd of each postalcode group in descending order. Shorts the postalcode in ascending order.  Go to the editor
--Sales.SalesPerson   Person.Person   Person.Address 

select  row_number() OVER( partition by PostalCode   order by  sum(SalesYTD) desc  ) as srno,lastname,sum(SalesYTD) as salesytd,PostalCode as SalesYTD from Person.Person  as p
join Person.Address as a on p.BusinessEntityID= a.AddressID
join Sales.SalesPerson as sp on sp.BusinessEntityID= p.BusinessEntityID
group by lastname,PostalCode
having sum(SalesYTD)>0
order by PostalCode



-- learning Over and Partition by clause
CREATE TABLE EMP
(EMPNO NUMERIC(4) NOT NULL,
ENAME VARCHAR(10),
JOB VARCHAR(9),
MGR NUMERIC(4),
HIREDATE DATETIME,
SAL NUMERIC(7, 2),
COMM NUMERIC(7, 2),
DEPTNO NUMERIC(2))

INSERT INTO EMP VALUES
(7369, 'SMITH', 'CLERK', 7902, '17-DEC-1980', 800, NULL, 20)
INSERT INTO EMP VALUES
(7499, 'ALLEN', 'SALESMAN', 7698, '20-FEB-1981', 1600, 300, 30)
INSERT INTO EMP VALUES
(7521, 'WARD', 'SALESMAN', 7698, '22-FEB-1981', 1250, 500, 30)
INSERT INTO EMP VALUES
(7566, 'JONES', 'MANAGER', 7839, '2-APR-1981', 2975, NULL, 20)
INSERT INTO EMP VALUES
(7654, 'MARTIN', 'SALESMAN', 7698, '28-SEP-1981', 1250, 1400, 30)
INSERT INTO EMP VALUES
(7698, 'BLAKE', 'MANAGER', 7839, '1-MAY-1981', 2850, NULL, 30)
INSERT INTO EMP VALUES
(7782, 'CLARK', 'MANAGER', 7839, '9-JUN-1981', 2450, NULL, 10)
INSERT INTO EMP VALUES
(7788, 'SCOTT', 'ANALYST', 7566, '09-DEC-1982', 3000, NULL, 20)
INSERT INTO EMP VALUES
(7839, 'KING', 'PRESIDENT', NULL, '17-NOV-1981', 5000, NULL, 10)
INSERT INTO EMP VALUES
(7844, 'TURNER', 'SALESMAN', 7698, '8-SEP-1981', 1500, 0, 30)
INSERT INTO EMP VALUES
(7876, 'ADAMS', 'CLERK', 7788, '12-JAN-1983', 1100, NULL, 20)
INSERT INTO EMP VALUES
(7900, 'JAMES', 'CLERK', 7698, '3-DEC-1981', 950, NULL, 30)
INSERT INTO EMP VALUES
(7902, 'FORD', 'ANALYST', 7566, '3-DEC-1981', 3000, NULL, 20)
INSERT INTO EMP VALUES
(7934, 'MILLER', 'CLERK', 7782, '23-JAN-1982', 1300, NULL, 10)


select * from EMP order by DEPTNO
select  row_number() OVER( partition by DEPTNO order by SAL desc) as srno,ENAME,JOB,DEPTNO,SAL  as dept from EMP

select  RANK() OVER(  order by SAL desc) as RANK,DENSE_Rank() OVER(  order by SAL desc) as DenseRank,ENAME,JOB,DEPTNO,SAL  as dept from EMP



--23. From the following table write a query in SQL to retrieve the RateChangeDate, full name (first name, middle name and last name) and weekly salary (40 hours in a week) of employees. In the output the RateChangeDate should appears in date format. Sort the output in ascending order on NameInFull
--HumanResources.EmployeePayHistory
--Person.Person




--24. From the following tables write a query in SQL to calculate and display the latest weekly salary of each employee. Return RateChangeDate, full name (first name, middle name and last name) and weekly salary (40 hours in a week) of employees Sort the output in ascending order on NameInFull.  Go to the editor
--Sample table: Person.Person
--Sample table: HumanResources.EmployeePayHistory
--Incomplete




--25. From the following table write a query in SQL to find the sum, average, count, minimum, and maximum order quentity for those orders whose id are 43659 and 43664. Return SalesOrderID, ProductID, OrderQty, sum, average, count, max, and min order quantity.  Go to the editor
--Sample table: Sales.SalesOrderDetail
--Incomplete
select SalesOrderID, ProductID, OrderQty, sum(OrderQty),avG(OrderQty),min(OrderQty),max(OrderQty) from Sales.SalesOrderDetail
group by SalesOrderID, ProductID, OrderQty
order by SalesOrderID

--26. From the following table write a query in SQL to find the sum, average, and number of order quantity for those orders whose ids are 43659 and 43664 and product id starting with '71'. Return SalesOrderID, OrderNumber,ProductID, OrderQty, sum, average, and number of order quantity.
--imcomplete


--27. From the following table write a query in SQL to retrieve the total cost of each salesorderID that exceeds 100000. Return SalesOrderID, total cost.--
--Sample table: Sales.SalesOrderDetail

select SalesOrderID, sum(OrderQty*UnitPrice) orderidcost from Sales.SalesOrderDetail
group by SalesOrderID
having sum(OrderQty*UnitPrice)>100000

--28. From the following table write a query in SQL to retrieve products whose names start with 'Lock Washer'. Return product ID, and name and order the result set in ascending order on product ID column.  Go to the editor
--Sample table: Production.Product

select ProductID,Name  from Production.Product
where Name like 'Lock Washer%'
order by ProductID


--29. Write a query in SQL to fetch rows from product table and order the result set on an unspecified column listprice. Return product ID, name, and color of the product.  Go to the editor
--Sample table: Production.Product

select productID, name, color from Production.Product
order by ListPrice


--30. From the following table write a query in SQL to retrieve records of employees. Order the output on year (default ascending order) of hiredate. Return BusinessEntityID, JobTitle, and HireDate.  Go to the editor
--Sample table: HumanResources.Employee

select BusinessEntityID, JobTitle, HireDate from  HumanResources.Employee
order by year(hiredate) 


--31. From the following table write a query in SQL to retrieve those persons whose last name begins with letter 'R'. Return lastname, and firstname and display the result in ascending order on firstname and descending order on lastname columns.  Go to the editor
--Sample table: Person.Person

select lastname, firstname  from Person.Person
where LastName like 'R%' 
order by LastName desc, FirstName asc 

--32. From the following table write a query in SQL to ordered the BusinessEntityID column descendingly when SalariedFlag set to 'true' and BusinessEntityID in ascending order when SalariedFlag set to 'false'. Return BusinessEntityID, SalariedFlag columns.  Go to the editor
--Sample table: HumanResources.Employee
--Incomplete

select BusinessEntityID,SalariedFlag from HumanResources.Employee
order by  case SalariedFlag when 'true' then BusinessEntityID END DESC,
case SalariedFlag when 'false' then BusinessEntityID asc


--33 From the following table write a query in SQL to set the result in order by the column TerritoryName when the column CountryRegionName is equal to 'United States' and by CountryRegionName for all other rows.  Go to the editor
--Sample table: Sales.SalesPerson

select businessentityid,lastname,territoryname,countryregionname from Sales.vSalesPerson  as sp
order by
case when TerritoryName = 'United States' then TerritoryName 
else CountryRegionName 
end 

--34. From the following table write a query in SQL to find those persons who lives in a territory and the value of salesytd except 0. Return first name, last name,row number as 'Row Number', 'Rank', 'Dense Rank' and NTILE as 'Quartile', salesytd and postalcode. Order the output on postalcode column.  Go to the editor
--Sample table: Sales.SalesPerson
--Sample table: Person.Person
--Sample table: Person.Address
--Incomplete
select FirstName,LastName,ROW_NUMBER() over( order by FirstName asc) as row_number,RANK() over( order by sum(sp.salesytd) desc ) as rank,sum(SalesYTD),PostalCode from Person.Person as p
join Person.Address as a on p.BusinessEntityID= a.AddressID
join Sales.SalesPerson as sp on sp.BusinessEntityID= p.BusinessEntityID
group by FirstName,LastName,PostalCode
order by sum(SalesYTD) desc


--35. From the following table write a query in SQL to skip the first 10 rows from the sorted result set and return all remaining rows.  Go to the editor
--Sample table: HumanResources.Department

select * from HumanResources.Department
order by DepartmentID
offset 10 rows


--36. From the following table write a query in SQL to skip the first 5 rows and return the next 5 rows from the sorted result set.  Go to the editor
--Sample table: HumanResources.Department

select * from HumanResources.Department d
order by d.departmentid
OFFSET 5 rows fetch next (5) ROWS ONLY; 



--37. From the following table write a query in SQL to list all the products that are Red or Blue in color. Return name, color and listprice.Sorts this result by the column listprice.  Go to the editor
--Sample table: Production.Product

select name, color, SUM(listprice) as ListPrice from Production.Product
where color='RED' or color='BLUE'
group by  name, color
order by SUM(listprice)



--38. Create a SQL query from the SalesOrderDetail table to retrieve the product name and any associated sales orders. Additionally, it returns any sales orders that don't have any items mentioned in the Product table as well as any products that have sales orders other than those that are listed there. Return product name, salesorderid. Sort the result set on product name column.  Go to the editor
--Sample table: Production.Product
--Sample table: Sales.SalesOrderDetail

Select p.name,sod.SalesOrderID from Sales.SalesOrderDetail sod
full OUTER join Production.Product p on  sod.ProductID=p.ProductID
order by p.name;


--39. From the following table write a SQL query to retrieve the product name and salesorderid. Both ordered and unordered products are included in the result set.  Go to the editor
--Sample table: Production.Product

select p.Name,sod.SalesOrderID from Production.Product p
full OUTER join Sales.SalesOrderDetail sod on p.ProductID=sod.ProductID 
order by p.name



--40. From the following tables write a SQL query to get all product names and sales order IDs. Order the result set on product name column.  Go to the editor
--Sample table: Production.Product
--Sample table: Sales.SalesOrderDetail
select p.Name,sod.SalesOrderID from Production.Product p
join Sales.SalesOrderDetail sod on p.ProductID=sod.ProductID 
order by p.name





--41. From the following tables write a SQL query to retrieve the territory name and BusinessEntityID. The result set includes all salespeople, regardless of whether or not they are assigned a territory.  Go to the editor
--Sample table: Sales.SalesTerritory
--Sales.SalesPerson

select st.Name,sp.BusinessEntityID from Sales.SalesPerson sp 
left join Sales.SalesTerritory st on sp.TerritoryID=st.TerritoryID



--42. Write a query in SQL to find the employee's full name (firstname and lastname) and city from the following tables. Order the result set on lastname then by firstname.  Go to the editor

--Sample table: Person.Person
--Sample table: HumanResources.Employee
--Sample table: Person.Address
--Sample table: Person.BusinessEntityAddress

select CONCAT(FirstName,' ',LastName) as name ,a.City from  Person.Person as p
join Person.BusinessEntityAddress as bea on p.BusinessEntityID=bea.BusinessEntityID
join Person.Address as a on bea.AddressID=a.AddressID


--43. Write a SQL query to return the businessentityid,firstname and lastname columns of all persons in the person table (derived table) with persontype is 'IN' and the last name is 'Adams'. Sort the result set in ascending order on firstname. A SELECT statement after the FROM clause is a derived table.  Go to the editor

--Sample table: Person.Person

with personcte as  (select * from Person.person as p where p.PersonType='IN' and LastName like 'Adams')
select BusinessEntityID,FirstName,LastName from personcte
order by FirstName


--44. Create a SQL query to retrieve individuals from the following table with a businessentityid inside 1500, a lastname starting with 'Al', and a firstname starting with 'M'.  Go to the editor
--Sample table: Person.Person

select BusinessEntityID,FirstName,LastName from Person.Person  as p
where p.businessEntityID < 1500 and LastName like 'AL%' and FirstName like 'M%'



--45. Write a SQL query to find the productid, name, and colour of the items 'Blade', 'Crown Race' and 'AWC Logo Cap' using a derived table with multiple values.  Go to the editor
--Sample table: Production.Product

with ctep as (select * from Production.Product  as p
where  p.name in ('Blade', 'Crown Race', 'AWC Logo Cap') )
select ProductID,name,Color from ctep
order by ProductID

--46. Create a SQL query to display the total number of sales orders each sales representative receives annually. Sort the result set by SalesPersonID and then by the date component of the orderdate in ascending order. Return the year component of the OrderDate, SalesPersonID, and SalesOrderID.  Go to the editor
--Sample table: Sales.SalesOrderHeader

select SalesPersonID,count(SalesOrderID) as totalsales ,YEAR(OrderDate) as salesyear from Sales.SalesOrderHeader
where SalesPersonID is not null
group by SalesPersonID,YEAR(OrderDate)
order by SalesPersonID,YEAR(OrderDate)


--47. From the following table write a query in SQL to find the average number of sales orders for all the years of the sales representatives.
--Sample table: Sales.SalesOrderHeader
--Incomplete

with cte (
    select year(OrderDate),avg(SalesOrderID) from Sales.SalesOrderHeader as soh
group by year(OrderDate) )
select avg(SalesOrderID)/count(DISTINCT SalesPersonID) from Sales.SalesOrderHeader


--48. Write a SQL query on the following table to retrieve records with the characters green_ in the LargePhotoFileName field. The following table's columns must all be returned.  Go to the editor

--Sample table: Production.ProductPhoto

select * from Production.ProductPhoto as p where p.LargePhotoFileName like '%green_%'
order by ProductPhotoID

--49. Write a SQL query to retrieve the mailing address for any company that is outside the United States (US) and in a city whose name starts with Pa. Return Addressline1, Addressline2, city, postalcode, countryregioncode columns.  Go to the editor
--Sample table: Person.Address
--Sample table: Person.StateProvince

select AddressLine1,AddressLine2,City,PostalCode,CountryRegionCode from Person.Address as a  
join Person.StateProvince as sp on  a.StateProvinceID=sp.StateProvinceID
where CountryRegionCode <> 'US' and City like 'Pa%'


--50. From the following table write a query in SQL to fetch first twenty rows. Return jobtitle, hiredate. Order the result set on hiredate column in descending order.  Go to the editor
--Sample table: HumanResources.Employee

select top(20) jobtitle, hiredate from HumanResources.Employee
order by HireDate desc

--51. From the following tables write a SQL query to retrieve the orders with orderqtys greater than 5 or unitpricediscount less than 1000, and totaldues greater than 100. Return all the columns from the tables.  Go to the editor
--Sample table: Sales.SalesOrderHeader
--Sample table: Sales.SalesOrderDetail

select * from Sales.SalesOrderHeader as soh 
join Sales.SalesOrderDetail as sod on soh.SalesOrderID=sod.SalesOrderID
where (OrderQty>5 or UnitPriceDiscount<1000) and  TotalDue>100
order by soh.SalesOrderID

--52. From the following table write a query in SQL that searches for the word 'red' in the name column. Return name, and color columns from the table.  Go to the editor
--Sample table: Production.Product

select name,Color from  Production.Product as p 
where color='Red'
order by name


--53. From the following table write a query in SQL to find all the products with a price of $80.99 that contain the word Mountain. Return name, and listprice columns from the table.  Go to the editor
--Sample table: Production.Product
--Incomplete


--54. From the following table write a query in SQL to retrieve all the products that contain either the phrase Mountain or Road. Return name, and color columns.  Go to the editor
--Sample table: Production.Product

select Name,Color from Production.Product
where name like '%Road%' or name like '%Mountain%'



--55. From the following table write a query in SQL to search for name which contains both the word 'Mountain' and the word 'Black'. Return Name and color.  Go to the editor
--Sample table: Production.Product

select Name,Color from Production.Product
where name like '%Black%' and name like '%Mountain%'


--56. From the following table write a query in SQL to return all the product names with at least one word starting with the prefix chain in the Name column.  Go to the editor
--Sample table: Production.Product

select name, Color from Production.Product
where name like 'chain%'


--57. From the following table write a query in SQL to return all category descriptions containing strings with prefixes of either chain or full.  Go to the editor
--Sample table: Production.Product



