$root = Split-Path -Path $PSScriptRoot -Parent
$tempmount = Join-Path -path $root -childpath "TempMount"
$startfilenew = Join-Path -Path $PSScriptRoot -ChildPath "DefaultLayouts.xml"
$startfileold = Join-Path -Path $tempmount -ChildPath "Users\Default\AppData\Local\Microsoft\Windows\Shell\DefaultLayouts.xml"
$exit = ""
$n = 0
$wim = "\install.wim"
$appx = @(
"Microsoft.GetHelp_10.1706.13331.0_neutral_~_8wekyb3d8bbwe",
"Microsoft.Getstarted_7.3.20251.0_neutral_~_8wekyb3d8bbwe",
"Microsoft.MicrosoftOfficeHub_18.1901.1141.0_neutral_~_8wekyb3d8bbwe",
"Microsoft.MicrosoftSolitaireCollection_4.2.11280.0_neutral_~_8wekyb3d8bbwe",
"Microsoft.MicrosoftStickyNotes_3.1.53.0_neutral_~_8wekyb3d8bbwe",
"Microsoft.MixedReality.Portal_2000.19010.1151.0_neutral_~_8wekyb3d8bbwe",
"Microsoft.WindowsFeedbackHub_2019.226.2324.0_neutral_~_8wekyb3d8bbwe",
"Microsoft.Xbox.TCUI_1.23.28002.0_neutral_~_8wekyb3d8bbwe",
"Microsoft.XboxApp_48.48.7001.0_neutral_~_8wekyb3d8bbwe",
"Microsoft.XboxGameOverlay_1.32.17005.0_neutral_~_8wekyb3d8bbwe",
"Microsoft.XboxGamingOverlay_2.26.14003.0_neutral_~_8wekyb3d8bbwe",
"Microsoft.XboxIdentityProvider_12.50.6001.0_neutral_~_8wekyb3d8bbwe",
"Microsoft.XboxSpeechToTextOverlay_1.17.29001.0_neutral_~_8wekyb3d8bbwe",
"Microsoft.YourPhone_2018.1128.231.0_neutral_~_8wekyb3d8bbwe",
"Microsoft.ZuneMusic_2019.18111.17311.0_neutral_~_8wekyb3d8bbwe",
"Microsoft.ZuneVideo_2019.18111.17311.0_neutral_~_8wekyb3d8bbwe"
)


$winver = dir $root -Directory -Filter {*Windows*} | Out-GridView -OutputMode Single -Title "Image wählen"


$image = Join-Path -path $root -childpath $winver$wim

DISM /Cleanup-WIM
Mount-WindowsImage -Path $tempmount -Index 1 -ImagePath $image -ErrorAction Stop


foreach($app in $appx){
    try
    {
        Remove-AppxProvisionedPackage -Path $tempmount -PackageName $app | Out-Null
        Write-Host "Das Paket $app wurde erfolgreich entfernt"
    }
    catch
    {
        Write-Host "Das Paket $app konnte nicht entfernt werden"
    }
}


Copy-Item -Path $startfilenew -Destination $startfileold -Force

Dismount-WindowsImage -Path $tempmount -Save
DISM /Cleanup-WIM