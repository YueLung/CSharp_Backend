MERGE INTO [Base_Auth_User] AS TARGET
	USING (
	VALUES('00000000-0000-0000-0000-000000000000', 'Admin', 'Admin', '000', '000000', [dbo].[Fn_Password_Hash]('000000', '1234')) 
	) AS SOURCE ([Id], [Name], [Account], [DepCode], [EmpId], [PasswordHash])
	ON (TARGET.[Id] = SOURCE.[Id]) WHEN NOT MATCHED THEN 
INSERT ([Id], [Name], [Account], [DepCode], [EmpId], [PasswordHash]) 
VALUES (SOURCE.[Id], SOURCE.[Name], SOURCE.[Account], SOURCE.[DepCode], SOURCE.[EmpId], SOURCE.[PasswordHash]);