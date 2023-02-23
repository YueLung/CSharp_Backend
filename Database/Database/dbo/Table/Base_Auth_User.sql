﻿CREATE TABLE [dbo].[Base_Auth_User]
(
	[Id] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWSEQUENTIALID(), 
	[Name] NVARCHAR(200) NOT NULL,
	[Account] NVARCHAR(200) NOT NULL,
	[DepCode] NVARCHAR(50) NOT NULL,
	[EmpId] NVARCHAR(50) NOT NULL,
	[PasswordHash] NVARCHAR(200) NOT NULL,
	[LastSignInDate] DATETIMEOFFSET NULL,
	[CreatedBy] UNIQUEIDENTIFIER NULL,
	[CreatedDate] DATETIMEOFFSET NULL DEFAULT GETDATE(),
	[ModifiedBy] UNIQUEIDENTIFIER NULL,
	[ModifiedDate] DATETIMEOFFSET NULL,
    [Cix] INT IDENTITY(1,1)  NOT NULL, 
	CONSTRAINT [PK_Base_Auth_User] PRIMARY KEY NONCLUSTERED (Id ASC)
)
GO

CREATE CLUSTERED INDEX [Cix_Base_Auth_User] ON [Base_Auth_User] ([Cix] ASC )