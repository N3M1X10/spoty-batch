@echo off

:: Parameters by: https://github.com/N3M1X10
:: Patcher SpotX: https://github.com/SpotX-Official/SpotX
:: Line for changing spotx parameters, each parameter should be separated by a space
set param=-no_shortcut -podcasts_on -old_lyrics -rightsidebar_off -confirm_uninstall_ms_spoti -confirm_spoti_recomended_over -block_update_on -start_spoti -new_theme -topsearchbar -adsections_off -lyrics_stat spotify

set url='https://raw.githubusercontent.com/SpotX-Official/spotx-official.github.io/main/run.ps1'
set url2='https://spotx-official.github.io/run.ps1'
set tls=[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12;

%SYSTEMROOT%\System32\WindowsPowerShell\v1.0\powershell.exe ^
-Command %tls% $p='%param%'; """ & { $(try { iwr -useb %url% } catch { $p+= ' -m'; iwr -useb %url2% })} $p """" | iex

>nul timeout /t 2 & exit