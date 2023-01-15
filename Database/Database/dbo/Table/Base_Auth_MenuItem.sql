CREATE TABLE [dbo].[Base_Auth_MenuItem]
(
	[RoleCode] NVARCHAR(50) NOT NULL,
	[MenuItemCode] NVARCHAR(50) NOT NULL,
	CONSTRAINT [PK_Base_Auth_MenuItem] PRIMARY KEY ([RoleCode], [MenuItemCode])
)
