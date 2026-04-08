#!/bin/bash

# .brycen Test Generator Installer (Unix/macOS)

BASE_URL="https://raw.githubusercontent.com/WinThiha/brycen-testgen/main"
EMAIL="your.email@example.com"
VENV_DIR=".brycen/env"

report_error() {
    echo -e "\n[ERROR] $1"
    read -p "An error occurred. Would you like to report this issue to the maintainer? (y/N) " choice
    if [[ "$choice" =~ ^[Yy]$ ]]; then
        # Check for jq, fallback to simple string if missing
        if command -v jq &>/dev/null; then
            subject=$(printf "Brycen TestGen Error" | jq -sRr @uri)
            body=$(printf "Error: $1\n\nSystem: Unix/macOS\nPython version: $(python3 --version 2>&1)" | jq -sRr @uri)
        else
            subject="Brycen%20TestGen%20Error"
            body="Error:%20$1"
        fi
        open "mailto:$EMAIL?subject=$subject&body=$body"
    fi
    exit 1
}

fetch_file() {
    echo "  Fetching $2..."
    mkdir -p "$(dirname "$2")"
    if ! curl -sSL "$BASE_URL/$1" -o "$2"; then
        report_error "Failed to download $1 from $BASE_URL"
    fi
}

# 1. AI Assistant Selection
echo -e "\n=== Brycen Test Generator Setup ==="

# 2. Probe for Python
echo -e "\n[1/4] Probing for Python 3.8+..."
if command -v python3 &>/dev/null; then
    py_version=$(python3 --version)
    if [[ "$py_version" =~ Python\ 3\.([89]|1[0-9]) ]]; then
        echo "Found $py_version"
    else
        report_error "Python 3.8+ not found. Found: $py_version"
    fi
else
    report_error "Python 3 is not installed or not in PATH."
fi

# 3. Create Isolated Environment
echo -e "\n[2/4] Creating isolated environment in $VENV_DIR..."
if [ ! -d "$VENV_DIR" ]; then
    python3 -m venv "$VENV_DIR" || report_error "Failed to create virtual environment."
    echo "Created virtual environment."
else
    echo "Virtual environment already exists."
fi

# 4. Install Dependencies
echo -e "\n[3/4] Installing dependencies (openpyxl)..."
"$VENV_DIR/bin/pip" install openpyxl || report_error "Failed to install dependencies."
echo "Dependencies installed successfully."

# 5. AI Assistant Configuration (Remote Fetching)
echo -e "\n[4/4] Configuring AI assistants (Fetching from Hub)..."

# Fetch Core Engine
fetch_file ".brycen/scripts/opsx-testgen.py" ".brycen/scripts/opsx-testgen.py"
fetch_file ".brycen/templates/Test Case - Function.xlsx" ".brycen/templates/Test Case - Function.xlsx"

# Smart AI Detection
if [ -d ".gemini" ]; then
    echo "Detected Gemini CLI. Installing commands and skills..."
    fetch_file ".gemini/commands/brycen/generate_tests.toml" ".gemini/commands/brycen/generate_tests.toml"
    fetch_file ".gemini/skills/brycen-generate_tests/SKILL.md" ".gemini/skills/brycen-generate_tests/SKILL.md"
fi

if [ -d ".claude" ]; then
    echo "Detected Claude CLI. Installing commands and skills..."
    fetch_file ".claude/commands/brycen/generate_tests.md" ".claude/commands/brycen/generate_tests.md"
    fetch_file ".claude/skills/brycen-generate_tests/SKILL.md" ".claude/skills/brycen-generate_tests/SKILL.md"
fi

if [ -d ".opencode" ]; then
    echo "Detected OpenCode CLI. Installing commands and skills..."
    fetch_file ".opencode/command/brycen-generate_tests.md" ".opencode/command/brycen-generate_tests.md"
    fetch_file ".opencode/skills/brycen-generate_tests/SKILL.md" ".opencode/skills/brycen-generate_tests/SKILL.md"
fi

echo -e "\n=== Installation Complete! ==="
echo "You can now use /brycen:generate_tests in this project."
