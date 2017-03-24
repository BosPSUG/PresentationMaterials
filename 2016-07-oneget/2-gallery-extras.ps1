#### Prerequisites not performed here ###
    # $key = Get-Content C:\key.txt -raw

# Bump the version
explorer $ENV:USERPROFILE\Documents\GitHub\PSSlack

# Publish a module
Publish-Module -Path $ENV:USERPROFILE\Documents\GitHub\PSSlack -NuGetApiKey $Key

# Auto deploy!
# http://ramblingcookiemonster.github.io/PSDeploy-Inception/
# Includes dev builds, idea/code borrowed from Microsoft DSC Resources:
Register-PSRepository -Name PSSlackDev -SourceLocation https://ci.appveyor.com/nuget/psslack -InstallationPolicy Trusted
Find-Module -Repository PSSlackDev
& 'C:\Program Files\Internet Explorer\iexplore.exe' 'https://ci.appveyor.com/project/RamblingCookieMonster/psslack/build/artifacts'

# Publish a script
ise C:\temp\Open-IseFunction.ps1
Publish-Script -Path C:\temp\Open-IseFunction.ps1 -NuGetApiKey $Key
