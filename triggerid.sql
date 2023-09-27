--92 DDL Trigger SQLS
CREATE TRIGGER [Trigger_Name]
ON [Scope(Server|Database)]
FOR [EventType1, EventType2, EventType3,..],
AS
BEGIN
--Trigger Body
END

CREATE TRIGGER trMyFirstTrigger
ON Database
FOR CREATE_TABLE
AS
BEGIN
Print 'New table created'
END

CREATE TABLE Test (Id int)

ALTER TRIGGER trMyFirstTrigger
ON Database
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
AS
BEGIN
Print 'A table has just been created, modified or deleted'
END
DROP TABLE Test

DROP_TABLE
AS
BEGIN
Rollback
Print 'You cannot create, alter or drop a table'
END

DISABLE TRIGGER trMyFirstTrigger ON Database

DROP TRIGGER trMyFirstTrigger ON Database

CREATE TRIGGER trRenameTable
ON DATABASE
FOR RENAME
AS
BEGIN
Print 'You just renamed something'
END

exec sp_rename 'TestTable', 'NewTestTable'

exec sp_rename 'NewTestTable.Id' , 'NewId', 'column'

--93 Server-Scoped DDL triggerid
CREATE TRIGGER tr_DatabaseScopeTrigger
ON DATABASE
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
AS
BEGIN
ROLLBACK
Print 'You cannot create, alter or drop a table in the current database'
END

CREATE TRIGGER tr_ServerScopeTrigger
ON ALL SERVER
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
AS
BEGIN
ROLLBACK
Print 'You cannot create, alter or drop a table in the current database'
END

DISABLE TRIGGER tr_ServerScopeTrigger ON ALL SERVER

ENABLE TRIGGER tr_ServerScopeTrigger ON ALL SERVER

DROP TRIGGER tr_ServerScopeTrigger ON ALL SERVER

--94 SQL serveri trigeri täitmise järjekord
CREATE TRIGGER tr_DatabaseScopeTrigger
ON DATABASE
FOR CREATE_TABLE
AS
BEGIN
Print 'Database Scope Trigger'
END
GO

CREATE TRIGGER tr_ServerScopeTrigger
ON ALL SERVER
FOR CREATE_TABLE
AS
BEGIN
Print 'Server Scope Trigger'
END
GO
 
EXEC sp_settriggerorder
@triggername = 'tr_DatabaseScopeTrigger',
@order = 'none',
@stmttype = 'CREATE_TABLE',
@namespace = 'DATABASE'
GO

--96 Logon trigger SQL serveris
CREATE TRIGGER tr_LogonAuditTriggers
ON ALL SERVER
FOR LOGON
AS
BEGIN
DECLARE @LoginName nvarchar(100)

SET @LoginName = ORIGINAL_LOGIN()

IF (SELECT COUNT(*) FROM sys.dm_exec_sessions
WHERE is_user_process=1
AND original_login_name = @LoginName) > 3
BEGIN 
Print 'Fourth connection of' + @LoginName + 'blocked'
ROLLBACK
END
END

Execute sp_readerrorlog
