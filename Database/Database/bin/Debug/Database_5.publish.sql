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
必須加入資料表 [dbo].[Base_Auth_User] 的資料行 [dbo].[Base_Auth_User].[CreatedBy]，但該資料行沒有預設值而且不允許 NULL 值。如果資料表包含資料，則 ALTER 指令碼將無法運作。若要避免這個問題，您必須: 在資料行加入預設值、將它標示為允許 NULL 值，或啟用產生智慧型預設值做為部署選項。

必須加入資料表 [dbo].[Base_Auth_User] 的資料行 [dbo].[Base_Auth_User].[CreatedDate]，但該資料行沒有預設值而且不允許 NULL 值。如果資料表包含資料，則 ALTER 指令碼將無法運作。若要避免這個問題，您必須: 在資料行加入預設值、將它標示為允許 NULL 值，或啟用產生智慧型預設值做為部署選項。

必須加入資料表 [dbo].[Base_Auth_User] 的資料行 [dbo].[Base_Auth_User].[DepCode]，但該資料行沒有預設值而且不允許 NULL 值。如果資料表包含資料，則 ALTER 指令碼將無法運作。若要避免這個問題，您必須: 在資料行加入預設值、將它標示為允許 NULL 值，或啟用產生智慧型預設值做為部署選項。

必須加入資料表 [dbo].[Base_Auth_User] 的資料行 [dbo].[Base_Auth_User].[EmpId]，但該資料行沒有預設值而且不允許 NULL 值。如果資料表包含資料，則 ALTER 指令碼將無法運作。若要避免這個問題，您必須: 在資料行加入預設值、將它標示為允許 NULL 值，或啟用產生智慧型預設值做為部署選項。

必須加入資料表 [dbo].[Base_Auth_User] 的資料行 [dbo].[Base_Auth_User].[ModifiedBy]，但該資料行沒有預設值而且不允許 NULL 值。如果資料表包含資料，則 ALTER 指令碼將無法運作。若要避免這個問題，您必須: 在資料行加入預設值、將它標示為允許 NULL 值，或啟用產生智慧型預設值做為部署選項。

必須加入資料表 [dbo].[Base_Auth_User] 的資料行 [dbo].[Base_Auth_User].[ModifiedDate]，但該資料行沒有預設值而且不允許 NULL 值。如果資料表包含資料，則 ALTER 指令碼將無法運作。若要避免這個問題，您必須: 在資料行加入預設值、將它標示為允許 NULL 值，或啟用產生智慧型預設值做為部署選項。

必須加入資料表 [dbo].[Base_Auth_User] 的資料行 [dbo].[Base_Auth_User].[Password_hash]，但該資料行沒有預設值而且不允許 NULL 值。如果資料表包含資料，則 ALTER 指令碼將無法運作。若要避免這個問題，您必須: 在資料行加入預設值、將它標示為允許 NULL 值，或啟用產生智慧型預設值做為部署選項。
*/

IF EXISTS (select top 1 1 from [dbo].[Base_Auth_User])
    RAISERROR (N'偵測到資料列。結構描述更新即將終止，因為可能造成資料遺失。', 16, 127) WITH NOWAIT

GO
PRINT N'已略過索引鍵為 b898d665-03ad-4539-ad6d-f5926a3e1dd9 的重新命名重構作業，項目 [dbo].[Base_Auth_Role].[Id] (SqlSimpleColumn) 將不會重新命名為 Code';


GO
PRINT N'已略過索引鍵為 99de5243-5362-4afb-80d1-dc28f02009d4 的重新命名重構作業，項目 [dbo].[Base_Auth_RoleUser].[Id] (SqlSimpleColumn) 將不會重新命名為 RoleCode';


GO
PRINT N'正在置放 預設條件約束 [dbo].[Base_Auth_User] 上的未命名條件約束...';


GO
ALTER TABLE [dbo].[Base_Auth_User] DROP CONSTRAINT [DF__Base_Auth_Us__Id__398D8EEE];


