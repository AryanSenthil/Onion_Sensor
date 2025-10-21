#!/bin/bash
# Codex AI Project Setup Script
# Run this once when setting up a new project

set -e

echo "Setting up Codex AI project..."

# Check Python version
echo "Checking Python 3.10.12..."
if ! command -v python3.10 &> /dev/null; then
    echo "ERROR: Python 3.10 not found. Please install Python 3.10.12"
    exit 1
fi

# Create virtual environment
echo "Creating virtual environment..."
python3.10 -m venv .venv

# Activate virtual environment
echo "Activating virtual environment..."
source .venv/bin/activate

# Upgrade pip and install uv
echo "Installing uv package manager..."
pip install --upgrade pip
pip install uv

# Create requirements.txt if it doesn't exist
if [ ! -f requirements.txt ]; then
    echo "Creating requirements.txt..."
    cat > requirements.txt << 'EOF'
# Python Dependencies
# Managed automatically by Codex AI with uv

# Package Manager
uv>=0.1.0

# Code Quality Tools
black>=23.0.0
ruff>=0.1.0
mypy>=1.0.0

# Testing
pytest>=7.0.0
pytest-cov>=4.0.0

# Codex AI specific tools
jupyter>=1.0.0
notebook>=6.0.0
ipykernel>=6.0.0

# Project dependencies will be auto-detected and added below

EOF
fi

# Install existing requirements
if [ -f requirements.txt ] && [ -s requirements.txt ]; then
    echo "Installing dependencies with uv..."
    uv pip install -r requirements.txt
fi

# Initialize git if not already initialized
if [ ! -d .git ]; then
    echo "Initializing git repository..."
    git init
    
    # Create .gitignore
    cat > .gitignore << 'EOF'
# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
*.egg-info/
.installed.cfg
*.egg

# Virtual Environment
.venv/
venv/
ENV/
env/

# IDEs
.vscode/
.idea/
*.swp
*.swo
*~
.cursor/

# Jupyter Notebook
.ipynb_checkpoints
*/.ipynb_checkpoints/*

# OS
.DS_Store
Thumbs.db

# Testing
.pytest_cache/
.coverage
htmlcov/

# MyPy
.mypy_cache/

# Environment variables
.env
.env.local
.env.*.local

EOF
    
    git add .gitignore
    git commit -m "Initial commit with .gitignore"
fi

# Create CHANGELOG.md if it doesn't exist
if [ ! -f CHANGELOG.md ]; then
    echo "Creating CHANGELOG.md..."
    TODAY=$(date +%Y-%m-%d)
    cat > CHANGELOG.md << EOF
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial project setup with Python 3.10.12
- Virtual environment configuration (.venv)
- UV package manager integration
- Automated dependency management
- Git repository initialization
- Code quality tools (black, ruff, mypy)
- Testing framework (pytest)
- Jupyter notebook support for Codex AI

---

## [0.1.0] - $TODAY

### Added
- Project initialization
EOF
fi

# Create project structure
echo "Creating project structure..."
mkdir -p src
mkdir -p tests
mkdir -p docs
mkdir -p draft

# Create __init__.py files for proper Python packages
touch src/__init__.py
touch tests/__init__.py

# Create basic README.md if it doesn't exist
if [ ! -f README.md ]; then
    echo "Creating README.md..."
    cat > README.md << 'EOF'
# Project Name

Brief description of the project.

## Setup

1. Run the setup script: `./setup_codex.sh`
2. Activate virtual environment: `source .venv/bin/activate`
3. Open project in your preferred IDE with Codex AI

## Project Structure

```
project/
├── .venv/                 # Virtual environment
├── src/                   # Main source code
├── tests/                 # Test files
├── docs/                  # Documentation
├── draft/                 # Draft/experimental code
├── requirements.txt       # Dependencies
├── .gitignore            # Git ignore rules
├── .cursorrules          # AI assistant rules
├── CHANGELOG.md          # Change log
└── README.md             # This file
```

## Development

- Source code goes in `src/`
- Tests go in `tests/`
- Documentation goes in `docs/`
- Draft/experimental code goes in `draft/`
EOF
fi

# Create .cursorrules if it doesn't exist
if [ ! -f .cursorrules ]; then
    echo "Creating .cursorrules..."
    echo "NOTE: Copy the .cursorrules file content to this location"
fi

# Create activation helper script
cat > activate.sh << 'EOF'
#!/bin/bash
source .venv/bin/activate
export CODEX_AUTO_INSTALL=1
echo "Virtual environment activated"
echo "Codex AI will auto-install packages as needed"
EOF

chmod +x activate.sh

# Note: Project structure (src/, tests/, docs/) should be created manually by the user
# README.md should be written by the user to describe their specific project

echo ""
echo "Setup complete"
echo ""
echo "Next steps:"
echo "  1. Run: source .venv/bin/activate (or ./activate.sh)"
echo "  2. Open project in your preferred IDE with Codex AI"
echo "  3. Start coding - Codex AI will handle the rest"
echo ""
echo "Codex AI will now:"
echo "  - Auto-detect and install packages"
echo "  - Auto-update requirements.txt"
echo "  - Auto-update CHANGELOG.md"
echo "  - Manage git operations"
echo "  - Run code quality checks"
echo "  - Support Jupyter notebooks"
echo ""
echo "Project structure created:"
echo "  - src/     (main source code)"
echo "  - tests/   (test files)"
echo "  - docs/    (documentation)"
echo "  - draft/   (experimental code)"
echo ""
