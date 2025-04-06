<#
.SYNOPSIS
This script automates the creation of a new Active Directory user account and assigns group 
memberships by copying them from an existing user.

.DESCRIPTION
Provision a new AD user by supplying basic user details and referencing an existing AD user 
whose group memberships will be cloned. This is useful for onboarding new employees with 
similar permissions to existing ones.

.PARAMETER firstName
The new user's first name.

.PARAMETER lastName
The new user's last name.

.PARAMETER username
The new user's desired username (sAMAccountName and userPrincipalName).

.PARAMETER jobTitle
The new user's job title.

.PARAMETER mobile
The new user's mobile phone number.

.PARAMETER existingUser
An existing AD user from whom to clone group memberships.

.PARAMETER initialPassword
The initial password for the new user.

.EXAMPLE
To create a new user named Alex Smith based on an existing user "jsmith":
- First name: Alex
- Last name: Smith
- Username: alexs
- Job title: Systems Engineer
- Mobile: 050-1234567
- Existing user: jsmith
- Initial password: P@ssword123

.NOTES
Run this script with sufficient privileges to manage AD users and group memberships.
#>

# === Parameters for the new user (replace with actual values before running) ===
$firstName = "Alex"
$lastName = "Smith"
$username = "alexs"
$jobTitle = "Systems Engineer"
$mobile = "050-1234567"
$existingUser = "jsmith"
$initialPassword = "P@ssword123"

# === Retrieve group memberships from existing user ===
$groups = Get-ADUser -Identity $existingUser -Properties MemberOf | Select-Object -ExpandProperty MemberOf

# === Create new Active Directory user ===
New-ADUser `
    -Name "$firstName $lastName" `
    -DisplayName "$firstName $lastName" `
    -GivenName $firstName `
    -Surname $lastName `
    -SamAccountName $username `
    -UserPrincipalName "$username@yourdomain.com" `
    -Title "$jobTitle" `
    -MobilePhone $mobile `
    -AccountPassword (ConvertTo-SecureString $initialPassword -AsPlainText -Force) `
    -ChangePasswordAtLogon $false `
    -PasswordNeverExpires $true `
    -ScriptPath "logon.bat" `
    -HomeDirectory "\\fileserver\Users\$username" `
    -HomeDrive "U:" `
    -Enabled $true

# === Add new user to the same groups as the existing user ===
foreach ($group in $groups) {
    Add-ADGroupMember -Identity $group -Members $username
}

Write-Host "User '$username' created and added to groups successfully."
