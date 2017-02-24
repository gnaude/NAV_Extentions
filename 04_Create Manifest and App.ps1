
# Load Modules
Import-Module 'C:\Program Files\Microsoft Dynamics NAV\100\Service\NavAdminTool.ps1'
Import-Module 'C:\Program Files (x86)\Microsoft Dynamics NAV\100\RoleTailored Client\Microsoft.Dynamics.Nav.Apps.Tools.psd1'
Import-Module 'C:\Program Files (x86)\Microsoft Dynamics NAV\100\RoleTailored Client\Microsoft.Dynamics.Nav.Model.Tools.psd1'

#Create Working Folder
if (!(Test-Path 'C:\_Workingfolder\EG\')){New-Item -ItemType directory 'c:\_Workingfolder\EG\'}

#Export Original Objects - Once (This is the base)
Export-NAVApplicationObject `
    -DatabaseName EG_ORIG `
    -Path c:\_Workingfolder\EG\Original.txt `
    -DatabaseServer ([net.dns]::GetHostName()) `
    -ExportTxtSkipUnlicensed `
    -Verbose

#Export Modified Objects - Once (This is the development objects set)
Export-NAVApplicationObject `
    -DatabaseName EG_DEV `
    -Path c:\_Workingfolder\EG\Modified.txt `
    -DatabaseServer ([net.dns]::GetHostName()) `
    -ExportTxtSkipUnlicensed `
    -Force `
    -Verbose


# Create Deltas
if (!(Test-Path 'C:\_Workingfolder\EG\Deltas')){New-Item -ItemType directory 'C:\_Workingfolder\EG\Deltas'}

Compare-NAVApplicationObject `
    -DeltaPath c:\_Workingfolder\EG\Deltas `
    -ModifiedPath c:\_Workingfolder\EG\Modified.txt `
    -OriginalPath c:\_Workingfolder\EG\Original.txt `
    -Force `
    -Verbose


# Create Manifest
if (!(Test-Path 'C:\_Workingfolder\EG\Manifest.xml')){
    $Manifest = New-NAVAppManifest `
                    -Name 'Strategix' `
                    -Publisher 'Gideon Naude' `
                    -Description 'Easy Greens - Harvest' `
                    -Version '1.0.0.0'

    $Manifest | New-NAVAppManifestFile -Path 'C:\_Workingfolder\EG\Manifest.xml' -Force
    }

# Create Package
New-NAVAppPackage `
    -Path C:\_Workingfolder\EG\Easy_Greens_Harvest.navx -Manifest (Get-NAVAppManifest -Path C:\_Workingfolder\EG\Manifest.xml) -SourcePath C:\_Workingfolder\EG\Deltas -Force
    

Start 'C:\_Workingfolder\EG'

