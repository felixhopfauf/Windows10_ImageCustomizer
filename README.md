# Windows10_ImageCustomizer

Folder Structure: (Needs to be created manually)

Windows10_ImageCustomizer/ </br>
├── Driver/ <--- must be created </br>
│   └── (Place Driver INF Files here)</br>
│</br>
├── Skripte/\
│   └── (Place for Powershell Scripts)\
│\
├── TempMount/ <--- must be created\
│   └── (Is needed for Mounting WIM File)\
│\
├── Updates/ <--- must be created\
│   └── (Place Update Files from https://www.catalog.update.microsoft.com/Home.aspx here)\
│\
└── Windows10_WIM/ <--- must be created\
    └── (Place your clean WIM File here)

All .bat Files needs to be executed as Administrator to run propably.

Check Skripte\Debloat_WinImage.ps1 if it meets your requierments.

The File Mount-WIM.bat mounts the WIM to the "TempMount" Folder so can  add your changes manually.
