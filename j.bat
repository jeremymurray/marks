@echo off
if ("%~1") == ("") if not exist "%~dp0marks\_current_drive.markref" echo Please specify mark name.&&call "%~dp0marks.bat"&&exit /b 1
if ("%~1") == ("") for /F "usebackq delims=" %%i in ("%~dp0marks\_current_dir.markref") do (if not "%%i" == "%CD%" if exist "%%i" (for /F "usebackq delims=" %%j in ("%~dp0marks\_current_drive.markref") do echo %CD%>"%~dp0marks\_last_dir.markref"&&echo %CD:~0,2%>"%~dp0marks\_last_drive.markref"&&%%j&&cd "%%i"&&exit /b 0) else (echo Jump destination does not exist: %%i&&exit /b 1))
if ("%~1") == ("") for /F "usebackq delims=" %%i in ("%~dp0marks\_last_dir.markref") do (if exist "%%i" (for /F "usebackq delims=" %%j in ("%~dp0marks\_last_drive.markref") do %%j && cd "%%i"&&exit /b 0) else (echo Jump destination does not exist: %%i&&exit /b 1))
for /f "delims=*+,/:;<=>?\[]|" %%a in ("%~1") do if not ("%%~a") == ("%~1") echo Please do not use special characters in the mark name.&&exit /b 1
if not exist "%~dp0marks\%~1.mark" echo Mark does not exist: %~1&&exit /b 1
for /F "usebackq delims=" %%i in ("%~dp0marks\%~1.mark") do if exist "%%i" (echo %CD%>"%~dp0marks\_last_dir.markref"&&echo %CD:~0,2%>"%~dp0marks\_last_drive.markref"&&%%~di && cd "%%i"&&echo %%~di>"%~dp0marks\_current_drive.markref"&&echo %%i>"%~dp0marks\_current_dir.markref") else (echo Jump destination does not exist: %%i)
