@echo off
setlocal

echo Running Conda environment setup...

:: Adjust the path to access the parent directory
set "YAML_PATH=%~dp0..\freecad-stubs-env.yml"
:: Normalize path
set "YAML_PATH=%YAML_PATH:\=\\%"

echo Creating Conda environment...
conda env create -f "%YAML_PATH%"
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Failed to create the Conda environment.
    exit /b 1
)

echo.
echo Conda environment created successfully!
exit /b 0
