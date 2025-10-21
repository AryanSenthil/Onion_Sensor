#!/bin/bash
# Claude Code Project Setup Script
# Run this once when setting up a new project

set -e

echo "Setting up Claude Code project..."

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
# Managed automatically by Claude Code with uv

# Core dependencies will be auto-detected and added here

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

# OS
.DS_Store
Thumbs.db

# Testing
.pytest_cache/
.coverage
htmlcov/

# MyPy
.mypy_cache/

EOF
    
    git add .gitignore
    git commit -m "Initial commit with .gitignore"
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

1. Run the setup script: `./setup_claude.sh`
2. Activate virtual environment: `source .venv/bin/activate`
3. Start coding with Claude Code

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

# Create activation helper script
cat > activate.sh << 'EOF'
#!/bin/bash
source .venv/bin/activate
export CLAUDE_CODE_AUTO_INSTALL=1
echo "Virtual environment activated"
echo "Claude Code will auto-install packages as needed"
EOF

chmod +x activate.sh

echo ""
echo "Setup complete"
echo ""
echo "Next steps:"
echo "  1. Run: source .venv/bin/activate (or ./activate.sh)"
echo "  2. Run: claude code"
echo ""
echo "Claude Code will now:"
echo "  - Auto-detect and install packages"
echo "  - Auto-update requirements.txt"
echo "  - Manage git operations"
echo "  - Run background quality checks"
echo ""
echo "Project structure created:"
echo "  - src/     (main source code)"
echo "  - tests/   (test files)"
echo "  - docs/    (documentation)"
echo "  - draft/   (experimental code)"
echo ""