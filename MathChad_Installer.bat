@echo off

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------
@echo off   
echo MathChad Installer
title MathChad Installer
color 0A
pause
echo Installing...
ping 192.0.2.2 -n 1 -w 5000 > nul
cd %appdata%
mkdir MathChad
cd MathChad
curl -o python.bat --url https://mathchad.netlify.app/install_python.bat
start cmd /c python.bat
curl -o main.py --url https://mathchad.netlify.app/algebrasolver.py
curl -o MathChad.bat --url https://mathchad.netlify.app/launch.bat
mkdir web
cd web
curl -o index.html --url https://mathchad.netlify.app/web/index.html
curl -o style.css --url https://mathchad.netlify.app/web/style.css
curl -o script.js --url https://mathchad.netlify.app/web/script.js
cd %USERPROFILE%
cd Desktop
set "ShortcutPath=%USERPROFILE%\Desktop\MathChad.lnk"
set "TargetPath=%APPDATA%\MathChad\"

echo Set oWS = WScript.CreateObject("WScript.Shell") > CreateShortcut.vbs
echo sLinkFile = "%ShortcutPath%" >> CreateShortcut.vbs
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> CreateShortcut.vbs
echo oLink.TargetPath = "%TargetPath%" >> CreateShortcut.vbs
echo oLink.Save >> CreateShortcut.vbs

cscript //nologo CreateShortcut.vbs
del CreateShortcut.vbs
ping 192.0.2.2 -n 1 -w 10000 > nul
cls
echo MathChad installed.
echo In your desktop, there is a shortcut to the MathChad folder. 
echo Open the shortcut and click on MathChad.bat
echo This would start up MathChad.
pause
exit