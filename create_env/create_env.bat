@echo off
setlocal

echo Creating the Conda environment...
conda env create -f "%~dp0..\freecad-stubs-env.yml"
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Failed to create the Conda environment.
    exit /b 1
)

echo.
echo Conda environment created successfully!
exit /b 0
