@echo off
setlocal enabledelayedexpansion

set count=0

:main
rem Read a line from stdin
set "line="
set /p line=
if "!line!"=="" goto :eof

rem Skip first two lines (count > 1 means skip lines 0 and 1)
if !count! gtr 1 (
    call :process_line "!line!"
)

set /a count+=1
goto main

:process_line
set "current_line=%~1"

rem Split line into words (space separated)
:split_loop
for /f "tokens=1*" %%a in ("!current_line!") do (
    set "word=%%a"
    set "current_line=%%b"
    
    if not "!word!"=="" (
        call :check_pattern "!word!"
    )
)

if not "!current_line!"=="" goto split_loop
goto :eof

:check_pattern
set "test_word=%~1"

rem Check if word contains at least one dot
echo !test_word! | find "." >nul
if errorlevel 1 goto :eof

rem Count parts and validate each part
set "temp_word=!test_word!"
set part_count=0
set valid=1

:validate_parts
for /f "tokens=1* delims=." %%a in ("!temp_word!") do (
    set /a part_count+=1
    set "part=%%a"
    set "temp_word=%%b"
    
    rem Check if part is 1-3 alphanumeric characters or pipe (|)
    rem First check length (1-3 characters)
    set "len=0"
    :get_length
    if not "!part:~%len%,1!"=="" (
        set /a len+=1
        goto get_length
    )
    
    if !len! lss 1 set valid=0
    if !len! gtr 3 set valid=0
    
    rem Check each character is alphanumeric or pipe
    if !valid! equ 1 (
        for /l %%i in (0,1,!len!) do (
            if not "!part:~%%i,1!"=="" (
                set "char=!part:~%%i,1!"
                rem Check if character is a-z, A-Z, 0-9, or |
                if "!char!" geq "a" if "!char!" leq "z" goto char_ok
                if "!char!" geq "A" if "!char!" leq "Z" goto char_ok
                if "!char!" geq "0" if "!char!" leq "9" goto char_ok
                if "!char!"=="|" goto char_ok
                set valid=0
                :char_ok
            )
        )
    )
    
    if not "!temp_word!"=="" goto validate_parts
)

rem Check if we have 3 or 4 parts
if !part_count! lss 3 set valid=0
if !part_count! gtr 4 set valid=0

rem If we have 4 parts, the 4th part must be only digits (0-9)
if !part_count! equ 4 if !valid! equ 1 (
    rem Extract the 4th part
    set "temp4=!test_word!"
    for /f "tokens=4 delims=." %%a in ("!temp4!") do set "fourth_part=%%a"
    
    rem Check 4th part contains only digits
    set "len4=0"
    :get_length4
    if not "!fourth_part:~%len4%,1!"=="" (
        set /a len4+=1
        goto get_length4
    )
    
    for /l %%i in (0,1,!len4!) do (
        if not "!fourth_part:~%%i,1!"=="" (
            set "char4=!fourth_part:~%%i,1!"
            if "!char4!" lss "0" set valid=0
            if "!char4!" gtr "9" set valid=0
        )
    )
)

if !valid! equ 1 (
    echo %~1
)

goto :eof

