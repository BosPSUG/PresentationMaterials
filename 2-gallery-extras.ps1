#### Prerequisites not performed here ###
    # $key = 'My powershellgallery.com key'

# Bump the version
explorer $ENV:USERPROFILE\Documents\GitHub\PSSlack

# Publish a module
Publish-Module -Path $ENV:USERPROFILE\Documents\GitHub\PSSlack -NuGetApiKey $Key


# Publish a script
ise C:\temp\Open-IseFunction.ps1
Publish-Script -Path C:\temp\Open-IseFunction.ps1 -NuGetApiKey $Key

