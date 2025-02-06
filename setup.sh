#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

echo "Running Conda environment setup..."

# Ensure Conda is available
if ! command -v conda &>/dev/null; then
    echo "ERROR: Conda is not installed or not in PATH."
    exit 1
fi

# Source Conda shell functions to ensure 'conda activate' works
eval "$(conda info --base)/etc/profile.d/conda.sh"

# Get the path of the current script and adjust the path to create_env.sh
CREATE_ENV_PATH="$(dirname "$0")/create_env/create_env.sh"

# Check if the Conda environment already exists
if conda env list | grep -q "^freecad-stubs-env\s"; then
    echo "Conda environment 'freecad-stubs-env' already exists. Skipping creation."
else
    echo "Calling create_env.sh to create Conda environment..."
    if ! bash "$CREATE_ENV_PATH"; then
        echo "ERROR: Failed to create Conda environment."
        exit 1
    fi
fi

echo "Conda environment setup completed successfully!"

# Activate Conda environment
echo "Activating Conda environment..."
conda activate freecad-stubs-env

# Short delay to ensure environment variables are available
sleep 2

# Checking Conda environment path
if [ -z "$CONDA_PREFIX" ]; then
    echo "ERROR: Conda environment not detected. Please activate manually and retry."
    exit 1
fi

echo "Creating activation and deactivation scripts..."

# Ensure directories exist
mkdir -p "$CONDA_PREFIX/etc/conda/activate.d"
mkdir -p "$CONDA_PREFIX/etc/conda/deactivate.d"

# Get Python version in the environment
PYTHON_VERSION=$(python -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")')

# Create the activation script (overwrite if it exists)
cat << EOF > "$CONDA_PREFIX/etc/conda/activate.d/freecad-rc.sh"
#!/bin/bash
export FREECAD_LIB="\$CONDA_PREFIX/lib"
export FREECAD_BIN="\$CONDA_PREFIX/bin"
export FREECAD_MOD="\$CONDA_PREFIX/Mod"
export FREECAD_SITE_PACKAGES="\$CONDA_PREFIX/lib/python$PYTHON_VERSION/site-packages"
export PYTHONPATH="\$FREECAD_LIB:\$FREECAD_BIN:\$FREECAD_MOD:\$FREECAD_SITE_PACKAGES:\$PYTHONPATH"
EOF

# Create the deactivation script (overwrite if it exists)
cat << EOF > "$CONDA_PREFIX/etc/conda/deactivate.d/freecad-rc.sh"
#!/bin/bash
unset FREECAD_LIB
unset FREECAD_BIN
unset FREECAD_MOD
unset FREECAD_SITE_PACKAGES
unset PYTHONPATH
EOF

# Make scripts executable
chmod +x "$CONDA_PREFIX/etc/conda/activate.d/freecad-rc.sh"
chmod +x "$CONDA_PREFIX/etc/conda/deactivate.d/freecad-rc.sh"

# Deactivate the Conda environment at the end
echo "Deactivating Conda environment..."
conda deactivate

echo "Setup complete."
echo "Restart your terminal and run: conda activate freecad-stubs-env && code ."

exit 0
