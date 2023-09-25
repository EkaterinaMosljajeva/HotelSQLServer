--36
CREATE TABLE [tblEmployee](
[Id] int Primary key,
[Name] nvarchar(50),
[Salary] int,
[Gender] nvarchar(10),
[City] nvarchar(50))

INSERT INTO tblEmployee VALUES (3,'John',4500,'Male','New York')
INSERT INTO tblEmployee VALUES (1,'Sam',4500,'Male','London')
INSERT INTO tblEmployee VALUES (4,'Sara',4500,'Female','Tokyo')
INSERT INTO tblEmployee VALUES (5,'Todd',4500,'Male','Toronto')
INSERT INTO tblEmployee VALUES (2,'Pam',4500,'Female','Sydney')

CREATE CLUSTERED INDEX IX_tblEmployee_FirstName ON tblEmployee(Name)

CREATE CLUSTERED INDEX IX_tblEmployee_Gender_Salary ON tblEmployee(Gender DESC, Salary ASC)

CREATE NONCLUSTERED INDEX IX_tblEmployee_Name ON tblEmployee(Name)

--37
EXECUTE sp_helpindex tblEmployee

INSERT INTO tblEmployee VALUES (1,'Mike',4500,'Male','New York')
INSERT INTO tblEmployee VALUES (1,'John',2500,'Male','London')

Create Unique NonClustered Index UIX_tblEmployee_FirstName_LastName
On tblEmployee(FirstName, LastName)

ALTER TABLE tblEmployee 
ADD CONSTRAINT UQ_tblEmployee_City 
UNIQUE NONCLUSTERED (City)

EXECUTE SP_HELPCONSTRAINT tblEmployee

CREATE UNIQUE INDEX IX_tblEmployee_City
ON tblEmployee(City)
WITH IGNORE_DUP_KEY

--38
CREATE NONCLUSTERED INDEX IX_tblEmployee_Salary
ON tblEmployee (Salary ASC)

SELECT * FROM tblEmployee WHERE Salary > 4000 and Salary < 8000


DELETE FROM tblEmployee WHERE Salary=2500
Update tblEmployee SET Salary=9000 WHERE Salary=6000

SELECT * FROM tblEmployee ORDER BY Salary

SELECT * FROM tblEmployee ORDER BY Salary DESC

SELECT Salary, COUNT(Salary) as Total
from tblEmployee group by Salary
