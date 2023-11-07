:start

echo Checking if an update is needed...

powershell -Command "$TIME_OF_DAY=wmic path win32_utctime get hour"

powershell -Command "$env:TIME_OF_DAY=$TIME_OF_DAY -replace '[^0-9].*' , ''"

powershell -Command "if(!$env:TIME_OF_DAY -eq 6){ 'Trying app update ...' }"

powershell -Command "if(!$env:TIME_OF_DAY -eq 6){ C:\servers\steamcmd.exe  +login anonymous  +force_install_dir C:\servers\rust3\  +app_update 258550 validate  +quit }"

echo Changing to Rust 3 server folder ...

cd C:\servers\rust3

powershell -Command "if(!$env:TIME_OF_DAY -eq 6){ Invoke-WebRequest -URI https://umod.org/games/rust/download -OutFile oxide.zip }"

powershell -Command "if(!$env:TIME_OF_DAY -eq 6){ Expand-Archive oxide.zip -Force -DestinationPath 'C:\servers\rust3\' }"

powershell -Command "if(!$env:TIME_OF_DAY -eq 6){ foreach ($file in Get-ChildItem 'C:\servers\rust3\oxide\plugins' -Name -Include '*.cs'){ $umodUrl='https://umod.org/plugins/' + $file; try { $ouputFile='C:\servers\rust3\oxide\plugins\' + $file ;Start-Sleep -Seconds 2; Invoke-WebRequest -URI $umodUrl -OutFile $ouputFile } catch { $fileError= 'C:\servers\rust3\oxide\logs\' + $file + 'UmodError.txt'; $file + ' - ' + $umodUrl + ' - ' + $_.Exception > $fileError } } }"

echo Checking if it is WIPE DAY...

powershell -Command "$DAY_OF_WEEK=wmic path win32_utctime get dayofweek"

powershell -Command "$env:DAY_OF_WEEK=$DAY_OF_WEEK -replace '[^0-9].*' , ''"

powershell -Command "$WEEK_IN_MONTH=wmic path win32_utctime get weekinmonth"

powershell -Command "$env:WEEK_IN_MONTH=$WEEK_IN_MONTH -replace '[^0-9].*' , ''"

powershell -Command "$TIME_OF_DAY=wmic path win32_utctime get hour"

powershell -Command "$env:TIME_OF_DAY=$TIME_OF_DAY -replace '[^0-9].*' , ''"

powershell -Command "if([int]$env:DAY_OF_WEEK -eq 4){ 	if([int]$env:WEEK_IN_MONTH -eq 1){ 		if([int]$env:TIME_OF_DAY -gt 18){			$WIPE_DAY=1		}	}  } else {	 $WIPE_DAY=0  }"

powershell -Command "if($WIPE_DAY -eq 1){ 'Wipe day is TRUE, wiping...' } else { 'Wipe day is FALSE or variable not set.'}"

powershell -Command "if($WIPE_DAY -eq 1){Remove-Item -Path 'C:\servers\rust3\server\flashhammerargentina\*' -Exclude 'cfg','serveremoji'}"

echo Starting server...

RustDedicated.exe -batchmode  ^
+server.queryport 26021  ^
+rcon.port 26022  ^
+server.port 26023  ^
+app.port 26024  ^
+server.level "Procedural Map"  ^
+server.seed 1378081518  ^
+server.worldsize 6000  ^
+server.maxplayers 100  ^
+server.tags "monthly,vanilla,SA"  ^
+server.hostname "FH Argentina Vanilla Mapa Enorme"  ^
+server.description "Flashhammer Argentina Vanilla https://www.youtube.com/@JulLun https://discord.gg/85dcCtEfze"  ^
+server.url "https://discord.gg/85dcCtEfze"  ^
+server.identity "flashhammerargentina"  ^
+rcon.password lalalalaralala  ^
+rcon.web 1  ^
+logFile "output.txt"  ^
+autoupdate

echo.
echo Restarting server...
echo.
goto start