## ADDED Requirements

### Requirement: Cross-platform Installer
The system SHALL provide a single installation script (Bash for Unix-like systems and PowerShell for Windows) to automate the setup of the test generation tool.

#### Scenario: Install on Windows
- **WHEN** the user runs the PowerShell installer script
- **THEN** the system initiates the environment probe and setup process on Windows

#### Scenario: Install on Unix/macOS
- **WHEN** the user runs the Bash installer script
- **THEN** the system initiates the environment probe and setup process on a Unix-like system

### Requirement: Environment Probing
The installer SHALL probe the host system for the presence and versions of Python (3.8+) and Node.js (14+) to determine the best execution strategy.

#### Scenario: Python detected
- **WHEN** Python 3.8 or higher is found on the system
- **THEN** the installer selects the Python-based execution path

#### Scenario: Node.js detected as fallback
- **WHEN** Python is absent but Node.js 14 or higher is found
- **THEN** the installer selects the Node.js-based execution path

### Requirement: Isolated Environment Creation
The installer SHALL create an isolated execution environment (e.g., Python `.venv`) to prevent conflicts with global system packages.

#### Scenario: Create Python venv
- **WHEN** the Python execution path is selected
- **THEN** the installer creates a `.venv` directory within the project and installs `openpyxl` inside it

### Requirement: AI Tool Configuration
The installer SHALL automatically generate command definitions and skill files for Gemini, Claude, and OpenCode based on the user's selection.

#### Scenario: Configure Gemini
- **WHEN** the user selects Gemini during installation
- **THEN** the installer creates `.gemini/commands/brycen/generate_tests.toml` with the correct execution path

### Requirement: Error Reporting
The system SHALL detect installation or execution failures and offer to report them via a pre-populated email.

#### Scenario: Installation failure
- **WHEN** the installer fails to set up an environment
- **THEN** the system prompts the user to report the error and opens their default email client with a `mailto:` link if accepted
