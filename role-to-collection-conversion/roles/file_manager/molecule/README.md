# Molecule Tests for File Manager Role

This directory contains Molecule tests for the `file_manager` role using Podman as the driver.

## Requirements

To run these tests, you need:

- Molecule (`pip install molecule`)
- Podman (`dnf install podman` or equivalent for your distribution)
- Molecule Podman driver (`pip install molecule-podman`)
- Ansible (`pip install ansible`)

## Running Tests

From the role directory, run:

```bash
molecule test
```

To run a specific test sequence step:

```bash
molecule converge    # Run just the converge step
molecule verify      # Run just the verify step
```

To keep the container running for debugging:

```bash
molecule create      # Create the container
molecule converge    # Run role
molecule login       # Log into the container
```

## Test Scenarios

- **default**: Tests basic functionality of the role with default settings

## Adding New Scenarios

To create a new test scenario, run:

```bash
molecule init scenario -d podman new-scenario-name
```

Then customize the new scenario files as needed.