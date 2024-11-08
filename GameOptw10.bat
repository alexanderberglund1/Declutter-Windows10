@echo off
title Windows 10 Gaming Optimizer by Alexander Berglund
color 0A

echo Windows 10 Gaming Optimizer
echo Created by Alexander Berglund
echo https://github.com/alexanderberglund1
echo.
echo Starting optimization process...
timeout /t 3 >nul

:: Better check admin rights first so we don't waste time
net session >nul 2>&1
if %errorLevel% == 0 (
    echo Great! Running with admin rights...
) else (
    echo Hey! You need to run this as admin!
    echo Right click the script and select 'Run as administrator'
    pause
    exit
)

echo.
echo Making a restore point just in case...
wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "Before Gaming Tweaks", 100, 7

:: Let's get that power plan sorted
echo.
echo Setting up power for maximum performance...
powercfg -duplicatescheme 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c

:: Get rid of that annoying Game DVR stuff
echo.
echo Removing Xbox Game DVR - nobody uses that anyway...
reg add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d "0" /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehaviorMode" /t REG_DWORD /d "2" /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehavior" /t REG_DWORD /d "2" /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_HonorUserFSEBehaviorMode" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d "0" /f

:: Fullscreen optimizations just cause problems
echo.
echo Fixing fullscreen issues...
reg add "HKCU\System\GameConfigStore" /v "GameDVR_DXGIHonorFSEWindowsCompatible" /t REG_DWORD /d "1" /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_EFSEFeatureFlags" /t REG_DWORD /d "0" /f

:: CPU needs to prioritize games
echo.
echo Making sure games get the CPU priority they deserve...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d "8" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d "6" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f

:: Windows loves to eat RAM with visual stuff
echo.
echo Optimizing visual effects - making it lean...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" /t REG_DWORD /d "2" /f

:: Kill power throttling - we want speed!
echo.
echo Removing power limits - let it rip!
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d "1" /f

:: Clean up the junk
echo.
echo Cleaning up temp files - free up some space...
del /s /f /q %temp%\*.*
del /s /f /q C:\Windows\Temp\*.*

:: These services just slow games down
echo.
echo Turning off some unnecessary services...
sc config "DiagTrack" start= disabled
sc config "WSearch" start= disabled
net stop "DiagTrack" >nul 2>&1
net stop "WSearch" >nul 2>&1

:: Windows Update needs to chill during gaming
echo.
echo Setting Windows Update to not bother you while gaming...
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "BranchReadinessLevel" /t REG_DWORD /d "20" /f
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "DeferFeatureUpdatesPeriodInDays" /t REG_DWORD /d "365" /f

echo.
echo ================================
echo All done! Your PC is now optimized for gaming!
echo Created by Alexander Berglund
echo https://github.com/alexanderberglund1
echo ================================
echo.
set /p restart="Want to restart now to apply everything? (y/n): "
if /i "%restart%"=="y" (
    shutdown /r /t 10 /c "Restarting to apply gaming optimizations..."
    echo Restarting in 10 seconds...
    echo Press any key to cancel restart...
    timeout /t 10
)
pause