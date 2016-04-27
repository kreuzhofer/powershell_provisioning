# Download Powershell Extensions
Invoke-RestMethod -Uri "http://dkreuzh.blob.core.windows.net/deployment/PackageManagement_x64.msi" -OutFile "PackageManagement_x64.msi"
Start-Process -FilePath "C:\Windows\System32\msiexec.exe" -ArgumentList "/i PackageManagement_x64.msi /quiet" -NoNewWindow -Wait

# Enable Web Server Feature
Start-Process -FilePath "C:\Windows\System32\Dism.exe" -ArgumentList "/online /enable-feature /FeatureName:IIS-WebServerRole" -NoNewWindow -Wait

# Install Carbon
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
Install-Module -Name 'Carbon' -Force
Import-Module 'Carbon'

# Create local user account
$secpasswd = ConvertTo-SecureString “Passw0rd!” -AsPlainText -Force
$mycreds = New-Object System.Management.Automation.PSCredential (“localiisuser”, $secpasswd)
Install-User -Credential $mycreds -UserCannotChangePassword
Add-GroupMember -Name 'IIS_IUSRS' -Member 'localiisuser'

