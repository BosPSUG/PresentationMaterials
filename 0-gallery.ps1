# Discover and get help
Get-Module -ListAvailable
Get-Module -ListAvailable -Name PowerShellGet, PackageManagement

Get-Command -Module PackageManagement, PowerShellGet
Get-Command -Module PowerShellGet

Get-Help Install-Module -Full

# Quick OneGet/PackageManagement notes:

    # What types of things can I install/query/etc? PackageProviders:
    Get-PackageProvider

    # Hmm, missing anything?
    Find-PackageProvider
        # I Don't have Chocolatey!

    # Okay, what targets can these providers hit?:
    Get-PackageSource

    # Set things up for chocolatey
    Set-PackageSource -Name chocolatey -ProviderName chocolatey

    # Search... and install!
    Find-Package |
        Select -First 20 |
        Out-GridView -PassThru |
        Install-Package

    # What's on my system?
    Get-Package -ProviderName chocolatey

    # Cleanup
    Uninstall-Package 7zip

    # Wouldn't it be fun to see other package sources?

        # Windows updates...
        # Microsoft downloads...
        # Hotfixes...

# PowerShellGet
    # Interface to PowerShellGallery.com
    # Compatible with similar internal systems
    # Work with scripts and modules.  Focus is on modules.
    # Wraps PackageManagement
    
    # Find a module - or just use powershellgallery.com
    Find-Module -Tag Slack, Excel

    # Want to read the code first?
    Save-Module PSDiskPart -Path C:\temp
    dir C:\temp\PSDiskPart

    # Install a module
    Install-Module PoshRSJob, Posh-SSH, ImportExcel

    # Just for me, admin not needed
    Install-Module PSSlack -Scope CurrentUser

    # Have an issue? Many of these are open source:
        $Mod = Find-Module ImportExcel
        $Mod | Select -Property *
        & 'C:\Program Files\Internet Explorer\iexplore.exe' $Mod.ProjectUri

    #### Scripts! ####

    # Find a script, install it
    Find-Script | Select -First 5
    Install-Script Open-IseFunction
    
    # Look at scripts we have installed.
    Get-InstalledScript
    Get-InstalledScript | Select *

    # Run every script we have installed
    # In this case, the script contains a function...
    Get-InstalledScript | ForEach-Object {
        $Name = $_.Name
        $Path = $_.InstalledLocation
        $ScriptPath = Join-Path $Path "$Name.ps1"
        . $ScriptPath
    }

    # Save a script, open it
    Save-Script -Name Show-Tree -Path C:\Temp
    ise C:\temp\Show-Tree.ps1

#### Questions! ####