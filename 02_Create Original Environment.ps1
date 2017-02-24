# Create Orginal Environment

Import-Module 'C:\Program Files\Microsoft Dynamics NAV\100\Service\NavAdminTool.ps1'
$dbBackup = 'C:\software\NAV 2017 W1 CU 3\SQLDemoDatabase\CommonAppData\Microsoft\Microsoft Dynamics NAV\100\Database\Demo Database NAV (10-0).bak'

New-NAVDatabase `
    -DatabaseName EG_Orig `
    -FilePath $dbBackup `
    -DatabaseServer ([net.dns]::GetHostName()) `
    -DestinationPath C:\_WorkingFolder\EG_ORIG

New-NAVServerInstance `
    -ManagementServicesPort 8145 `
    -ClientServicesPort 8146 `
    -SOAPServicesPort 8147 `
    -ODataServicesPort 8148 `
    -DatabaseName 'EG_Orig'  `
    -ServerInstance 'EG_Orig' 

Set-NAVServerInstance `
    -ServerInstance 'EG_Orig' `
    -Start

Import-NAVServerLicense `
    -LicenseFile C:\powershell\STX_2017.flf `
    -ServerInstance 'EG_Orig'




