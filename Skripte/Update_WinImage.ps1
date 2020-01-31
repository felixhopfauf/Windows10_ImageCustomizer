$root = Split-Path -Path $PSScriptRoot -Parent
$tempmount = join-path -path $root -childpath "TempMount"
$updates = join-path -path $root -childpath "Updates"
$exit = ""
$n = 0
$wim = "\install.wim"
$winver = dir $root -Directory -Filter {*Windows*} | Out-GridView -OutputMode Single -Title "Image wählen"

$image = join-path -path $root -childpath $winver$wim

DISM /Cleanup-WIM
Mount-WindowsImage -Path $tempmount -Index 1 -ImagePath $image

$updates = dir $updates -File -Filter {*windows*}
foreach($u in $updates){
Write-Host $u
}

$exit = Read-Host "Sind diese Updates okay ?(y/n)" 
if($exit -eq "n"){
exit
}

#Add Updates to WIM
Get-ChildItem -Path $updates -Include *.cab,*.msu -Recurse | ForEach-Object {
        $FileName = $_.BaseName

        try {
            Add-WindowsPackage -PackagePath $_.FullName -Path $tempmount
            Write-Host
        }
        catch {
            Write-Error "Unable to install $Filename"
        }
    }
Dismount-WindowsImage -Path $tempmount -Save

DISM /Cleanup-WIM
