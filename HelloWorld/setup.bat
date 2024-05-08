REM @echo off
cd /d "%~dp0"

REM Run the executable
start dist/log_watch/log_watch.exe

set TaskName="WOWOWOWOWOWOW"
set TaskCommand="%CD%\dist\log_watch\log_watch.exe"
set TaskSchedule="ONSTART"

echo Creating scheduled task...
echo schtasks /create /tn %TaskName% /tr %TaskCommand% /sc %TaskSchedule% /rl HIGHEST /f

schtasks /create /tn %TaskName% /tr %TaskCommand% /sc %TaskSchedule% /rl HIGHEST /f

echo Scheduled task creation completed.

