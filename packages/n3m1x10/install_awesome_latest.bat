@echo off
chcp 65001>nul
setlocal

:: Parameters and installing the raw Spotify by: https://github.com/N3M1X10
:: Using patcher: https://github.com/SpotX-Official/SpotX

set "arg=%1"
if "%arg%" == "admin" (
	echo [93m[powershell] Started as admin
    echo.
) else (
    powershell.exe -Command "Start-Process 'cmd.exe' -ArgumentList '/k \"\"%~f0\" admin\"' -Verb RunAs"
    exit
)

:: SpotX

:patcher
setlocal
echo.&echo [92mLaunching [96mSpotX[92m patcher . . .[0m &echo.
>nul timeout /t 1 /nobreak

:: Lines for changing spotx parameters, each parameter should be separated by a space
set param=-sp-uninstall -confirm_uninstall_ms_spoti -podcasts_on -old_lyrics -rightsidebar_off -block_update_on -new_theme -adsections_off -lyrics_stat spotify -no_shortcut -start_spoti

set url='https://raw.githubusercontent.com/SpotX-Official/spotx-official.github.io/main/run.ps1'
set url2='https://spotx-official.github.io/run.ps1'
set tls=[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12;

%SYSTEMROOT%\System32\WindowsPowerShell\v1.0\powershell.exe ^
-Command %tls% $p='%param%'; """ & { $(try { iwr -useb %url% } catch { $p+= ' -m'; iwr -useb %url2% })} $p """" | iex

echo.&echo [93mPress any key to exit . . .
>nul timeout /t 5
endlocal
exit
