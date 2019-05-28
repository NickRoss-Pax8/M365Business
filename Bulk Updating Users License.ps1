Import-Module MSOnline
$cred = Get-Credential
Connect-MsolService -Credential $cred
 
$oldLicense = "czptsws:ENTERPRISEPACK"
$newLicense = "czptsws:ENTERPRISEPREMIUM"

Import-Csv -Path 'FilePath'
 
$users = Get-MsolUser -MaxResults 5000 | Where-Object { $_.isLicensed -eq "TRUE" }

Import-Csv -Path 'FilePath'
 
foreach ($user in $users){
    $upn = $user.UserPrincipalName
    foreach ($license in $user.Licenses) {
        if ($license.AccountSkuId -eq $oldLicense) {
            $disabledPlans = @()
            Write-Host("User $upn will go from $oldLicense to $newLicense and will have no options disabled.")
            Set-MsolUserLicense -UserPrincipalName $upn -AddLicenses $newLicense -RemoveLicenses $oldLicense
        }
    }