@echo off & setlocal EnableDelayedExpansion
color 0A
title JAVA VERSION WINDOWS

:: Check if the script has administrator privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo The script requires administrator privileges.
    echo Requesting permissions...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:: Define Java versions and their paths
set "java7=C:\Program Files\Java\jdk1.7.0_80"
set "java8=C:\Program Files\Java\jdk1.8.0_401"
set "java11=C:\Program Files\Java\jdk-11.0.20"
set "java17=C:\Program Files\Java\jdk-17.0.10"
set "java21=C:\Program Files\Java\jdk-21.0.1"
set "java24=C:\Program Files\Java\jdk-24"

:: Define Java download links (update these links if needed)
set "java7_url=https://download.oracle.com/otn/java/jdk/7u80-b15/jdk-7u80-windows-x64.exe"
set "java8_url=https://download.oracle.com/java/8/archive/jdk-8u401-windows-x64.exe"
set "java11_url=https://download.oracle.com/java/11/archive/jdk-11.0.20_windows-x64_bin.exe"
set "java17_url=https://download.oracle.com/java/17/archive/jdk-17.0.10_windows-x64_bin.exe"
set "java21_url=https://download.oracle.com/java/21/archive/jdk-21.0.1_windows-x64_bin.exe"
set "java24_url=https://download.oracle.com/java/24/archive/jdk-24_windows-x64_bin.exe"

:menu
cls

echo.
echo                  _________-----_____
echo        ____------           __      ----_
echo  ___----             ___------              \
echo     ----________        ----                 \
echo                -----__    ^|             _____)
echo                     __-                /     \
echo         _______-----    ___--          \    /)\
echo   ------_______      ---____            \__/  /
echo                -----__    \ --    _          /\
echo                       --__--__     \_____/   \_/\
echo                               ---^|   /          ^|
echo                                  ^| ^|___________^|
echo                                  ^| ^| ((_(_)^| )_)
echo                                  ^|  \_((_(_)^|/(_)
echo                                   \             (
echo                                    \_____________)
echo.
echo.

echo ##########################################################
echo ###########CREDITS BY GITHUB.COM/MAXISANDOVAL37###########
echo ##########################################################
echo.

echo ===============================
echo       Java Version Selector    
echo ===============================
echo.
echo Current Java version:
java -version
echo.

:: Display options
echo Select an option:
echo [1] Show current Java version
echo [2] Use Java 7
echo [3] Use Java 8
echo [4] Use Java 11
echo [5] Use Java 17
echo [6] Use Java 21
echo [7] Use Java 24
echo [8] Exit
echo [9] Download Java version
echo.
set /p choice=Enter the number of the desired option: 
echo.

:: Handle selection
if "%choice%"=="1" (
    echo Current Java version:
    java -version
    pause
    goto menu
)
if "%choice%"=="2" set "JAVA_HOME=!java7!"
if "%choice%"=="3" set "JAVA_HOME=!java8!"
if "%choice%"=="4" set "JAVA_HOME=!java11!"
if "%choice%"=="5" set "JAVA_HOME=!java17!"
if "%choice%"=="6" set "JAVA_HOME=!java21!"
if "%choice%"=="7" set "JAVA_HOME=!java24!"
if "%choice%"=="8" exit /b
if "%choice%"=="9" goto download_java

:: Validate the selection
if not defined JAVA_HOME (
    echo Invalid option.
    pause
    goto menu
)

:: Update environment variables
setx JAVA_HOME "%JAVA_HOME%" /M
setx PATH "%JAVA_HOME%\bin;%PATH%" /M

:: Apply changes in the current session
set "PATH=%JAVA_HOME%\bin;%PATH%"

echo.
echo Java changed to: %JAVA_HOME%
java -version
pause
goto menu

:download_java
cls
echo Select a Java version to download:
echo.
echo [1] Java 7
echo [2] Java 8
echo [3] Java 11
echo [4] Java 17
echo [5] Java 21
echo [6] Java 24
echo [7] Go back to the main menu
echo.
set /p download_choice=Enter the number of the desired version: 

if "%download_choice%"=="1" set "download_url=!java7_url!"
if "%download_choice%"=="2" set "download_url=!java8_url!"
if "%download_choice%"=="3" set "download_url=!java11_url!"
if "%download_choice%"=="4" set "download_url=!java17_url!"
if "%download_choice%"=="5" set "download_url=!java21_url!"
if "%download_choice%"=="6" set "download_url=!java24_url!"
if "%download_choice%"=="7" goto menu

if not defined download_url (
    echo Invalid option.
    pause
    goto download_java
)

echo Downloading Java, please wait...
powershell -Command "& {Invoke-WebRequest -Uri '%download_url%' -OutFile 'java_installer.exe'}"

echo Download complete! Starting installation...
start /wait java_installer.exe /s

echo Installation finished. You may need to restart your system.
echo.

pause
goto menu