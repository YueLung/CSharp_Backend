CREATE FUNCTION [dbo].[Fn_Password_Hash]
(
	@id NVARCHAR(50),
	@password NVARCHAR(200)
)
RETURNS NVARCHAR(200)
BEGIN

 RETURN Convert(NVARCHAR(200),HASHBYTES ('SHA2_256',@id + @password + 'HelloSalt'),1)
END

