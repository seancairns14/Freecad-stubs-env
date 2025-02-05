#!/bin/bash
echo "Running Conda environment setup..."

# Check if the Conda environment already exists
if conda env list | grep -q "freecad-stubs-env"; then
    echo "Conda environment 'freecad-stubs-env' already exists. Skipping creation."
else
    echo "Creating Conda environment..."
    bash create_env/create_env.sh
    if [ $? -ne 0 ]; then
        echo "ERROR: Failed to create Conda environment."
        exit 1
    fi
fi

echo "Activating Conda environment..."
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate freecad-stubs-env
if [ $? -ne 0 ]; then
    echo "ERROR: Failed to activate Conda environment."
    exit 1
fi

echo "Checking Conda environment path..."
if [ -z "$CONDA_PREFIX" ]; then
    echo "ERROR: Conda environment not detected. Please activate manually and retry."
    exit 1
fi

echo "Creating activation and deactivation scripts..."

# Ensure directories exist
mkdir -p "$CONDA_PREFIX/etc/conda/activate.d"
mkdir -p "$CONDA_PREFIX/etc/conda/deactivate.d"

# Create the activation script (overwrite if it exists)
cat > "$CONDA_PREFIX/etc/conda/activate.d/freecad-rc.sh" <<EOL
#!/bin/bash
export FREECAD_LIB="\$CONDA_PREFIX/Library/lib"
export FREECAD_BIN="\$CONDA_PREFIX/Library/bin"
export FREECAD_MOD="\$CONDA_PREFIX/Library/Mod"
export FREECAD_SITE_PACKAGES="\$CONDA_PREFIX/Lib/site-packages"
export PYTHONPATH="\$FREECAD_LIB:\$FREECAD_BIN:\$FREECAD_MOD:\$FREECAD_SITE_PACKAGES:\$PYTHONPATH"
EOL

# Create the deactivation script (overwrite if it exists)
cat > "$CONDA_PREFIX/etc/conda/deactivate.d/freecad-rc.sh" <<EOL
#!/bin/bash
unset FREECAD_LIB
unset FREECAD_BIN
unset FREECAD_MOD
unset FREECAD_SITE_PACKAGES
unset PYTHONPATH
EOL

echo "Deactivating Conda environment..."
conda deactivate

echo "Setup complete."
echo "Restart your terminal and run: conda activate freecad-stubs-env && code ."
exit 0
