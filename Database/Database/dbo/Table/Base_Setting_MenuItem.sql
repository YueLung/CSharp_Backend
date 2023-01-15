CREATE TABLE [dbo].[Base_Setting_MenuItem]
(
	[Code] NVARCHAR(50) NOT NULL,
	[GroupCode] NVARCHAR(50) NOT NULL,
	[Description] NVARCHAR(200) NOT NULL,
	[Enable] BIT NOT NULL DEFAULT 0,
	[Cix] INT IDENTITY(1,1) NOT NULL 
)

GO

CREATE CLUSTERED INDEX [CIX_Base_Setting_MenuItem] ON [dbo].[Base_Setting_MenuItem] ([Cix])