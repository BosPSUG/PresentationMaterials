# This is in the 'get it working' stage - will change significantly...

$DotsPath = 'E:\Dots'
Invoke-PSDepend -Path $DotsPath\.requirements.psd1 -Install -Import -Force
Import-Module E:\Dots -Force

Clear-Neo4j

Connect-TheDots -WhatIf
Connect-TheDots -WhatIf -Include ADComputers
Connect-TheDots -WhatIf -Scope Manual


Connect-TheDots -Confirm:$False

# 127.0.0.1:7474/

Clear-Neo4j