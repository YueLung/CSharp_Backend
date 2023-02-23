-- 測試用
MERGE INTO [Base_Setting_Code] AS TARGET
	USING ( VALUES
		('1e83665c-9b3d-4557-8920-9b9bd0d1d69e', 'f428833f-de33-4841-954d-e867bff3b30f', 'Test1', N'測試1', N'測試1', 1),
		('a11d7459-7e91-47a0-84d2-8d88feedd0e9', 'f428833f-de33-4841-954d-e867bff3b30f', 'Test2', N'測試2', N'測試2', 5),
		('2f858e56-946e-473d-9c99-20a70e10f0b7', 'f428833f-de33-4841-954d-e867bff3b30f', 'Test3', N'測試3', N'測試3', 10)
	) AS SOURCE ([Id], [TypeId], [Code], [Name], [Description], [Seq])
	ON (TARGET.[Id] = SOURCE.[Id]) WHEN NOT MATCHED THEN 
INSERT ([Id], [TypeId], [Code], [Name], [Description], [Seq]) 
VALUES (SOURCE.[Id], SOURCE.[TypeId], SOURCE.[Code], SOURCE.[Name], SOURCE.[Description], SOURCE.[Seq]);