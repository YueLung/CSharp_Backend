MERGE INTO [Base_Setting_CodeType] AS TARGET
	USING (
	VALUES('f428833f-de33-4841-954d-e867bff3b30f', 'Test', N'測試用')
	) AS SOURCE ([Id], [Code], [Name])
	ON (TARGET.[Id] = SOURCE.[Id]) WHEN NOT MATCHED THEN 
INSERT ([Id], [Code], [Name]) 
VALUES (SOURCE.[Id], SOURCE.[Code], SOURCE.[Name]);