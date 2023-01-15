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
正在卸除資料行 [dbo].[Base_Auth_Role].[Description]，因此可能導致資料遺失。

必須加入資料表 [dbo].[Base_Auth_Role] 的資料行 [dbo].[Base_Auth_Role].[Active]，但該資料行沒有預設值而且不允許 NULL 值。如果資料表包含資料，則 ALTER 指令碼將無法運作。若要避免這個問題，您必須: 在資料行加入預設值、將它標示為允許 NULL 值，或啟用產生智慧型預設值做為部署選項。

必須加入資料表 [dbo].[Base_Auth_Role] 的資料行 [dbo].[Base_Auth_Role].[Name]，但該資料行沒有預設值而且不允許 NULL 值。如果資料表包含資料，則 ALTER 指令碼將無法運作。若要避免這個問題，您必須: 在資料行加入預設值、將它標示為允許 NULL 值，或啟用產生智慧型預設值做為部署選項。
*/

IF EXISTS (select top 1 1 from [dbo].[Base_Auth_Role])
    RAISERROR (N'偵測到資料列。結構描述更新即將終止，因為可能造成資料遺失。', 16, 127) WITH NOWAIT

GO
PRINT N'正在置放 索引 [dbo].[Base_Auth_User].[Cix_Base_Auth_User]...';


GO
DROP INDEX [Cix_Base_Auth_User]
    ON [dbo].[Base_Auth_User];


GO
PRINT N'正在置放 預設條件約束 [dbo].[Base_Auth_User] 上的未命名條件約束...';


GO
ALTER TABLE [dbo].[Base_Auth_User] DROP CONSTRAINT [DF__Base_Auth_Us__Id__5BE2A6F2];


GO
PRINT N'開始重建資料表 [dbo].[Base_Auth_MenuItem]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Base_Auth_MenuItem] (
    [RoleCode]     NVARCHAR (50) NOT NULL,
    [MenuItemCode] NVARCHAR (50) NOT NULL,
    CONSTRAINT [tmp_ms_xx_constraint_PK_Base_Auth_MenuItem1] PRIMARY KEY CLUSTERED ([RoleCode] ASC, [MenuItemCode] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Base_Auth_MenuItem])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_Base_Auth_MenuItem] ([RoleCode], [MenuItemCode])
        SELECT   [RoleCode],
                 [MenuItemCode]
        FROM     [dbo].[Base_Auth_MenuItem]
        ORDER BY [RoleCode] ASC, [MenuItemCode] ASC;
    END

DROP TABLE [dbo].[Base_Auth_MenuItem];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Base_Auth_MenuItem]', N'Base_Auth_MenuItem';

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_Base_Auth_MenuItem1]', N'PK_Base_Auth_MenuItem', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'開始重建資料表 [dbo].[Base_Auth_Role]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Base_Auth_Role] (
    [Code]   NVARCHAR (50)  NOT NULL,
    [Name]   NVARCHAR (200) NOT NULL,
    [Active] BIT            NOT NULL,
    [Seq]    SMALLINT       NOT NULL,
    [Cix]    INT            IDENTITY (1, 1) NOT NULL,
    CONSTRAINT [tmp_ms_xx_constraint_PK_Base_Auth_Role1] PRIMARY KEY NONCLUSTERED ([Code] ASC)
);

CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_Base_Auth_Role1]
    ON [dbo].[tmp_ms_xx_Base_Auth_Role]([Cix] ASC);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Base_Auth_Role])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_Base_Auth_Role] ([Code], [Seq])
        SELECT [Code],
               [Seq]
        FROM   [dbo].[Base_Auth_Role];
    END

DROP TABLE [dbo].[Base_Auth_Role];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Base_Auth_Role]', N'Base_Auth_Role';

EXECUTE sp_rename N'[dbo].[Base_Auth_Role].[tmp_ms_xx_index_CIX_Base_Auth_Role1]', N'CIX_Base_Auth_Role', N'INDEX';

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_Base_Auth_Role1]', N'PK_Base_Auth_Role', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'正在改變 資料表 [dbo].[Base_Setting_MenuGroup]...';


GO
ALTER TABLE [dbo].[Base_Setting_MenuGroup]
    ADD [Cix] INT IDENTITY (1, 1) NOT NULL;


GO
PRINT N'正在建立 索引 [dbo].[Base_Setting_MenuGroup].[CIX_Base_Setting_MenuGroup]...';


GO
CREATE CLUSTERED INDEX [CIX_Base_Setting_MenuGroup]
    ON [dbo].[Base_Setting_MenuGroup]([Cix] ASC);


GO
PRINT N'正在改變 資料表 [dbo].[Base_Setting_MenuItem]...';


GO
ALTER TABLE [dbo].[Base_Setting_MenuItem]
    ADD [Enable] BIT DEFAULT 0 NOT NULL,
        [Cix]    INT IDENTITY (1, 1) NOT NULL;


GO
PRINT N'正在建立 索引 [dbo].[Base_Setting_MenuItem].[CIX_Base_Setting_MenuItem]...';


GO
CREATE CLUSTERED INDEX [CIX_Base_Setting_MenuItem]
    ON [dbo].[Base_Setting_MenuItem]([Cix] ASC);


GO
PRINT N'開始重建資料表 [dbo].[Base_Auth_User]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Base_Auth_User] (
    [Id]             UNIQUEIDENTIFIER   DEFAULT NEWSEQUENTIALID() NOT NULL,
    [Name]           NVARCHAR (500)     NOT NULL,
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
PRINT N'正在建立 主索引鍵 [dbo].[PK_Base_Auth_RoleUser]...';


GO
ALTER TABLE [dbo].[Base_Auth_RoleUser]
    ADD CONSTRAINT [PK_Base_Auth_RoleUser] PRIMARY KEY CLUSTERED ([RoleCode] ASC, [UserId] ASC);


GO
PRINT N'正在建立 程序 [dbo].[usp_Test]...';


GO
/*=====================================
Auth:
Create Date:
Description:

=======================================*/

CREATE PROCEDURE [dbo].[usp_Test]
	@param1 nvarchar(200),
	@param2 int
AS
Begin
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	Declare @ErrorMsg nvarchar(max);

	if @param1 is null
	Begin
		Raiserror('error', 16, 1);
	End

	Begin Tran
	Begin Try
		Update Base_Auth_Use set Name = @param1 Where Id = '00000000-0000-0000-0000-000000000000';
		Commit Tran
	End Try
	Begin Catch
		RollBack Tran
		Set @ErrorMsg = ERROR_MESSAGE()
		Raiserror(@ErrorMsg, 16, 1)
	End Catch

	SET NOCOUNT OFF;
	SET XACT_ABORT OFF;
End
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
