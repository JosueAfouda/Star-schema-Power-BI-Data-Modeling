RESTORE FILELISTONLY
FROM DISK = 'D:\Logiciels\AdventureWorksDW2017.bak';
GO

RESTORE DATABASE AdventureWorksDW2017
FROM DISK = 'D:\Logiciels\AdventureWorksDW2017.bak'
WITH
MOVE 'AdventureWorksDW2017'
TO 'C:\Program Files\Microsoft SQL Server\MSSQL17.SQLEXPRESS\MSSQL\DATA\AdventureWorksDW2017.mdf',
MOVE 'AdventureWorksDW2017_log'
TO 'C:\Program Files\Microsoft SQL Server\MSSQL17.SQLEXPRESS\MSSQL\DATA\AdventureWorksDW2017_log.ldf',
RECOVERY;
GO

SELECT name FROM sys.databases;