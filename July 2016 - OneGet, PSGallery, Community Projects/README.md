# BPSUG July 2016 Meetup

* **Topic**: OneGet, PowerShell Gallery, and Community Project Highlights
* **Presenter**: [Warren Frame](https://twitter.com/psCookieMonster)

## Materials

* [Youtube recording](https://www.youtube.com/watch?v=_O27n1flJ4k) - skip 49:11 through 53:26, where we took a short break (read: I needed to reset a token I streamed to the Internet)
* [Slides](https://docs.google.com/presentation/d/1_KDmP9H4avBaFcHi2KsNRVQfnBTis-3tXn4S3Kn0UkA/edit?usp=sharing)
* [PackageManagement and PowerShellGet code](0-gallery.ps1)
* [Community projects code](1-gallery-community.ps1)
* [Publish to the gallery](2-gallery-extras.ps1)

## References

* [Google Hangout on Air](https://plus.google.com/events/cqj91mlthb6rtro52n1lcbgddao)
* Presenter details:
  * [Twitter: @pscookiemonster](https://twitter.com/psCookieMonster)
  * [Blog](http://ramblingcookiemonster.github.io/)
  * [GitHub](https://github.com/RamblingCookieMonster)
  * [LinkedIn](https://www.linkedin.com/in/wframe)
* [PowerShell Gallery](https://www.powershellgallery.com/)
  * [PowerShell 5 justification](http://www.asd.gov.au/publications/protect/securing-powershell.htm): "Organisations should install PowerShell version 5.0 where possible due to the superior logging capabilities provided over earlier versions."  Also, [comprehensive list of resources](https://blogs.technet.microsoft.com/ashleymcglone/2016/06/29/whos-afraid-of-powershell-security/) from Microsoftee @GoateePFE
  * [WMF 5 compatibility](https://msdn.microsoft.com/en-us/powershell/wmf/5.0/productincompat)
* Community Projects:
  * [ImportExcel](https://github.com/dfinke/ImportExcel) (and [gifcam](http://blog.bahraniapps.com/gifcam/))
  * [PoshRSJob](https://github.com/proxb/PoshRSJob)
  * [Posh-SSH](https://github.com/darkoperator/Posh-SSH)
    * [Win32-OpenSSH](https://github.com/PowerShell/Win32-OpenSSH)
  * [PSSlack](https://github.com/RamblingCookieMonster/PSSlack)
    * [Grab a token](https://api.slack.com/docs/oauth-test-tokens), or reset one you streamed live
* Publishing on PowerShell Gallery
  * [Benefits of Open Source](http://www.themacro.com/articles/2016/05/why-the-best-give-away/), and [webinar for legal teams](https://www.chef.io/blog/event/webinar-open-source-licensing-by-lawyers-for-lawyers/).
  * [PowerShell Gallery API Key](https://www.powershellgallery.com/account)
  * [Tips on writing a module](http://ramblingcookiemonster.github.io/Building-A-PowerShell-Module/)
  * [Automatically publish via GitHub + AppVeyor](http://ramblingcookiemonster.github.io/PSDeploy-Inception/)
* Internal Repositories
  * [PSPrivateGallery](https://github.com/PowerShell/PSPrivateGallery) and [WIP walk through](https://michaeltlombardi.github.io/PSPrivateGalleryWalkthrough/)
  * [ProGet](http://inedo.com/proget/pricing/features-by-edition)
  * [Artifactory](https://www.jfrog.com/confluence/display/RTF/Artifactory+Comparison+Matrix)
* Questions
  * On the Deploy to Azure Automation button in the PowerShell Gallery - this adds the module to your Automation account, pulls out activities from the module:
    * [Gallery Getting Started page](https://www.powershellgallery.com/GettingStarted), ctrl+f Azure Automation
    * [Runbook and module galleries for Azure Automation](https://azure.microsoft.com/en-us/documentation/articles/automation-runbook-gallery/)
  * On signing PowerShell modules:
    * Note: Execution policy is not a security boundary. If you want to sign code, do it to enable application whitelisting solutions like AppLocker, where you can then say 'only allow scripts signed with this certificate to run.' [Sean Metcalf's reference on PowerShell security](https://adsecurity.org/?p=2604) is a great overview of your options from a security perspective.
    * [Reference](http://www.darkoperator.com/blog/2013/3/5/powershell-basics-execution-policy-part-1.html) from Carlos Perez (who wrote the Posh-SSH module)
