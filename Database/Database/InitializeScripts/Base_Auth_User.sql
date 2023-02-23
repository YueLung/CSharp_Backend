MERGE INTO [Base_Auth_User] AS TARGET
	USING ( VALUES
		('00000000-0000-0000-0000-000000000000', 'Admin', 'Admin', '000', '000000', [dbo].[Fn_Password_Hash]('000000', '1234')),
		('9a13771b-fc7d-48e5-9f7e-730bd1f59bf6', 'User1', 'User1', '001', '000001', [dbo].[Fn_Password_Hash]('000000', '1234')),
		('f03f366f-0576-4b4b-8b6e-629d0dc82602', 'User2', 'User2', '001', '000002', [dbo].[Fn_Password_Hash]('000000', '1234')),
		('0fe36036-1245-45b7-a405-2ffb823b7c5b', 'User3', 'User3', '002', '000003', [dbo].[Fn_Password_Hash]('000000', '1234')),
		('5fbc7880-53ad-4293-9b35-f9069d5bb7fc', 'User4', 'User4', '002', '000004', [dbo].[Fn_Password_Hash]('000000', '1234'))
	) AS SOURCE ([Id], [Name], [Account], [DepCode], [EmpId], [PasswordHash])
	ON (TARGET.[Id] = SOURCE.[Id]) WHEN NOT MATCHED THEN 
INSERT ([Id], [Name], [Account], [DepCode], [EmpId], [PasswordHash]) 
VALUES (SOURCE.[Id], SOURCE.[Name], SOURCE.[Account], SOURCE.[DepCode], SOURCE.[EmpId], SOURCE.[PasswordHash]);