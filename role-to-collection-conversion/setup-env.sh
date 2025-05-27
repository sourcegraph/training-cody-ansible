#!/bin/bash

set -e

# Directory where this script resides
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VENV_DIR="${SCRIPT_DIR}/.venv"

# Help message
if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
  echo "Usage: $0 [OPTIONS]"
  echo "OPTIONS:"
  echo "  -h, --help     Show this help message"
  echo "  --clean        Remove existing virtual environment and create a new one"
  echo "  --test         After setup, run molecule test for the file_manager role"
  echo "  --macos        Run the macOS-compatible scenario"
  echo ""
  echo "Example: $0 --clean --macos"
  exit 0
fi

# Check if --clean is specified
if [ "$1" == "--clean" ] || [ "$2" == "--clean" ] || [ "$3" == "--clean" ]; then
  echo "Cleaning up existing virtual environment..."
  rm -rf "${VENV_DIR}"
fi

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

# Print success message
echo "\n✅ Virtual environment created and Molecule installed."
echo "To activate the environment, run:"
echo "source ${VENV_DIR}/bin/activate"

# Show installed versions
echo "\nInstalled versions:"
molecule --version
ansible --version

# Check if running on macOS
if [[ "$(uname)" == "Darwin" ]]; then
  echo "\n⚠️  Running on macOS - recommend using the macOS scenario:"
  echo "  molecule test -s macos"
fi

# Run tests if --test option is provided
if [ "$1" == "--test" ] || [ "$2" == "--test" ] || [ "$3" == "--test" ]; then
  echo "\nRunning molecule test for file_manager role..."
  cd "${SCRIPT_DIR}/roles/file_manager"
  
  # Check if --macos is specified or we're on macOS
  if [ "$1" == "--macos" ] || [ "$2" == "--macos" ] || [ "$3" == "--macos" ] || [[ "$(uname)" == "Darwin" ]]; then
    echo "Using macOS-compatible scenario..."
    molecule test -s macos
  else
    molecule test
  fi
fi

echo "\n🔍 To run molecule manually:"
echo "  cd ${SCRIPT_DIR}/roles/file_manager"

if [[ "$(uname)" == "Darwin" ]]; then
  echo "  molecule test -s macos     # Run macOS-compatible test scenario (recommended)"
else
  echo "  molecule test              # Run full test sequence"
fi

echo "  molecule converge         # Just apply the role"
echo "  molecule verify           # Just run verification tests"
echo "  molecule login            # Log into the test container"