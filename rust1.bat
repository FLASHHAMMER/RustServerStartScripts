:start

echo Checking if an update is needed...

powershell -Command "$TIME_OF_DAY=wmic path win32_utctime get hour"

powershell -Command "$env:TIME_OF_DAY=$TIME_OF_DAY -replace '[^0-9].*' , ''"

powershell -Command "if(!$env:TIME_OF_DAY -eq 6){ 'Trying app update ...' }"

powershell -Command "if(!$env:TIME_OF_DAY -eq 6){ C:\servers\steamcmd.exe  +login anonymous  +force_install_dir C:\servers\rust1\  +app_update 258550 validate  +quit }"

echo Changing to Rust 1 server folder ...

cd C:\servers\rust1

powershell -Command "if(!$env:TIME_OF_DAY -eq 6){ Invoke-WebRequest -URI https://umod.org/games/rust/download -OutFile oxide.zip }"

powershell -Command "if(!$env:TIME_OF_DAY -eq 6){ Expand-Archive oxide.zip -Force -DestinationPath 'C:\servers\rust1\' }"

echo Checking if it is WIPE DAY...

powershell -Command "$DAY_OF_WEEK=wmic path win32_utctime get dayofweek"

powershell -Command "$env:DAY_OF_WEEK=$DAY_OF_WEEK -replace '[^0-9].*' , ''"

powershell -Command "$WEEK_IN_MONTH=wmic path win32_utctime get weekinmonth"

powershell -Command "$env:WEEK_IN_MONTH=$WEEK_IN_MONTH -replace '[^0-9].*' , ''"

powershell -Command "$TIME_OF_DAY=wmic path win32_utctime get hour"

powershell -Command "$env:TIME_OF_DAY=$TIME_OF_DAY -replace '[^0-9].*' , ''"

powershell -Command "if([int]$env:DAY_OF_WEEK -eq 4){ 	if([int]$env:TIME_OF_DAY -gt 18){			$WIPE_DAY=1	}  } else {	 $WIPE_DAY=0  }"

powershell -Command "if($WIPE_DAY -eq 1){ 'Wipe day is TRUE, wiping...' } else { 'Wipe day is FALSE or variable not set.' }"

powershell -Command "if($WIPE_DAY -eq 1){ Remove-Item -Path 'C:\servers\rust1\server\flashhammer\*' -Exclude 'cfg','serveremoji' }"

powershell -Command "if($WIPE_DAY -eq 1){ Remove-Item -Path 'C:\servers\rust1\oxide\data\Backpacks\*' }"

echo Starting server...

RustDedicated.exe -batchmode ^
+server.queryport 26015  ^
+rcon.port 26016  ^
+server.port 26017  ^
+app.port 26024  ^
+server.levelurl "https://www.dropbox.com/scl/fi/lalalarala/Isla-Nublar-1.4.0-FH.map?rlkey=lalalalalala&dl=1"  ^
+server.maxplayers 50  ^
+server.tags "weekly,SA"  ^
+server.hostname "FH Jurassic Rust Argentina Isla Nublar"  ^
+server.description "vanilla loot, gather x3 menos azufre, stacks x10, mochila, NPCs dropean armas aleatoriamente, almacenamiento y asientos extra en medios de transporte, SAM site auth para TC, splitter,etc. https://www.youtube.com/@JulLun https://discord.gg/85dcCtEfze"  ^
+server.url "https://discord.gg/85dcCtEfze"  ^
+server.headerimage "https://www.flashhammer.com/assets/img/jurassic-world--660x371.jpg"  ^
+server.identity "flashhammerargentina"  ^
+rcon.password lalalaralala  ^
+rcon.web 1  ^
+logFile "output.txt"  ^
+autoupdate

echo.
echo Restarting server...
echo.
goto start