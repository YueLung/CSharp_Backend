CREATE TABLE [dbo].[Base_Auth_RoleUser]
(
	[RoleCode] NVARCHAR(50) NOT NULL,
	[UserId] UNIQUEIDENTIFIER NOT NULL, 
    CONSTRAINT [PK_Base_Auth_RoleUser] PRIMARY KEY ([RoleCode], [UserId])
)
