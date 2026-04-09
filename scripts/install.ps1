# .brycen Test Generator Installer (Windows)

$BASE_URL = "https://raw.githubusercontent.com/WinThiha/brycen-testgen/main"
$EMAIL = "your.email@example.com"
$VENV_DIR = ".brycen/env"
$SCRIPTS_DIR = ".brycen/scripts"
$TEMPLATES_DIR = ".brycen/templates"

function Report-Error($message) {
    Write-Host "`n[ERROR] $message" -ForegroundColor Red
    $choice = Read-Host "`nAn error occurred. Would you like to report this issue to the maintainer? (y/N)"
    if ($choice -eq 'y' -or $choice -eq 'Y') {
        $subject = [System.Web.HttpUtility]::UrlEncode("Brycen TestGen Error")
        $body = [System.Web.HttpUtility]::UrlEncode("Error: $message`n`nSystem: Windows`nPython version: $(python --version 2>&1)")
        Start-Process "mailto:$EMAIL?subject=$subject&body=$body"
    }
    exit 1
}

function Fetch-File($remotePath, $localPath) {
    Write-Host "  Fetching $localPath..."
    $dir = Split-Path $localPath
    if (-Not (Test-Path $dir)) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }
    try {
        Invoke-WebRequest -Uri "$BASE_URL/$remotePath" -OutFile $localPath -UseBasicParsing
    } catch {
        Report-Error "Failed to download $remotePath from $BASE_URL"
    }
}

# 1. AI Assistant Selection
Write-Host "`n=== Brycen Test Generator Setup ==="

# 2. Probe for Python
Write-Host "`n[1/4] Probing for Python 3.8+..."
try {
    $pyVersion = python --version 2>&1
    if ($pyVersion -match "Python (3\.(8|9|1[0-9]))") {
        Write-Host "Found $pyVersion" -ForegroundColor Green
    } else {
        Report-Error "Python 3.8+ not found or not in PATH. Found: $pyVersion"
    }
} catch {
    Report-Error "Python is not installed or not in PATH."
}

# 3. Create Isolated Environment
Write-Host "`n[2/4] Creating isolated environment in $VENV_DIR..."
if (-Not (Test-Path $VENV_DIR)) {
    try {
        python -m venv $VENV_DIR
        Write-Host "Created virtual environment." -ForegroundColor Green
    } catch {
        Report-Error "Failed to create virtual environment."
    }
} else {
    Write-Host "Virtual environment already exists."
}

# 4. Install Dependencies
Write-Host "`n[3/4] Installing dependencies (openpyxl)..."
try {
    & "$VENV_DIR\Scripts\pip.exe" install openpyxl
    Write-Host "Dependencies installed successfully." -ForegroundColor Green
} catch {
    Report-Error "Failed to install dependencies."
}

# 5. AI Assistant Configuration (Remote Fetching)
Write-Host "`n[4/4] Configuring AI assistants (Fetching from Hub)..."

# Fetch Core Engine
Fetch-File ".brycen/scripts/opsx-testgen.py" ".brycen/scripts/opsx-testgen.py"
Fetch-File ".brycen/templates/Test Case - Function.xlsx" ".brycen/templates/Test Case - Function.xlsx"
Fetch-File "VERSION" ".brycen/VERSION"

# Smart AI Detection
if (Test-Path ".gemini") {
    Write-Host "Detected Gemini CLI. Installing commands and skills..."
    Fetch-File ".gemini/commands/brycen/generate_tests.toml" ".gemini/commands/brycen/generate_tests.toml"
    Fetch-File ".gemini/skills/brycen-generate_tests/SKILL.md" ".gemini/skills/brycen-generate_tests/SKILL.md"
    Fetch-File ".gemini/commands/brycen/update.toml" ".gemini/commands/brycen/update.toml"
    Fetch-File ".gemini/skills/brycen-update/SKILL.md" ".gemini/skills/brycen-update/SKILL.md"
    Fetch-File ".gemini/commands/brycen/clean_up.toml" ".gemini/commands/brycen/clean_up.toml"
    Fetch-File ".gemini/skills/brycen-clean_up/SKILL.md" ".gemini/skills/brycen-clean_up/SKILL.md"
}

if (Test-Path ".claude") {
    Write-Host "Detected Claude CLI. Installing commands and skills..."
    Fetch-File ".claude/commands/brycen/generate_tests.md" ".claude/commands/brycen/generate_tests.md"
    Fetch-File ".claude/skills/brycen-generate_tests/SKILL.md" ".claude/skills/brycen-generate_tests/SKILL.md"
    Fetch-File ".claude/commands/brycen/update.md" ".claude/commands/brycen/update.md"
    Fetch-File ".claude/skills/brycen-update/SKILL.md" ".claude/skills/brycen-update/SKILL.md"
    Fetch-File ".claude/commands/brycen/clean_up.md" ".claude/commands/brycen/clean_up.md"
    Fetch-File ".claude/skills/brycen-clean_up/SKILL.md" ".claude/skills/brycen-clean_up/SKILL.md"
}

if (Test-Path ".opencode") {
    Write-Host "Detected OpenCode CLI. Installing commands and skills..."
    Fetch-File ".opencode/command/brycen-generate_tests.md" ".opencode/command/brycen-generate_tests.md"
    Fetch-File ".opencode/skills/brycen-generate_tests/SKILL.md" ".opencode/skills/brycen-generate_tests/SKILL.md"
    Fetch-File ".opencode/command/brycen-update.md" ".opencode/command/brycen-update.md"
    Fetch-File ".opencode/skills/brycen-update/SKILL.md" ".opencode/skills/brycen-update/SKILL.md"
    Fetch-File ".opencode/command/brycen-clean_up.md" ".opencode/command/brycen-clean_up.md"
    Fetch-File ".opencode/skills/brycen-clean_up/SKILL.md" ".opencode/skills/brycen-clean_up/SKILL.md"
}

Write-Host "`n=== Installation Complete! ===" -ForegroundColor Green
Write-Host "You can now use /brycen:generate_tests in this project."
