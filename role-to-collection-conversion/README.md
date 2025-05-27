# Role to Collection Conversion Example

## File Manager Role with Molecule Tests using Podman

This example demonstrates how to set up and run Molecule tests with Podman for Ansible roles.

### Prerequisites

**Required for all platforms:**
1. Podman installed on your system
2. Python 3.9 or higher
3. UV package manager (recommended) or pip

**Platform-specific setup:**

#### macOS Prerequisites
```bash
# Install Podman via Homebrew
brew install podman

# Initialize and start Podman machine
podman machine init
podman machine start

# Verify Podman is working
podman run --rm alpine echo "Hello World"
```

#### Linux Prerequisites
```bash
# Ubuntu/Debian
sudo apt-get update
sudo apt-get install -y podman

# RHEL/CentOS/Fedora
sudo dnf install -y podman

# Verify Podman is working
podman run --rm alpine echo "Hello World"
```

### Quick Start with UV (Recommended)

This project uses UV for fast dependency management:

```bash
# Navigate to the project directory
cd role-to-collection-conversion

# Install dependencies (UV will create virtual environment automatically)
uv sync

# Install Molecule Podman plugin
uv add 'molecule-plugins[podman]'
```

### Platform-Specific Testing Instructions

#### macOS Testing

The `mac` scenario is specifically designed for macOS with Podman:

```bash
# Run the macOS-optimized test scenario
uv run molecule test -s mac
```

This scenario uses:
- Alpine Linux container (lightweight, fast startup)
- Simple `sleep infinity` command (no systemd dependencies)
- Proper temp directory configuration for macOS

#### Linux Testing

For Linux systems, you can use multiple scenarios:

```bash
# Simple Ubuntu-based test (recommended for most Linux systems)
uv run molecule test -s simple

# Full systemd test with Fedora (requires systemd support)
uv run molecule test -s default

# Multi-platform test (tests across multiple distributions)
uv run molecule test -s multi-platform
```

### Alternative Setup (Traditional Virtual Environment)

If you prefer not to use UV:

```bash
# Create and activate virtual environment
python3 -m venv .venv
source .venv/bin/activate  # On Windows: .venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt
pip install 'molecule-plugins[podman]'

# Run tests
molecule test -s mac  # macOS
molecule test -s simple  # Linux
```

### Available Test Scenarios

| Scenario | Platform | Description | Command |
|----------|----------|-------------|---------|
| **mac** | macOS | Alpine-based, optimized for macOS/Podman | `uv run molecule test -s mac` |
| **simple** | Linux/macOS | Ubuntu-based, minimal setup | `uv run molecule test -s simple` |
| **default** | Linux | Fedora with systemd support | `uv run molecule test` |
| **multi-platform** | Linux | Tests multiple distributions | `uv run molecule test -s multi-platform` |
| **macos** | macOS | Alternative macOS configuration | `uv run molecule test -s macos` |

### Troubleshooting

#### Common Issues on macOS

1. **Podman machine not running**:
   ```bash
   podman machine start
   ```

2. **Container creation failures**: Reset Podman machine:
   ```bash
   podman machine stop
   podman machine rm podman-machine-default
   podman machine init
   podman machine start
   ```

3. **Molecule driver errors**: Ensure molecule-plugins is installed:
   ```bash
   uv add 'molecule-plugins[podman]'
   ```

#### Common Issues on Linux

1. **Permission errors**: Ensure your user can run Podman:
   ```bash
   # Add user to podman group (may require logout/login)
   sudo usermod -aG podman $USER
   ```

2. **Systemd issues in containers**: Use the `simple` scenario if systemd fails:
   ```bash
   uv run molecule test -s simple
   ```

3. **SELinux context errors**: Check container logs:
   ```bash
   podman logs <container_name>
   ```

### Validation Commands

Test your setup before running molecule:

```bash
# Verify UV and dependencies
uv --version
uv run molecule --version

# Verify Podman
podman --version
podman machine list  # macOS only

# Test basic container functionality
podman run --rm alpine echo "Podman is working"
```

### Converting to a Collection

This example can be used as a starting point for converting a standalone role to an Ansible Collection. To convert:

1. Create a collection structure
2. Move the role into the collection's roles directory
3. Update the molecule tests to work within the collection context
4. Update namespaces and imports as needed

### References

- [Molecule Documentation](https://molecule.readthedocs.io/)
- [Podman Documentation](https://podman.io/docs/)
- [Ansible Collections Documentation](https://docs.ansible.com/ansible/latest/dev_guide/developing_collections.html)