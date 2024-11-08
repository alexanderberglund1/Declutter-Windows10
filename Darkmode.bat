@echo off
title Windows 10 Dark Mode Enabler
color 0A

echo Enabling Windows 10 Dark Mode...
echo ===============================
echo.

:: Enable Dark Mode for System
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v SystemUsesLightTheme /t REG_DWORD /d 0 /f
if %errorlevel%==0 (
    echo [OK] System Dark Mode enabled
) else (
    echo [ERROR] Couldn't enable System Dark Mode
)

:: Enable Dark Mode for Apps
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme /t REG_DWORD /d 0 /f
if %errorlevel%==0 (
    echo [OK] Apps Dark Mode enabled
) else (
    echo [ERROR] Couldn't enable Apps Dark Mode
)

:: Enable Dark Mode for Edge Legacy (if installed)
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 1 /f
if %errorlevel%==0 (
    echo [OK] Transparency effects enabled
) else (
    echo [ERROR] Couldn't enable transparency effects
)

echo.
echo Dark Mode setup complete! 
echo You may need to restart your computer or log out/in for all changes to take effect.
echo.
pause