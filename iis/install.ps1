Install-Module -Name 'Carbon' -Force
Import-Module 'Carbon'

# Enable Web Server Feature
Start-Process -FilePath "C:\Windows\System32\Dism.exe" -ArgumentList "/online /enable-feature /FeatureName:IIS-WebServerRole" -NoNewWindow -Wait

# Create local user account
$secpasswd = ConvertTo-SecureString “Passw0rd!” -AsPlainText -Force
$mycreds = New-Object System.Management.Automation.PSCredential (“localiisuser”, $secpasswd)
Install-User -Credential $mycreds -UserCannotChangePassword -PasswordExpires false
Add-GroupMember -Name 'IIS_IUSRS' -Member 'localiisuser'

