#!/bin/bash
# Script to add .gitkeep files to a model's folder structure
# Usage: ./add_gitkeep_to_model.sh <model_name>

if [ -z "$1" ]; then
    echo "Usage: ./add_gitkeep_to_model.sh <model_name>"
    exit 1
fi

MODEL_NAME="$1"
MODEL_DIR="models/$MODEL_NAME"

if [ ! -d "$MODEL_DIR" ]; then
    echo "Error: Model directory $MODEL_DIR does not exist"
    exit 1
fi

# Find all directories and add .gitkeep to them
find "$MODEL_DIR" -type d -exec touch {}/.gitkeep \;

echo "✓ Added .gitkeep files to all directories in $MODEL_DIR"
find "$MODEL_DIR" -name .gitkeep | sort
