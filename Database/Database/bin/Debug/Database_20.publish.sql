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
/*
必須加入資料表 [dbo].[Base_Auth_User] 的資料行 [dbo].[Base_Auth_User].[Account]，但該資料行沒有預設值而且不允許 NULL 值。如果資料表包含資料，則 ALTER 指令碼將無法運作。若要避免這個問題，您必須: 在資料行加入預設值、將它標示為允許 NULL 值，或啟用產生智慧型預設值做為部署選項。

資料表 [dbo].[Base_Auth_User] 中資料行 Name 的類型目前為  NVARCHAR (500) NOT NULL，但即將變更為  NVARCHAR (200) NOT NULL。資料可能會遺失，而且若資料行包含與類型  NVARCHAR (200) NOT NULL 不相容的資料，則部署可能會失敗。
*/

IF EXISTS (select top 1 1 from [dbo].[Base_Auth_User])
    RAISERROR (N'偵測到資料列。結構描述更新即將終止，因為可能造成資料遺失。', 16, 127) WITH NOWAIT

GO
PRINT N'正在置放 預設條件約束 [dbo].[Base_Auth_User] 上的未命名條件約束...';


GO
ALTER TABLE [dbo].[Base_Auth_User] DROP CONSTRAINT [DF__tmp_ms_xx_Ba__Id__07C12930];


GO
PRINT N'開始重建資料表 [dbo].[Base_Auth_User]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Base_Auth_User] (
    [Id]             UNIQUEIDENTIFIER   DEFAULT NEWSEQUENTIALID() NOT NULL,
    [Name]           NVARCHAR (200)     NOT NULL,
    [Account]        NVARCHAR (200)     NOT NULL,
    [DepCode]        NVARCHAR (50)      NOT NULL,
    [EmpId]          NVARCHAR (50)      NOT NULL,
    [PasswordHash]   NVARCHAR (200)     NOT NULL,
    [LastSignInDate] DATETIMEOFFSET (7) NULL,
    [CreatedBy]      UNIQUEIDENTIFIER   NULL,
    [CreatedDate]    DATETIMEOFFSET (7) NULL,
    [ModifiedBy]     UNIQUEIDENTIFIER   NULL,
    [ModifiedDate]   DATETIMEOFFSET (7) NULL,
    [Cix]            INT                IDENTITY (1, 1) NOT NULL,
    CONSTRAINT [tmp_ms_xx_constraint_PK_Base_Auth_User1] PRIMARY KEY NONCLUSTERED ([Id] ASC)
);

CREATE CLUSTERED INDEX [tmp_ms_xx_index_Cix_Base_Auth_User1]
    ON [dbo].[tmp_ms_xx_Base_Auth_User]([Cix] ASC);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Base_Auth_User])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Base_Auth_User] ON;
        INSERT INTO [dbo].[tmp_ms_xx_Base_Auth_User] ([Cix], [Id], [Name], [DepCode], [EmpId], [PasswordHash], [LastSignInDate], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate])
        SELECT   [Cix],
                 [Id],
                 [Name],
                 [DepCode],
                 [EmpId],
                 [PasswordHash],
                 [LastSignInDate],
                 [CreatedBy],
                 [CreatedDate],
                 [ModifiedBy],
                 [ModifiedDate]
        FROM     [dbo].[Base_Auth_User]
        ORDER BY [Cix] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Base_Auth_User] OFF;
    END

DROP TABLE [dbo].[Base_Auth_User];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Base_Auth_User]', N'Base_Auth_User';

EXECUTE sp_rename N'[dbo].[Base_Auth_User].[tmp_ms_xx_index_Cix_Base_Auth_User1]', N'Cix_Base_Auth_User', N'INDEX';

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_Base_Auth_User1]', N'PK_Base_Auth_User', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'正在重新整理 程序 [dbo].[usp_Test]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[usp_Test]';


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
GO

GO
PRINT N'更新完成。';


GO
