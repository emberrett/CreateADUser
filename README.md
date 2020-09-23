# CreateADUser
This PowerShell script creates a user in AD after prompting for the following user input:
<br>-First name of the user
<br>-Last name of the user
<br>-Password for the user (as secure string)

The following variables will need to be modified for the specifications of whoever is running it:
<br>-$FullUsername
<br>-$SamAccountName
<br>-$HomeDrive
<br>-$HomeDirectory

The script runner will also need to modify what groups they would like the user to be added to.

After the variables are modified and the inputs are given, the script will:
<br>-Create a user with the first letter of the provided first name and their full last name concatenated (John Smith > jsmith)
<br>-Create a home directory (user drive), mapped to a directory under their name on the specified file server (if it doesn't already exist)
<br>-Grant the user full permission to their home directory
<br>-Set the DisplayName, GivenName, Surname, UserPrincipalName, SamAccountName, and EmailAddress attributes in AD to values based on the name provided
<br>-Enable the user account
<br>-Set a password based on the secure string provided
<br>-Add user to the specified groups in AD

*Actual company name/domain replaced by Contoso, Microsoft's placeholder company.
