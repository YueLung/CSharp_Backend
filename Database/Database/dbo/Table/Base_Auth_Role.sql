CREATE TABLE [dbo].[Base_Auth_Role]
(
	[Code] NVARCHAR(50) NOT NULL ,
    [Name] NVARCHAR(200) NOT NULL,
    [Active] BIT NOT NULL, 
    [Seq] SMALLINT NOT NULL,
    [Cix] INT IDENTITY(1,1) NOT NULL
	CONSTRAINT [PK_Base_Auth_Role] PRIMARY KEY NONCLUSTERED ([Code])
)

GO

CREATE CLUSTERED INDEX [CIX_Base_Auth_Role] ON [dbo].[Base_Auth_Role] ([Cix])
