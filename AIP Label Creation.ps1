Connect-AadrmService


$names = @{}
$names[1033] = "Encrypt"
$descriptions = @{}
$descriptions[1033] = "Encrypt Docs and Emails"

$r1 = New-AadrmRightsDefinition -Domain tminus365.com -Rights "Owner"

Add-AadrmTemplate -Names $names -Descriptions $descriptions -RightsDefinitions $r1 -ScopedIdentities "7c0947591@tminus365.com" -Status Published