/*=====================================
Auth:
Create Date:
Description:

=======================================*/

CREATE PROCEDURE [dbo].[usp_Test]
	@param1 nvarchar(200),
	@param2 int
AS
Begin
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	Declare @ErrorMsg nvarchar(max);

	if @param1 is null
	Begin
		Raiserror('error', 16, 1);
	End

	Begin Tran
	Begin Try
		Update [Base_Auth_User] set [Name] = @param1 Where [Id] = '00000000-0000-0000-0000-000000000000';
		Commit Tran
	End Try
	Begin Catch
		RollBack Tran
		Set @ErrorMsg = ERROR_MESSAGE()
		Raiserror(@ErrorMsg, 16, 1)
	End Catch

	SET NOCOUNT OFF;
	SET XACT_ABORT OFF;
End
