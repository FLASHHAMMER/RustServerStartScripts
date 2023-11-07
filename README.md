# RustServerStartScripts
Facepunch Rust Server Start Scripts

Start scripts for procedural and custom maps for Windows (Powershell and CMD required).

One is set to weekly wipe and the other to monthly wipe, they are not dinamic, but they are pretty automatic if correctly configured.

More details below:

## Requisites

 - Windows in a decent hardware
 - SteamCMD
 - .NET Framework installed
 - Network with a static IP and forwarded ports in the router.

More information: https://wiki.facepunch.com/rust/Creating-a-server

## Run the BAT

You can start the batch files with the following Powershell commands:

```powershell
C:\Windows\System32\cmd.exe /c start /WAIT /HIGH C:\servers\rust1\rustserverstart.bat
```

```powershell
C:\Windows\System32\cmd.exe /c start /WAIT /HIGH C:\servers\rust3\rustserverstart.bat
```

##  Optional plugins

You can get plugins at https://umod.org/plugins?page=1&sort=latest_release_at&sortdir=desc&categories=rust
The scrips autoupdate the plugins when a non daily reboot is performed, you have to set the hour you want to do the daily reboot, in my case is 6:00 UTC.
I use SmoothRestarter plugin to manage reboots, it also detects when Oxide updates are available: https://umod.org/plugins/smooth-restarter

## Windows Powershell Time options and logic

For the wipe time and update or common reboot I used Powershell scripting. This is the first version, it can be improved, I haven't spent much time on it.

I'm using the following commands to get UTC time information:

```powershell
wmic path win32_utctime get hour
```

```powershell
wmic path win32_utctime get weekinmonth
```

```powershell
wmic path win32_utctime get dayofweek
```

Facepunch releases mostly every month at the same time every first thurday, at around 19:00 UTC, so I set to check if it is the first week of the month, if it is thursday and if the hour is greater than 18. 

More information here:
https://learn.microsoft.com/en-us/previous-versions/windows/desktop/wmitimepprov/win32-utctime

## Sections

 - Update.
 - Folder set, Umod Oxide update/install and Umod Oxide plugins update.
 - Wipe day, week and time check to erase server and Backpacks plugin.
 - Start server with options.

### Update

I decide in this section if a SteamCMD update and an app/game update is going to be performed.
I compare if the hour is equal to the desired hour UTC and run this in case it is not the daily reboot:

```powershell
C:\servers\steamcmd.exe  +login anonymous  +force_install_dir C:\servers\rust3\  +app_update 258550 validate  +quit
```

### Folder set, Umod Oxide update/install and Umod Oxide plugins update

Change the folder to the desired folder.
If it is not the daily reboot then it will:
 - Download the Oxide ZIP.
 - Overwrite the Oxide in the game folder.
 - Overwrite all the Umod C# scripts you already have installed in your Oxide. It also logs failures.

More information about Oxide: https://umod.org/documentation/getting-started

### Wipe day, week and time check to erase server and Backpacks plugin

This decides if it is wipe day and erase the needed folders or archives.
In combination with SmoothRestarter plugin, it can be used to automatically detect the after-montly-update Oxide update and wipe automatically.

### Start server with options

Start the batch for the application server. Both scripts are different.
More information on the RustDedicated batch: https://wiki.facepunch.com/rust/Creating-a-server
 
