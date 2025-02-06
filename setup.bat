@echo off
setlocal
echo Running Conda environment setup...

:: Get the path of the current script and adjust the path to the create_env.bat file
set "CREATE_ENV_PATH=%~dp0create_env\create_env.bat"

:: Check if the Conda environment already exists
call conda env list | findstr /C:"freecad-stubs-env" >nul
if %ERRORLEVEL% EQU 0 (
    echo Conda environment "freecad-stubs-env" already exists. Skipping creation.
) else (
    echo Calling create_env.bat to create Conda environment...
    call "%CREATE_ENV_PATH%"
    if %ERRORLEVEL% GTR 1 (
        echo ERROR: Failed to create Conda environment.
        exit /b 1
    )
    echo Conda environment created successfully.
)

echo.
echo Activating Conda environment...
call conda.bat activate freecad-stubs-env
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Failed to activate Conda environment.
    exit /b 1
)

:: Short delay to ensure environment variables are available
timeout /t 2 /nobreak >nul

echo Checking Conda environment path...
if "%CONDA_PREFIX%"=="" (
    echo ERROR: Conda environment not detected. Please activate manually and retry.
    exit /b 1
)

echo Creating activation and deactivation scripts...

:: Ensure directories exist
mkdir "%CONDA_PREFIX%\etc\conda\activate.d" 2>nul
mkdir "%CONDA_PREFIX%\etc\conda\deactivate.d" 2>nul

:: Create the activation script (overwrite if it exists)
(
    echo @echo off
    echo set "FREECAD_LIB=%%CONDA_PREFIX%%\Library\lib"
    echo set "FREECAD_BIN=%%CONDA_PREFIX%%\Library\bin"
    echo set "FREECAD_MOD=%%CONDA_PREFIX%%\Library\Mod"
    echo set "FREECAD_SITE_PACKAGES=%%CONDA_PREFIX%%\Lib\site-packages"
    echo set "PYTHONPATH=%%FREECAD_LIB%%;%%FREECAD_BIN%%;%%FREECAD_MOD%%;%%FREECAD_SITE_PACKAGES%%;%%PYTHONPATH%%"
) > "%CONDA_PREFIX%\etc\conda\activate.d\freecad-rc.bat"

:: Create the deactivation script (overwrite if it exists)
(
    echo @echo off
    echo set "FREECAD_LIB="
    echo set "FREECAD_BIN="
    echo set "FREECAD_MOD="
    echo set "FREECAD_SITE_PACKAGES="
    echo set "PYTHONPATH="
) > "%CONDA_PREFIX%\etc\conda\deactivate.d\freecad-rc.bat"

:: Deactivate the Conda environment at the end
echo Deactivating Conda environment...
call conda deactivate

echo.
echo Setup complete.
echo Restart your terminal and run: conda activate freecad-stubs-env && code .

exit /b 0
