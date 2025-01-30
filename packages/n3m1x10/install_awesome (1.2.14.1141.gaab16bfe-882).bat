@echo off
chcp 65001>nul

:: Spoty fast and without "smart shuffle"
:: Parameters and installing the raw Spotify by: https://github.com/N3M1X10
:: Patcher SpotX: https://github.com/SpotX-Official/SpotX

set "arg=%1"
if "%arg%" == "admin" (
	echo ! Run as ADMIN
    echo.
) else (
    powershell.exe -Command "Start-Process 'cmd.exe' -ArgumentList '/k \"\"%~f0\" admin\"' -Verb RunAs"
    exit /b
)

:: Installing

IF EXIST "%appdata%\Spotify\Spotify.exe" (goto patcher)
>nul taskkill /f /im "Spotify.exe" /t &cls
set installer=SpotifySetup.exe
echo Downloading %installer% . . . &echo.
curl.exe ^
--output "%~dp0%installer%" ^
"https://upgrade.scdn.co/upgrade/client/win32-x86_64/spotify_installer-1.2.14.1141.gaab16bfe-882.exe"
>nul timeout /t 1 /nobreak
echo.&echo Trying to start the %installer%
>nul timeout /t 1 /nobreak
if exist "%~dp0%installer%" (start "" "%~dp0%installer%") else (echo [31mError installing the Spotify[0m &pause &exit /b)

:checksetup
>nul timeout /t 1 /nobreak
>nul taskkill /f /im "Spotify.exe" /t
cls
echo Waiting for SpotifySetup.exe to finish his work . . .
tasklist |>nul findstr /b /l /i /c:%installer% || goto installing_complete
goto checksetup

:installing_complete
>nul taskkill /f /im "Spotify.exe" /t
cls
del /q "%installer%"
echo.&echo [92mInstalling complete ![0m
>nul timeout /t 2 /nobreak
:: del spoty shortcut
for /f "usebackq tokens=1,2,*" %%B IN (`reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v Desktop`) do set DESKTOP=%%D
rem for /f "delims=" %%i IN ('echo %DESKTOP%') do set DESKTOP=%%
del /q "%DESKTOP%\Spotify.lnk"
goto patcher

:: SpotX

:patcher
echo [92mLaunching [96mSpotX[92m patcher . . .[0m &echo.
>nul timeout /t 1 /nobreak

:: Lines for changing spotx parameters, each parameter should be separated by a space
set spoty-ver=1.2.14.1141.gaab16bfe-882
set param=-version %spoty-ver% -no_shortcut -podcasts_on -old_lyrics -rightsidebar_off -confirm_uninstall_ms_spoti -confirm_spoti_recomended_over -block_update_on -start_spoti -new_theme -adsections_off -lyrics_stat spotify

set url='https://raw.githubusercontent.com/SpotX-Official/spotx-official.github.io/main/run.ps1'
set url2='https://spotx-official.github.io/run.ps1'
set tls=[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12;

%SYSTEMROOT%\System32\WindowsPowerShell\v1.0\powershell.exe ^
-Command %tls% $p='%param%'; """ & { $(try { iwr -useb %url% } catch { $p+= ' -m'; iwr -useb %url2% })} $p """" | iex

>nul timeout /t 2 & exit
