﻿/*
XXX_Test 的部署指令碼

這段程式碼由工具產生。
變更這個檔案可能導致不正確的行為，而且如果重新產生程式碼，
變更將會遺失。
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "XXX_Test"
:setvar DefaultFilePrefix "XXX_Test"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\"

GO
:on error exit
GO
/*
偵測 SQLCMD 模式，如果不支援 SQLCMD 模式，則停用指令碼執行。
若要在啟用 SQLCMD 模式後重新啟用指令碼，請執行以下:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'必須啟用 SQLCMD 模式才能成功執行此指令碼。';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
/*
部署後指令碼樣板							
--------------------------------------------------------------------------------------
 此檔案包含要附加到組建指令碼的 SQL 陳述式		
 使用 SQLCMD 語法可將檔案包含在部署後指令碼中			
 範例:      :r .\myfile.sql								
 使用 SQLCMD 語法可參考部署後指令碼中的變數		
 範例:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
MERGE INTO [Base_Auth_User] AS TARGET
	USING (
	VALUES('00000000-0000-0000-0000-000000000000', 'Admin', 'Admin', '000', '000000', [dbo].[Fn_Password_Hash]('000000', '1234')) 
	) AS SOURCE ([Id], [Name], [Account], [DepCode], [EmpId], [PasswordHash])
	ON (TARGET.[Id] = SOURCE.[Id]) WHEN NOT MATCHED THEN 
INSERT ([Id], [Name], [Account], [DepCode], [EmpId], [PasswordHash]) 
VALUES (SOURCE.[Id], SOURCE.[Name], SOURCE.[Account], SOURCE.[DepCode], SOURCE.[EmpId], SOURCE.[PasswordHash]);
MERGE INTO [Base_Auth_Role] AS TARGET
	USING ( VALUES
		('Admin', 'Admin', 1, 1) ,
		('Test', 'Test', 1, 2)
	) AS SOURCE ([Code], [Name], [Active], [Seq])
	ON (TARGET.[Code] = SOURCE.[Code]) WHEN NOT MATCHED THEN 
INSERT ([Code], [Name], [Active], [Seq]) 
VALUES (SOURCE.[Code], SOURCE.[Name], SOURCE.[Active], SOURCE.[Seq]);
MERGE INTO [Base_Auth_RoleUser] AS TARGET
	USING ( VALUES
		('Admin', '00000000-0000-0000-0000-000000000000') ,
		('Test', '00000000-0000-0000-0000-000000000000')
	) AS SOURCE ([RoleCode], [UserId])
	ON (TARGET.[RoleCode] = SOURCE.[RoleCode] And TARGET.[UserId] = SOURCE.[UserId]) WHEN NOT MATCHED THEN 
INSERT ([RoleCode], [RoleCode]) 
VALUES (SOURCE.[RoleCode], SOURCE.[RoleCode]);
GO

GO
PRINT N'更新完成。';


GO
