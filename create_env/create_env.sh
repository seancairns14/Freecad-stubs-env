#!/bin/bash
echo "Creating the Conda environment..."
conda env create -f "$(dirname "$0")/../freecad-stubs-env.yml"
if [ $? -ne 0 ]; then
    echo "ERROR: Failed to create the Conda environment."
    exit 1
fi

echo "Conda environment created successfully!"
exit 0
