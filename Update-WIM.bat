SET mypath=%~dp0
cmd.exe /c "powershell.exe set-executionpolicy bypass
cmd.exe /c "powershell.exe %mypath%\Skripte\Update_WinImage.ps1"
pause