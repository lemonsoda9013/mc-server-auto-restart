@echo off

:start
del temp_output.log
setlocal enabledelayedexpansion
set TARGET_STRING=[Server thread/INFO]: Deleting world files
set JAR_PATH=server.jar
set PORT=25565
echo Target string is '%TARGET_STRING%'
echo Target port is %PORT%
set PID=

:start_jar
(
  echo off
  >nul 2>nul (
    start /B java -Xms2G -Xmx4G -jar %JAR_PATH% > temp_output.log 2>&1
  )
) || (
  echo Waiting for the file to be available...
  timeout /t 2 /nobreak >nul
  goto start_jar
)

:loop
timeout /T 4 >nul
for /f "tokens=5" %%a in ('netstat -ano ^| findstr :%PORT%') do (
    for /f "tokens=1,*" %%b in ('tasklist /FI "PID eq %%a" /FO CSV /NH ^| findstr /i "java"') do (
        set PID=%%a
        echo The server opened on port %PORT% with pid !PID!
        goto check_output
    )
)
echo The server is starting...
goto loop

:check_output
findstr /C:"%TARGET_STRING%" temp_output.log >nul
if %ERRORLEVEL% equ 0 (
    echo Found target string: %TARGET_STRING%
    goto end
)
timeout /T 2 /NOBREAK >nul
goto check_output

:end
taskkill /PID !PID! /T /F
timeout /T 1 >nul
echo --------
echo The server will restart in 4 seconds, press ctrl+c or close this window to cancel!
timeout /T 4
endlocal
goto start