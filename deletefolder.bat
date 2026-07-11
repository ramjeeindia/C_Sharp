@echo off
title Long Path Force Delete Tool
color 0A

echo ==========================================
echo LONG PATH FORCE DELETE UTILITY
echo ==========================================
echo.

:: Ask user for folder path
set /p target=Enter full folder path to delete:

:: Validate input
if "%target%"=="" (
echo.
echo [ERROR] No path entered!
pause
exit /b
)

echo.
echo You entered: %target%
echo.

:: Confirmation
set /p confirm=Are you sure you want to delete this folder? (Y/N):
if /I not "%confirm%"=="Y" (
echo Operation cancelled.
pause
exit /b
)

echo.
echo Processing...

:: Create temp empty folder
set tempEmpty=%temp%\empty_%random%
mkdir "%tempEmpty%" >nul 2>&1

:: Robocopy mirror (clear contents)
robocopy "%tempEmpty%" "%target%" /mir >nul 2>&1

:: Delete target folder (handles long path)
rd /s /q "\?%target%"

:: Cleanup temp folder
rd /s /q "%tempEmpty%"

echo.
echo [SUCCESS] Folder deleted successfully!
pause