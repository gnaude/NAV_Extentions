
# Publish the NAVx
Publish-NAVApp `
    -Path 'D:\_Workingfolder\ItemClassification\ItemClassification.navx' `
    -ServerInstance 'ItemClassification_TEST' `
    -SkipVerification `
    -Verbose


# Install the Externsion to the default tenant
Get-NAVAppInfo -ServerInstance 'ItemClassification_TEST' -Name 'ItemClassification'

Install-NAVApp -ServerInstance 'ItemClassification_TEST' -Tenant default -Name ItemClassification


Start 'DynamicsNAV://Localhost:8346/ItemClassification_TEST/CRONUS International Ltd./'