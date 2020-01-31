$root = Split-Path -Path $PSScriptRoot -Parent
$tempmount = join-path -path $root -childpath "TempMount"
$drivers = join-path -path $root -childpath "Driver"
$exit = ""
$n = 0
$wim = "\install.wim"
$winver = dir $root -Directory -Filter {*Windows*} | Out-GridView -OutputMode Single -Title "Image wählen"

$image = join-path -path $root -childpath $winver$wim

DISM /Cleanup-WIM
Mount-WindowsImage -Path $tempmount -Index 1 -ImagePath $image

#Add Drivers to WIM

Add-WindowsDriver -Path $tempmount -Driver $drivers

Dismount-WindowsImage -Path $tempmount -Save

DISM /Cleanup-WIM
