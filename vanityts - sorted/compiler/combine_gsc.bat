@echo off
setlocal enabledelayedexpansion

echo =====================================
echo        GSC File Compiler v1.0.0
echo            by mollyinduced
echo            mdma.rip/discord
echo =====================================
echo.

rem Set directories
set "INPUT_DIR=..\project"
set "OUTPUT_FILE=..\vanityts_sorted.gsc"  rem Output file outside compiler and project

rem Clear output file if it exists
if exist "%OUTPUT_FILE%" (
    echo Removing existing output file: %OUTPUT_FILE%
    del "%OUTPUT_FILE%"
)

rem Check if order.txt exists and get file order
set "FILES="

if exist "order.txt" (
    echo Reading file order from order.txt...
    for /f "tokens=*" %%A in (order.txt) do (
        set "FILENAME=%%A"
        set "FILENAME=!FILENAME: =!"  rem Remove spaces
        set "EXPECTED_PATH=%INPUT_DIR%\!FILENAME!"
        
        echo Checking: "!EXPECTED_PATH!"
        if exist "!EXPECTED_PATH!" (
            echo FOUND: !EXPECTED_PATH!
            set "FILES=!FILES! !FILENAME!"
        ) else (
            echo ERROR: !EXPECTED_PATH! not found!
        )
    )
) else (
    echo No order.txt found, processing files in alphabetical order...
    for %%A in ("%INPUT_DIR%\*.gsc") do (
        set "FILES=!FILES! %%~nxA"
    )
)

echo.
echo Processing files...
echo --------------------

rem Process each file
for %%F in (!FILES!) do (
    set "FILE_PATH=%INPUT_DIR%\%%F"

    if exist "!FILE_PATH!" (
        if /I "%%F"=="main.gsc" (
            echo Processing: %%F
            echo Full Path: !FILE_PATH!
            echo Skipping main.gsc
            
            rem Generate a centered header
            set "HEADER=///////// "
            set "SPACER=            "
            set "SPACERR=                                    "
            set "FILENAME_PADDED= %%F "
            set "HEADER=!HEADER!!SPACER!!FILENAME_PADDED!!SPACERR!!HEADER!"
            
            echo //////////////////////////////////////////////////////////////////////////////////////// >> "%OUTPUT_FILE%"
            echo //////////////////////////////////////////////////////////////////////////////////////// >> "%OUTPUT_FILE%"
            echo !HEADER! >> "%OUTPUT_FILE%"
            echo //////////////////////////////////////////////////////////////////////////////////////// >> "%OUTPUT_FILE%"
            echo //////////////////////////////////////////////////////////////////////////////////////// >> "%OUTPUT_FILE%"
            echo. >> "%OUTPUT_FILE%"
            
            rem Append file content
            type "!FILE_PATH!" >> "%OUTPUT_FILE%"
        ) else (
            echo Processing: %%F
            echo Full Path: !FILE_PATH!
            
            rem Generate a centered header
            set "HEADER=///////// "
            set "SPACER=            "
            set "SPACERR=                                    "
            set "FILENAME_PADDED= %%F "
            set "HEADER=!HEADER!!SPACER!!FILENAME_PADDED!!SPACERR!!HEADER!"
            
            echo. >> "%OUTPUT_FILE%"
            echo. >> "%OUTPUT_FILE%"
            echo //////////////////////////////////////////////////////////////////////////////////////// >> "%OUTPUT_FILE%"
            echo //////////////////////////////////////////////////////////////////////////////////////// >> "%OUTPUT_FILE%"
            echo !HEADER! >> "%OUTPUT_FILE%"
            echo //////////////////////////////////////////////////////////////////////////////////////// >> "%OUTPUT_FILE%"
            echo //////////////////////////////////////////////////////////////////////////////////////// >> "%OUTPUT_FILE%"
            echo. >> "%OUTPUT_FILE%"
            echo. >> "%OUTPUT_FILE%"
            
            rem Append file content
            type "!FILE_PATH!" >> "%OUTPUT_FILE%"
        )
    ) else (
        echo ERROR: %%F not found!
    )
)

echo.
echo =====================================
echo GSC files successfully combined into:
echo %OUTPUT_FILE%
echo =====================================
pause
