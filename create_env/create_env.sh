#!/bin/bash

echo "Running Conda environment setup..."

# Adjust the path to access the parent directory
YAML_PATH="$(dirname "$0")/../freecad-stubs-env.yml"

# Check if the YAML file exists
if [ ! -f "$YAML_PATH" ]; then
    echo "ERROR: YAML file not found at $YAML_PATH"
    exit 1
fi

echo "Creating Conda environment..."
conda env create -f "$YAML_PATH"

# Check if the Conda environment creation was successful
if [ $? -ne 0 ]; then
    echo "ERROR: Failed to create the Conda environment."
    exit 1
fi

echo "Conda environment created successfully!"
exit 0
