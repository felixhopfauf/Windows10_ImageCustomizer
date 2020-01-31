SET mypath=%~dp0
cmd.exe /c "powershell.exe set-executionpolicy bypass
cmd.exe /c "powershell.exe %mypath%\Skripte\AddDriver_WinImage.ps1"
pause