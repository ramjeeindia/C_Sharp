@echo off
COPY TOOL
color 0A

echo ==========================================
echo ROBOCOPY COPY UTILITY
echo ==========================================
echo.

set /p source=Enter SOURCE folder path:
set /p dest=Enter DESTINATION folder path:

if "%source%"=="" (
echo [ERROR] No source entered!
pause
exit /b
)

if "%dest%"=="" (
echo [ERROR] No destination entered!
pause
exit /b
)

echo.
echo Source      : %source%
echo Destination : %dest%
echo.

set /p confirm=Proceed with copy? (Y/N):
if /I not "%confirm%"=="Y" (
echo Operation cancelled.
pause
exit /b
)

echo.
echo Copying...

robocopy "%source%" "%dest%" /E /R:2 /W:2

echo.
echo [SUCCESS] Copy operation completed!
pause