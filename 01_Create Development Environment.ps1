# Create Orginal Environment

Import-Module 'C:\Program Files\Microsoft Dynamics NAV\100\Service\NavAdminTool.ps1'
$dbBackup = 'C:\software\NAV 2017 W1 CU 3\SQLDemoDatabase\CommonAppData\Microsoft\Microsoft Dynamics NAV\100\Database\Demo Database NAV (10-0).bak'

New-NAVDatabase `
    -DatabaseName EG_DEV `
    -FilePath $dbBackup `
    -DatabaseServer ([net.dns]::GetHostName()) `
    -DestinationPath C:\_Workingfolder\EG_DEV

New-NAVServerInstance `
    -ManagementServicesPort 8245 `
    -ClientServicesPort 8246 `
    -SOAPServicesPort 8247 `
    -ODataServicesPort 8248 `
    -DatabaseName 'EG_DEV'  `
    -ServerInstance 'EG_DEV' 

Set-NAVServerInstance `
    -ServerInstance 'EG_DEV' `
    -Start

Import-NAVServerLicense `
    -LicenseFile C:\powershell\STX_2017.flf `
    -ServerInstance 'EG_DEV'

