# Create Orginal Environment

Import-Module 'C:\Program Files\Microsoft Dynamics NAV\100\Service\NavAdminTool.ps1'
$dbBackup = 'C:\software\NAV 2017 W1 CU 3\SQLDemoDatabase\CommonAppData\Microsoft\Microsoft Dynamics NAV\100\Database\Demo Database NAV (10-0).bak'

New-NAVDatabase `
    -DatabaseName EG_TEST `
    -FilePath $dbBackup `
    -DatabaseServer ([net.dns]::GetHostName()) `
    -DestinationPath C:\_Workingfolder\EasyGreens_TEST

New-NAVServerInstance `
    -ManagementServicesPort 8345 `
    -ClientServicesPort 8346 `
    -SOAPServicesPort 8347 `
    -ODataServicesPort 8348 `
    -DatabaseName 'EG_TEST'  `
    -ServerInstance 'EG_TEST' 

Set-NAVServerInstance `
    -ServerInstance 'EG_TEST' `
    -Start

Import-NAVServerLicense `
    -LicenseFile C:\powershell\STX_2017.flf `
    -ServerInstance 'EG_TEST'



