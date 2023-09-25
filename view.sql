--39
CREATE TABLE tblEmployee(
Id int Primary key,
Name nvarchar(50),
Salary int,
Gender nvarchar(10),
DepartamentId int)

CREATE TABLE tblDepartament(
DeptId int Primary key,
DeptName nvarchar(20))

Select Id, Name, Salary, Gender, DeptName
From tblEmployee
join tblDepartament
on tblEmployee.DepartamentId = tblDepartament.DeptId

Create View vWEmployeesByDepartment
AS
Select Id,Name,Salary,Gender,DeptName
From tblEmployee
join tblDepartament
on tblEmployee.DepartamentId = tblDepartament.DeptId

SELECT * from vWEmployeesByDepartment

Create View vWITDepartment_Employees
AS
Select Id,Name,Salary,Gender,DeptName
From tblEmployee
join tblDepartament
on tblEmployee.DepartamentId = tblDepartament.DeptId
Where tblDepartament.DeptName = 'IT'

CREATE VIEW vWEmployeesNonConfidentialData
AS
Select Id,Name,Gender,DeptName
From tblEmployee
join tblDepartament
on tblEmployee.DepartamentId = tblDepartament.DeptId

CREATE VIEW vWEmployeesCountByDepartment
AS
Select DeptName, Count(Id) as TotalEmployees
From tblEmployee
join tblDepartament
on tblEmployee.DepartamentId = tblDepartament.DeptId
Group by DeptName

--40
CREATE VIEW vWEmployeesDataExceptSalary
AS
Select Id, Name, Gender, DepartamentId
From tblEmployee

Update vWEmployeesDataExceptSalary
Set Name = 'Mikey' Where Id = 2

Delete from vWEmployeesDataExceptSalary WHERE Id=2
Insert into vWEmployeesDataExceptSalary Values(2,'Mikey','Male',2)

Create view vwEmployeeDetailsByDepartment
as
Select Id, Name, Salary, Gender, DeptName
From tblEmployee
join tblDepartament
on tblEmployee.DepartamentId = tblDepartament.DeptId

Update vwEmployeeDetailsByDepartment
SET DeptName='IT' where Name='John'

--41
CREATE TABLE tblProduct(
ProductId int primary key,
Name nvarchar(20),
UnitPrice int)

INSERT INTO tblProduct VALUES (1,'Books',20)
INSERT INTO tblProduct VALUES (2,'Pens',14)
INSERT INTO tblProduct VALUES (3,'Pencils',11)
INSERT INTO tblProduct VALUES (4,'Clips',10)

CREATE TABLE tblProductSales(
ProductId int,
QuantitySold int)

INSERT INTO tblProductSales VALUES(1,10)
INSERT INTO tblProductSales VALUES(3,23)
INSERT INTO tblProductSales VALUES(4,21)
INSERT INTO tblProductSales VALUES(2,12)
INSERT INTO tblProductSales VALUES(1,13)
INSERT INTO tblProductSales VALUES(3,12)
INSERT INTO tblProductSales VALUES(4,13)
INSERT INTO tblProductSales VALUES(1,11)
INSERT INTO tblProductSales VALUES(2,12)
INSERT INTO tblProductSales VALUES(1,14)

CREATE View vWTotalSalesByProduct
with SchemaBinding
AS
Select Name,
SUM(ISNULL((QuantitySold*UnitPrice),0)) AS TotalSales,
COUNT_BIG(*) as TotalTransactions
from dbo.tblProductSales
join dbo.tblProduct
on dbo.tblProduct.ProductId=dbo.tblProductSales.ProductId
group by name

CREATE Unique clustered index UIX_vWTotalSalecByProduct_Name
On vWTotalSalesByProduct(Name)

--42
CREATE TABLE tblEmployee
(
  Id int Primary Key,
  Name nvarchar(30),
  Salary int,
  Gender nvarchar(10),
  DepartmentId int
)

Insert into tblEmployee values (1,'John', 5000, 'Male', 3)
Insert into tblEmployee values (2,'Mike', 3400, 'Male', 2)
Insert into tblEmployee values (3,'Pam', 6000, 'Female', 1)
Insert into tblEmployee values (4,'Todd', 4800, 'Male', 4)
Insert into tblEmployee values (5,'Sara', 3200, 'Female', 1)
Insert into tblEmployee values (6,'Ben', 4800, 'Male', 3)

Create View vWEmployeeDetails
@Gender nvarchar(20)
as
Select Id, Name, Gender, DepartmentId
from  tblEmployee
where Gender = @Gender

Create function fnEmployeeDetails(@Gender nvarchar(20))
Returns Table
as
Return 
(Select Id, Name, Gender, DepartmentId
from tblEmployee where Gender = @Gender)

Select * from dbo.fnEmployeeDetails('Male')

Create View vWEmployeeDetailsSorted
as
Select Id, Name, Gender, DepartmentId
from tblEmployee
order by Id

Create Table ##TestTempTable(Id int, Name nvarchar(20), Gender nvarchar(10))

Insert into ##TestTempTable values(101, 'Martin', 'Male')
Insert into ##TestTempTable values(102, 'Joe', 'Female')
Insert into ##TestTempTable values(103, 'Pam', 'Female')
Insert into ##TestTempTable values(104, 'James', 'Male')

Create View vwOnTempTable
as
Select Id, Name, Gender
from ##TestTempTable
