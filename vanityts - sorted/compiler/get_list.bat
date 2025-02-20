@echo off
setlocal enabledelayedexpansion


echo.
echo =====================================
echo          GSC File Lister 1.0.0
echo            by mollyinduced
echo            mdma.rip/discord
echo =====================================
echo.

rem Set the input directory relative to script location
set "INPUT_DIR=..\project"
set "LIST_FILE=order.txt"

rem If files_list.txt exists, delete it first
if exist "%LIST_FILE%" (
    del "%LIST_FILE%"
)

echo Checking for main.gsc and other .gsc files in:
echo %INPUT_DIR%
echo.

rem Change into the INPUT_DIR so that dir commands pick up .gsc files in that folder
pushd "%INPUT_DIR%" || (
    echo ERROR: Failed to enter directory %INPUT_DIR%.
    pause
    exit /b 1
)

rem 1) If main.gsc is found, write it first
if exist "main.gsc" (
    echo Found main.gsc. Placing it at the top of the list.
    echo main.gsc > "%~dp0%LIST_FILE%"
) else (
    echo No main.gsc found.
    echo. > "%~dp0%LIST_FILE%"
)

rem 2) Then list all .gsc files in alphabetical order, excluding main.gsc
for /f "delims=" %%A in ('dir /b /on *.gsc') do (
    if /I not "%%~A"=="main.gsc" (
        echo %%~A >> "%~dp0%LIST_FILE%"
    )
)

rem Return to the original directory
popd

echo.
echo File list saved to: %LIST_FILE%

rem 3) Copy file content to clipboard
type "%LIST_FILE%" | clip

echo File list copied to clipboard.
echo.
echo =====================================
echo Done!
echo =====================================
pause
