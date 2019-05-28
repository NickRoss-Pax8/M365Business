##The cmdlet written below will export all the groups as well as members to a CSV file##

##########Connect to Exchange Online##########

Write-Host -Prompt "Connecting to Exchange Online"

$credential = Get-Credential

Install-module Msonline
Import-Module MsOnline
Connect-MsolService -Credential $credential
$exchangeSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri "https://outlook.office365.com/powershell-liveid/" -Credential $credential -Authentication "Basic" -AllowRedirection
Import-PSSession $exchangeSession -DisableNameChecking


###Export Groups and Members##############################

$Result=@()
$groups = Get-DistributionGroup -ResultSize Unlimited
$totalmbx = $groups.Count
$i = 1
$groups | ForEach-Object {
Write-Progress -activity "Processing $_.DisplayName" -status "$i out of $totalmbx completed"
$group = $_
Get-DistributionGroupMember -Identity $group.Name -ResultSize Unlimited | ForEach-Object {
$member = $_
$Result += New-Object PSObject -property @{
GroupName = $group.DisplayName
Member = $member.Name
EmailAddress = $member.PrimarySMTPAddress
RecipientType= $member.RecipientType
}}
$i++
}
$Result | Export-CSV "C:\users\nickross\documents\All-Distribution-Group-Members.csv" -NoTypeInformation -Encoding UTF8
