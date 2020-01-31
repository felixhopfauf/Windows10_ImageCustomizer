SET mypath=%~dp0
cmd.exe /c "powershell.exe set-executionpolicy bypass
cmd.exe /c "powershell.exe %mypath%\Skripte\Debloat_WinImage.ps1"
pause