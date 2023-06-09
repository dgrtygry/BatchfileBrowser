@echo off
cls
echo Welcome to TickBrowser! What would you like to do? 1. Load a webpage! 2. View bookmarks. 3. Exit. 4. About.
goto MainLoop
set /p input=
if input == 1 goto RetrievePageContent
if input == 2 goto DisplayBookmarks
if input == 3 exit
if input == 4 goto DisplayAbout

REM Function to retrieve page content using curl
:RetrievePageContent
set "URL="%URL%"
curl -s "%URL%" -o temp.html
wget -s "%URL%" -o temp.html
set "PAGE_CONTENT="
for /f "usebackq delims=" %%a in ("temp.html") do (
    set "PAGE_CONTENT=!PAGE_CONTENT!%%a"
)
del temp.html
goto :DisplayPageContent

REM Function to display page content
:DisplayPageContent
echo.
echo !PAGE_CONTENT!
echo.
goto MainLoop

REM Function to save bookmark
:SaveBookmark
set "URL=%~1"
echo %URL% >> bookmarks.txt
echo Bookmark saved: %URL%
goto :MainLoop

REM Function to display bookmarks
:DisplayBookmarks
echo.
echo === Bookmarks ===
echo.
type bookmarks.txt
echo.
goto :MainLoop

REM Function to display about information
:DisplayAbout
echo.
echo Copyright 2015-2023 Tick Studios TickBrowser
echo.
goto :MainLoop

REM Main loop
:MainLoop
cls
echo.
echo === Simple Batch Browser ===
echo.

REM Toolbar
echo =================================
echo 1. Retrieve page content
echo 2. Display page content
echo 3. Save bookmark
echo 4. Display bookmarks
echo 5. About
echo 6. Exit
echo =================================

echo.
set /p "CHOICE=Enter your choice (1-6): "

if "%CHOICE%"=="1" (
    set /p "URL=Enter URL: "
    call :RetrievePageContent "%URL%"
    pause
    goto MainLoop
) else if "%CHOICE%"=="2" (
    goto :DisplayPageContent
    pause
    goto MainLoop
) else if "%CHOICE%"=="3" (
    set /p "URL=Enter URL to bookmark: "
    goto :SaveBookmark "%URL%"
    pause
    goto MainLoop
) else if "%CHOICE%"=="4" (
    goto :DisplayBookmarks
    pause
    goto MainLoop
) else if "%CHOICE%"=="5" (
    goto :DisplayAbout
    pause
    goto MainLoop
) else if "%CHOICE%"=="6" (
    exit /b
) else (
    echo Invalid choice.
    pause
    goto MainLoop
)
