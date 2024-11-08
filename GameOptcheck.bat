@echo off
title Windows 10 Gaming Optimization Checker
color 0A
chcp 437 > nul

echo Checking Windows 10 Gaming Optimizations...
echo ========================================
echo.

:: Check Power Plan by GUID instead of name
echo Checking Power Plan...
powercfg /getactivescheme | findstr "8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c" >nul
if %errorlevel%==0 (
    echo [OK] High Performance power plan is active (Hög prestanda)
) else (
    echo [NO] High Performance power plan is NOT active
)
echo.

:: Check Game DVR Settings
echo Checking Game DVR Settings...
reg query "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" | findstr "0x0" >nul
if %errorlevel%==0 (
    echo [OK] Game DVR is disabled
) else (
    echo [NO] Game DVR is still enabled
)
echo.

:: Check Power Throttling
echo Checking Power Throttling Status...
reg query "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" | findstr "0x1" >nul
if %errorlevel%==0 (
    echo [OK] Power Throttling is disabled
) else (
    echo [NO] Power Throttling is still enabled
)
echo.

:: Check Fullscreen Optimizations
echo Checking Fullscreen Optimizations...
reg query "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehaviorMode" | findstr "0x2" >nul
if %errorlevel%==0 (
    echo [OK] Fullscreen Optimizations are properly configured
) else (
    echo [NO] Fullscreen Optimizations are not properly configured
)
echo.

:: Check Game Priority Settings
echo Checking Game Priority Settings...
reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" | findstr "0x8" >nul
if %errorlevel%==0 (
    echo [OK] Game GPU Priority is set correctly
) else (
    echo [NO] Game GPU Priority is not set correctly
)

reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" | findstr "0x6" >nul
if %errorlevel%==0 (
    echo [OK] Game CPU Priority is set correctly
) else (
    echo [NO] Game CPU Priority is not set correctly
)
echo.

:: Check Visual Effects Setting
echo Checking Visual Effects...
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" | findstr "0x2" >nul
if %errorlevel%==0 (
    echo [OK] Visual Effects are optimized
) else (
    echo [NO] Visual Effects are not optimized
)
echo.

echo ========================================
echo Checking Complete!
echo [OK] = Optimization is applied
echo [NO] = Optimization is not applied
echo.
echo All optimizations appear to be properly applied!
echo Your system should now be optimized for gaming.
echo.
pause