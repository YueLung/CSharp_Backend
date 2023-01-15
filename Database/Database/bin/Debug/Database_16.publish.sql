/*
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
PRINT N'已略過索引鍵為 d89b2be9-0461-4fbb-b6e3-92c1d16dbf9a 的重新命名重構作業，項目 [dbo].[Base_Setting_MenuGroup].[Id] (SqlSimpleColumn) 將不會重新命名為 Code';


GO
PRINT N'正在置放 主索引鍵 [dbo].[Base_Auth_RoleUser] 上的未命名條件約束...';


GO
ALTER TABLE [dbo].[Base_Auth_RoleUser] DROP CONSTRAINT [PK__Base_Aut__D62CB59D4E72B8B9];


GO
PRINT N'正在建立 資料表 [dbo].[Base_Auth_MenuItem]...';


GO
CREATE TABLE [dbo].[Base_Auth_MenuItem] (
    [MenuItemCode] NVARCHAR (50) NOT NULL,
    [RoleCode]     NVARCHAR (50) NOT NULL
);


GO
PRINT N'正在建立 資料表 [dbo].[Base_Setting_MenuGroup]...';


GO
CREATE TABLE [dbo].[Base_Setting_MenuGroup] (
    [Code]        NVARCHAR (50)  NOT NULL,
    [Description] NVARCHAR (200) NOT NULL
);


GO
PRINT N'正在建立 資料表 [dbo].[Base_Setting_MenuItem]...';


GO
CREATE TABLE [dbo].[Base_Setting_MenuItem] (
    [Code]        NVARCHAR (50)  NOT NULL,
    [GroupCode]   NVARCHAR (50)  NOT NULL,
    [Description] NVARCHAR (200) NOT NULL
);


GO
PRINT N'正在建立 資料表 [dbo].[test]...';


GO
CREATE TABLE [dbo].[test] (
    [Name] NVARCHAR (500) NOT NULL
);


GO
-- 用於更新含有部署交易記錄之目標伺服器的重構步驟
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'd89b2be9-0461-4fbb-b6e3-92c1d16dbf9a')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('d89b2be9-0461-4fbb-b6e3-92c1d16dbf9a')

GO

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
	VALUES('00000000-0000-0000-0000-000000000000', 'Admin', '000', '000000', [dbo].[Fn_Password_Hash]('000000', 'admin')) 
	) AS SOURCE ([Id], [Name], [DepCode], [EmpId], [PasswordHash])
	ON (TARGET.[Id] = SOURCE.[Id]) WHEN NOT MATCHED THEN 
INSERT ([Id], [Name], [DepCode], [EmpId], [PasswordHash]) 
VALUES (SOURCE.[Id], SOURCE.[Name], SOURCE.[DepCode], SOURCE.[EmpId], SOURCE.[PasswordHash]);
GO

GO
PRINT N'更新完成。';


GO
