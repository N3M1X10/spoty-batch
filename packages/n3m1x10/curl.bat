@echo off
>nul chcp 65001
set output=%~dp0SpotifySetup.exe
set /p url=Enter spotify's installer URL: 
set curl=C:\Windows\System32\curl.exe
IF EXIST "%output%" (del /q "%output%")
%curl% %url% --output %output%
echo.
echo [92mComplete![0m
echo.
pause
exit
