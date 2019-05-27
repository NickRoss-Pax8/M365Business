﻿####SET UP ATP#########


##########Connect to Exchange Online##########

Write-Host -Prompt "Connecting to Exchange Online"

$credential = Get-Credential

Import-Module MsOnline
Connect-MsolService -Credential $credential
$exchangeSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri "https://outlook.office365.com/powershell-liveid/" -Credential $credential -Authentication "Basic" -AllowRedirection
Import-PSSession $exchangeSession -DisableNameChecking

Enable-OrganizationCustomization


############# Setting Domain Name ##################

$DomainName = Read-Host -Prompt "Enter Tenant Domain Name"

$WhiteListURl = Read-Host -Prompt "Enter any URLs you want to whitelist. If you have none, press enter"


##############Creating Safe Attachments Policy ########################################


New-SafeAttachmentPolicy -Name "Policy 1" -Action Dynamicdelivery -Enable $true -ActionOnError $true
New-SafeAttachmentRule -Name "Safe Attachment Policy" -SafeAttachmentPolicy "Policy 1" -RecipientDomainIs $DomainName


###############Creating Safe Links Policy###########################

New-SafeLinksPolicy -Name "Policy 1" -DoNotTrackUserClicks $true -EnableForInternalSenders $true -DoNotAllowClickThrough $True -TrackClicks $false -ScanUrls $true -AllowClickThrough $false -DoNotRewriteUrls $WhiteListURl -IsEnabled $true

New-SafeLinksRule -Name "SafeLinksPolicy" -SafeLinksPolicy "Policy 1" -RecipientDomainIs $DomainName -Enabled $true