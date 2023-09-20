--32.
Create Function fn_ILTVF_GetEmployees()
Returns Table
as
Return (Select EmployeeKey,FirstName, CAST(BirthDate as Date) as DOB
from DimEmployee);

CREATE FUNCTION fn_MSTVF_GetEmployees()
Returns @Table Table(ID int, Name varchar(20), DOB Date)
as
Begin
Insert into @Table
SELECT EmployeeKey, FirstName, Cast(BirthDate as Date) 
from DimEmployee
Return

Select * from fn_ILTVF_GetEmployees()
Select * from fn_MSTVF_GetEmployees()

Update fn_ILTVF_GetEmployees() set FirstName='Rob1' Where EmployeeKey=4;
Update fn_MSTVF_GetEmployees() set Name='Rob2' Where Id=4

--33.
CREATE FUNCTION fn_GetEmployeeNameById(@id int)
Returns nvarchar(20)
as
begin
Return (Select FirstName from DimEmployee where EmployeeKey = @id)
End

Select dbo.fn_GetEmployeeNameById(2);

Alter function fn_GetEmployeeNameById(@id int)
Returns nvarchar(20)
With Encryption
as
begin
return (select FirstName from DimEmployee where EmployeeKey = @id)
End

Alter function fn_GetEmployeeNameById(@id int)
Returns nvarchar(20)
With SchemaBinding
as
begin
return (select FirstName from dbo.DimEmployee where EmployeeKey = @id)
End

--34.
Create Table #PersonDetails(Id int, Name nvarchar(20))
Insert into #PersonDetails Values (1,'Mike')
Insert into #PersonDetails Values (2,'John')
Insert into #PersonDetails Values (3,'Todd')
Select * from #PersonDetails

SELECT Name from tempdb.sys.all_objects
Where name like '#PersonDetails%'

DROP TABLE #PersonDetails

CREATE PROCEDURE spCreateLocalTempTable
AS
BEGIN
Create Table #PersonDetails(Id int primary key, Name nvarchar(20))
Insert into #PersonDetails Values (1,'Mike')
Insert into #PersonDetails Values (2,'John')
Insert into #PersonDetails Values (3,'Todd')
Select * from #PersonDetails
END

CREATE TABLE ##EmployeeDetails(Id int primary key, Name nvarchar(20))

--35.
Select * from DimEmployee  where BaseRate > 20 and BaseRate < 30

CREATE Index IX_DimEmployee_BaseRate
ON DimEmployee (BaseRate ASC)

Exec sys.sp_helpindex @Objname = 'DimEmployee'

drop index DimEmployee.DimEmployee_BaseRate
