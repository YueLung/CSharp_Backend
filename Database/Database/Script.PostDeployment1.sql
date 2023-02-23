/*
部署後指令碼樣板							
--------------------------------------------------------------------------------------
 此檔案包含要附加到組建指令碼的 SQL 陳述式		
 使用 SQLCMD 語法可將檔案包含在部署後指令碼中			
 範例:      :r .\myfile.sql								
 使用 SQLCMD 語法可參考部署後指令碼中的變數		
 範例:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
:r .\InitializeScripts\Base_Auth_User.sql
:r .\InitializeScripts\Base_Auth_Role.sql
:r .\InitializeScripts\Base_Auth_RoleUser.sql
:r .\InitializeScripts\Base_Setting_Code.sql
:r .\InitializeScripts\Base_Setting_CodeType.sql