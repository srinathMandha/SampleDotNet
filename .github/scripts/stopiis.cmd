@echo off

REM Define the application pool name
set AppPoolName=DefaultAppPool

REM Stop the application pool using appcmd
%windir%\system32\inetsrv\appcmd stop apppool /apppool.name:"%AppPoolName%"

REM Check if the application pool is stopped
%windir%\system32\inetsrv\appcmd list apppool /name:%AppPoolName% /text:state | find "Stopped"
if %errorlevel% equ 0 (
    echo Successfully stopped the application pool: %AppPoolName%
    exit /b 0
) else (
    echo Failed to stop the application pool: %AppPoolName%. Retrying in 10 seconds...
    timeout /t 10
)

REM Retry stopping the application pool
%windir%\system32\inetsrv\appcmd stop apppool /apppool.name:"%AppPoolName%"

REM Final check if the application pool is stopped
%windir%\system32\inetsrv\appcmd list apppool /name:%AppPoolName% /text:state | find "Stopped"
if %errorlevel% equ 0 (
    echo Successfully stopped the application pool: %AppPoolName% after retry.
    exit /b 0
) else (
    echo Failed to stop the application pool: %AppPoolName% after retry.
    exit /b 1
)
