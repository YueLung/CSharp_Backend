CREATE TABLE [dbo].[Base_Setting_MenuGroup]
(
	[Code] NVARCHAR(50) NOT NULL,
	[Description] NVARCHAR(200) NOT NULL,
	[Cix] INT IDENTITY(1,1) NOT NULL
)

GO

CREATE CLUSTERED INDEX [CIX_Base_Setting_MenuGroup] ON [dbo].[Base_Setting_MenuGroup] ([Cix])