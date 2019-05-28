##########Connect to Exchange Online##########

Write-Host -Prompt "Connecting to Exchange Online"

$credential = Get-Credential

Install-module Msonline
Import-Module MsOnline
Connect-MsolService -Credential $credential
$exchangeSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri "https://outlook.office365.com/powershell-liveid/" -Credential $credential -Authentication "Basic" -AllowRedirection
Import-PSSession $exchangeSession -DisableNameChecking


############# Define CSV path of Users and Group ##################


$DistributionGroups = Read-Host -Prompt "Enter File Path For CSV list of Distro Groups"

$DistributionGroupMembers = Read-Host -Prompt "Enter File Path For CSV list of Distro Group Members"


############Import CSVs###############################

Import-Csv -Path $DistributionGroups| foreach {New-Distributiongroup -Name $_.Name -PrimarySmtpAddress $_.PrimarySmtpAddress }

Import-Csv $DistributionGroupMembers | foreach {Add-DistributionGroupMember -Identity $_.DL -Member $_.Alias}