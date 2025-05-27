#!/bin/bash

set -e

# Directory where this script resides
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VENV_DIR="${SCRIPT_DIR}/.venv"

# Create virtual environment if it doesn't exist
if [ ! -d "${VENV_DIR}" ]; then
  echo "Creating virtual environment in ${VENV_DIR}..."
  python3 -m venv "${VENV_DIR}"
fi

# Activate the virtual environment
source "${VENV_DIR}/bin/activate"

# Upgrade pip
pip install --upgrade pip

# Install requirements
echo "Installing requirements..."
pip install -r "${SCRIPT_DIR}/requirements.txt"

# Create local ansible tmp directory
mkdir -p ~/.ansible/tmp
chmod 700 ~/.ansible/tmp

# Print setup message
echo "\nu2705 Environment setup complete."

# Run the Mac-specific test
cd "${SCRIPT_DIR}/roles/file_manager"
echo "\n📱 Running macOS-specific molecule test..."
molecule test -s mac