# Active Directory User Cloner

This PowerShell script automates the creation of a new Active Directory (AD) user and assigns them to the same groups as an existing user. It’s designed to streamline the onboarding process by quickly provisioning new users with appropriate permissions and attributes.

## 🛠 Features

- Creates a new AD user with standard attributes
- Copies group memberships from an existing user
- Sets initial password and login options
- Configures home directory and login script

## 📦 Requirements

- PowerShell
- ActiveDirectory module (`Import-Module ActiveDirectory`)
- Domain admin or equivalent privileges

## 📄 Script Parameters

The script uses hardcoded parameters. You should customize the following variables:

```powershell
$firstName = "Alex"
$lastName = "Smith"
$username = "alexs"
$jobTitle = "Systems Engineer"
$mobile = "050-1234567"
$existingUser = "jsmith"
$initialPassword = "P@ssword123"
```

## 📋 Example Usage

To create a new user named **Alex Smith**, with username **alexs**, based on group memberships of user **jsmith**:

1. Open PowerShell as Administrator.
2. Modify the parameter values in the script to match the new user.
3. Run the script:

```powershell
.\Clone-ADUser.ps1
```

Once complete, the new user will:
- Be added to all the same AD groups as `jsmith`
- Have a home directory at `\fileserver\Users\alexs`
- Have a login script named `logon.bat`
- Use the initial password `P@ssword123` (you can change this)

## 🔐 Security Notes

- The password is passed as plain text in the script. For production use, consider prompting securely or encrypting it.
- Ensure you rotate or reset the password upon first login (can be automated by setting `-ChangePasswordAtLogon $true`).

## 📁 File Structure

```
Clone-ADUser.ps1         # Main PowerShell script
README.md                # This documentation
```

## ⚠ Disclaimer

This script is provided "as-is" without any warranties or guarantees of any kind, express or implied.  
Use of this script is at your own risk.

- It is your responsibility to review, test, and adapt the script to fit your organization's policies and environment.
- The script may make changes to Active Directory, which could have operational or security implications.
- The author assumes no responsibility for any damage, data loss, misconfiguration, or access issues that may result from use of this code.

**Always test in a development or staging environment before using in production.**

Script Author: [aviado1](https://github.com/aviado1)