GO
PRINT N'開始重建資料表 [dbo].[Base_Auth_User]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Base_Auth_User] (
    [Id]            UNIQUEIDENTIFIER   DEFAULT NEWSEQUENTIALID() NOT NULL,
    [Name]          NVARCHAR (50)      NOT NULL,
    [DepCode]       NVARCHAR (50)      NOT NULL,
    [EmpId]         NVARCHAR (50)      NOT NULL,
    [Password_hash] NVARCHAR (200)     NOT NULL,
    [CreatedBy]     UNIQUEIDENTIFIER   NOT NULL,
    [CreatedDate]   DATETIMEOFFSET (7) NOT NULL,
    [ModifiedBy]    UNIQUEIDENTIFIER   NOT NULL,
    [ModifiedDate]  DATETIMEOFFSET (7) NOT NULL,
    [Cix]           INT                IDENTITY (1, 1) NOT NULL,
    CONSTRAINT [tmp_ms_xx_constraint_PK_Base_Auth_User1] PRIMARY KEY CLUSTERED ([Id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Base_Auth_User])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Base_Auth_User] ON;
        INSERT INTO [dbo].[tmp_ms_xx_Base_Auth_User] ([Id], [Name], [Cix])
        SELECT   [Id],
                 [Name],
                 [Cix]
        FROM     [dbo].[Base_Auth_User]
        ORDER BY [Id] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Base_Auth_User] OFF;
    END

DROP TABLE [dbo].[Base_Auth_User];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Base_Auth_User]', N'Base_Auth_User';

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_Base_Auth_User1]', N'PK_Base_Auth_User', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'正在建立 索引 [dbo].[Base_Auth_User].[Cix_Base_Auth_User]...';


GO
CREATE NONCLUSTERED INDEX [Cix_Base_Auth_User]
    ON [dbo].[Base_Auth_User]([Cix] ASC);


GO
PRINT N'正在建立 資料表 [dbo].[Base_Auth_MenuItem]...';


GO
CREATE TABLE [dbo].[Base_Auth_MenuItem] (
    [Id] INT NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'正在建立 資料表 [dbo].[Base_Auth_Role]...';


GO
CREATE TABLE [dbo].[Base_Auth_Role] (
    [Code]        NVARCHAR (50)  NOT NULL,
    [Description] NVARCHAR (200) NOT NULL,
    [Seq]         SMALLINT       NOT NULL,
    PRIMARY KEY CLUSTERED ([Code] ASC)
);


GO
PRINT N'正在建立 資料表 [dbo].[Base_Auth_RoleUser]...';


GO
CREATE TABLE [dbo].[Base_Auth_RoleUser] (
    [RoleCode] NVARCHAR (50)    NOT NULL,
    [UserId]   UNIQUEIDENTIFIER NOT NULL,
    PRIMARY KEY CLUSTERED ([RoleCode] ASC)
);


GO
PRINT N'正在建立 資料表 [dbo].[Base_Setting_MenuGroup]...';


GO
CREATE TABLE [dbo].[Base_Setting_MenuGroup] (
    [Id] INT NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'正在建立 資料表 [dbo].[Base_Setting_MenuItem]...';


GO
CREATE TABLE [dbo].[Base_Setting_MenuItem] (
    [Id] INT NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
-- 用於更新含有部署交易記錄之目標伺服器的重構步驟

IF OBJECT_ID(N'dbo.__RefactorLog') IS NULL
BEGIN
    CREATE TABLE [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)
    EXEC sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'
END
GO
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'b898d665-03ad-4539-ad6d-f5926a3e1dd9')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('b898d665-03ad-4539-ad6d-f5926a3e1dd9')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '99de5243-5362-4afb-80d1-dc28f02009d4')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('99de5243-5362-4afb-80d1-dc28f02009d4')

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
--MERGE INTO [Base_Auth_User]
--	USE
GO

GO
PRINT N'更新完成。';


GO
