@echo off
call "%VS140COMNTOOLS%\vsvars32.bat"

set SOURCE_DIR=.\\src
set DEST_DIR=.\\
set PACKAGE_NAME=edge.echo.appx
set CERTIFICATE=.\\temporary.pfx

:loop
if not "%1"=="" (
    if "%1"=="-source_dir" (
        set SOURCE_DIR=%2
        shift
    ) else if "%1"=="-dest_dir" (
        set DEST_DIR=%2
        shift
    ) else if "%1"=="-package_name" (
        set PACKAGE_NAME=%2
        shift
    ) else if "%1"=="-certificate" (
        set CERTIFICATE=%2
        shift
    ) else (
        @echo Unknown parameter: %1
        exit 1
    )
    shift
    goto :loop
)

@echo Source directory: %SOURCE_DIR%
@echo Destination directory: %DEST_DIR%
@echo Package name: %PACKAGE_NAME%
@echo Certificate: %CERTIFICATE%

if not exist %DEST_DIR% mkdir %DEST_DIR%

makeappx.exe pack /h SHA256 /d %SOURCE_DIR% /o /p %DEST_DIR%\%PACKAGE_NAME%

if ERRORLEVEL 1 (
  @echo Failed to makeappx
  goto :error
)

SignTool.exe sign /fd SHA256 /a /f %CERTIFICATE% %DEST_DIR%\%PACKAGE_NAME%

if ERRORLEVEL 1 (
  @echo Failed to sign appx
  goto :error
)

@echo Extension build successfully completed
exit 0

:error
del %DEST_DIR%\%PACKAGE_NAME%
exit 1
