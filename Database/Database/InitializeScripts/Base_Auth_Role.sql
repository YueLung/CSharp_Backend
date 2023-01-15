MERGE INTO [Base_Auth_Role] AS TARGET
	USING ( VALUES
		('Admin', 'Admin', 1, 1) ,
		('Test', 'Test', 1, 2)
	) AS SOURCE ([Code], [Name], [Active], [Seq])
	ON (TARGET.[Code] = SOURCE.[Code]) WHEN NOT MATCHED THEN 
INSERT ([Code], [Name], [Active], [Seq]) 
VALUES (SOURCE.[Code], SOURCE.[Name], SOURCE.[Active], SOURCE.[Seq]);