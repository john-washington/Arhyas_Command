@echo off
setlocal enabledelayedexpansion

REM Check arguments
if "%~1"=="" (
    echo Usage: %~nx0 csv_file host
    exit /b 1
)

if "%~2"=="" (
    echo Usage: %~nx0 csv_file host
    exit /b 1
)

set "csv_file=%~1"
set "host=%~2"

REM Function to convert string to hex
:str_to_hex
setlocal
set "str=%~1"
set "hex_result="

REM Check if string is empty
if "!str!"=="" (
    endlocal & set "hex_result="
    goto :eof
)

REM Use PowerShell for hex conversion (more reliable)
echo Converting string to hex...
powershell -Command "[System.BitConverter]::ToString([System.Text.Encoding]::ASCII.GetBytes('%str%')).Replace('-','')" > temp_hex.txt 2>nul

REM Read hex result from file
if exist temp_hex.txt (
    set /p hex_result=<temp_hex.txt
    del temp_hex.txt
)

endlocal & set "hex_result=%hex_result%"
goto :eof

REM Main execution
echo Processing CSV file: %csv_file%
echo Target host: %host%

REM Check if file exists
if not exist "%csv_file%" (
    echo Error: CSV file not found: %csv_file%
    exit /b 1
)

REM Read and process CSV file
set "line_count=0"
for /f "usebackq tokens=1,2 delims=," %%a in ("%csv_file%") do (
    set /a "line_count+=1"
    echo.
    echo [Line !line_count!] Field 1: %%a
    
    REM Convert to hex
    call :str_to_hex "%%a"
    
    echo Hex pattern: %hex_result%
    
    REM Try ping with timeout (using ping's built-in timeout)
    echo Pinging %host%...
    ping -n 1 -w 15000 %host% >nul
    
    REM Check ping result
    if errorlevel 1 (
        echo Ping failed or timed out
    ) else (
        echo Ping successful
    )
    
    REM Random sleep 0-59 seconds
    set /a "sleep_time=%random% %% 60"
    echo Waiting !sleep_time! seconds before next ping...
    
    REM Sleep using timeout command
    if !sleep_time! gtr 0 (
        timeout /t !sleep_time! /nobreak >nul
    )
)

echo.
echo Processed !line_count! lines from CSV
echo Script completed.
exit /b 0

