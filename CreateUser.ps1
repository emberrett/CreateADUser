$FirstName = Read-Host -Prompt "User's first name: "
$LastName = Read-Host -Prompt "User's last name: "
$FullName = $FirstName + " " + $LastName
#Username will take first letter of first name and full last name and set it to lower case (John Smith > jsmith)
$Username = ($FirstName.Substring(0,1) + $Lastname).ToLower()
#change "@contoso.com" to your domain
$FullUsername = $Username + "@contoso.com"
#change "contoso\" to your domain
$SamAccountName = "contoso\" + $Username
#change to whatever drive you want mapped as the user drive
$HomeDrive ='U:'
#change to your desired file server location
$HomeDirectory = "\\contoso-fileserver\" + $username

#Check if directory already exists, if not, create one
If(!(test-path $HomeDirectory))
    {
          New-Item -ItemType Directory -Force -Path $HomeDirectory
    }

#change path to desired OU
New-ADUser `
    -DisplayName $FullName `
    -GivenName $FirstName `
    -Name $FullName `
    -Surname $LastName `
    -UserPrincipalName $FullUsername `
    -HomeDrive $HomeDrive `
    -HomeDirectory $HomeDirectory `
    -SamAccountName $Username `
    -EmailAddress $FullUsername `
    -Path "OU=Active Users,OU=CONTOSO,DC=ad,DC=contoso,DC=com" `
    -AccountPassword (Read-Host -AsSecureString "Input Password")
Enable-ADAccount -Identity $Username

#Change to your desired groups
Add-ADGroupMember "Contoso Admin Users" $Username
Add-ADGroupMember "Contoso Managers"  $Username

#give user full control of assigned user drive
$Acl = Get-Acl $HomeDirectory
$Ar = New-Object System.Security.AccessControl.FileSystemAccessRule($Username, "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow")
$Acl.SetAccessRule($Ar)
Set-Acl $HomeDirectory $Acl
