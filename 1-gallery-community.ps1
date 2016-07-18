#### Prerequisites not performed here ###
    # Posh-SSH example:
        # Set-Content C:\redacted.txt "phrases|to|redact"
        # Set-Content C:\Computers.txt "A list of computers"
    # PSSlack example:
        # Set-PSSlackConfig -Token <my slack token>


#### PoshRSJob - Do things fast!
####
    
# PS Jobs:   Expensive, slow
# Workflows: Quirks, using InlineScript limits performance
# Remoting:  Distributed, parallel, but not always available... someday...
# Runspaces: Fast, seem complicated until you try PoshRSJob

Install-Module PoshRSJob -Force
Import-Module PoshRSJob

# Similar to *-Job, but faster and uses fewer resources
Get-Command -Module PoshRSJob

# Simulate querying 100 good computers, 5 bad
$ResponseTimes = @()
$ResponseTimes += foreach($response in 1..100)
{
    Get-Random -Minimum 1 -Maximum 1000 # less than 1000 milliseconds
}
$Responsetimes += foreach($response in 1..5)
{
    Get-Random -Minimum 10000 -Maximum 20000 # 10 - 20 seconds
}
$ResponseTimes = $ResponseTimes | Sort-Object {Get-Random}

# How fast?
Measure-Command {
    $Output = $ResponseTimes | Start-RSJob -Name {"$_-test"} `
                -Throttle 100 `
                -ScriptBlock {
        
        Start-Sleep -Milliseconds $_

        [pscustomobject]@{
            ComputerName = "node-$_"
            MetricA = $_ / 2
            MetricB = 'OK','WARN','ERROR' | Get-Random
        }

    } |
    Wait-RSJob |
    Receive-RSJob
}

# Give it a try!
    # Query information from hundreds/thousands of systems
    # Spin things up quickly (be wary of load!)
    # Exhaust your RAM

#### Posh-SSH ####
####

# OpenSSH is being ported by Microsoft but...
# Still need abstraction!  Paramiko, Spur, etc.

Install-Module Posh-SSH -Force
Import-Module Posh-SSH

# SSH, SFTP, SCP
Get-Command -Module Posh-SSH

# Pull some sanitization data and node names
$Redacted = Get-Content C:\redacted.txt # phrases|to|redact
$ComputerName = Get-Content C:\Computers.txt

# Nodes we'll work with:
$ComputerName -replace $Redacted, '*'

# Calculated Property (hash table) to redact hostnames
$hostname = @{
    label = "Host"
    expression = {$_.Host -replace $Redacted, '*'}
}

# Start some sessions!
$Cred = Get-Credential
$sessions = New-SSHSession -ComputerName $ComputerName `
                           -Credential $Cred `
                           -AcceptKey #What could go wrong

# View sessions... redact hostnames with calculated property...
$Sessions | Select SessionID,
                   Connected,
                   $hostname

# Run a simple command, select redacted hostname, os type
Invoke-SSHCommand -SSHSession $sessions -command "uname" |
    Select $hostname,
           @{ label = "OSType"; expression = {$_.Output[0]} }

# Remove our session:
Get-SSHSession | Remove-SSHSession

#### ImportExcel ####
####

Install-Module ImportExcel -Force
Import-Module ImportExcel

# Similar to *-Job, but faster and uses fewer resources
Get-Command -Module ImportExcel

# We got random data from the PoshRSJob example:
$Output

# Send it to Excel!
$Output |
    Export-Excel -Path C:\Plain.xlsx `
                 -AutoSize `
                 -FreezeTopRowFirstColumn `
                 -TableName Hmm

# Read it back from Excel
Import-Excel -Path C:\Plain.xlsx    

#### PSSlack ####
####

Install-Module PSSlack -Force
Import-Module PSSlack

# Similar to *-Job, but faster and uses fewer resources
Get-Command -Module PSSlack

# Set my token (URL in notes)
Set-PSSlackConfig -Token $(Get-Content C:\token.txt)
Get-PSSlackConfig # will it show the whole token?

# Send an alert!
if($Output.MetricB -Contains 'ERROR')
{
    # Only one in this example...
    $NodeDetail = $Output |
        Where {$_.MetricB -eq 'ERROR'} |
        Select -First 1

    # Make a list with details
    $Name = $NodeDetail.ComputerName
    $NodeText = $NodeDetail |
        Format-List |
        Out-String
    
    $Splat = @{
        AuthorName = 'SCOM Bot'
        AuthorIcon = 'http://ramblingcookiemonster.github.io/images/tools/wrench.png'
        Title = "Error 125: $Name"
        TitleLink = 'https://www.youtube.com/watch?v=TmpRs7xN06Q'
        Pretext = "Everything is broken"
        Text = "Found error 1 2 5 with the following details:`n``````$($NodeText.trim())``````"
        Color = [System.Drawing.Color]::Red
        MarkDownFields = 'text'
        Fallback = 'Your client is bad'
    }

    # Send the message!
    New-SlackMessageAttachment @splat |
        New-SlackMessage -Channel 'boston' `
                         -IconEmoji :bomb: |
        Send-SlackMessage
}

# Before sending other alerts you might check for recent duplicates...
Get-SlackChannel -Name boston |
    Get-SlackHistory -After (Get-Date).AddMinutes(-5) |
    Where {$_.Attachments.Text -match "^Found error 1 2 5" } |
    Select -ExpandProperty Attachments