## Context

The current test case generation tool relies on a Python script (`opsx-testgen.py`) and specific directory structures within the project template. Manually copying these to new projects requires significant effort and risks environment conflicts. This design aims to make the tool a "drop-in" capability for any project.

## Goals / Non-Goals

**Goals:**
- **Automated Installation**: Create a single, cross-platform installer script.
- **Dependency Isolation**: Use Python virtual environments (`.venv`) or `npx` to keep the user's system clean.
- **Multi-AI Support**: Automatically configure Gemini, Claude, and OpenCode with the correct command definitions and skills.
- **Personalized Branding**: Transition to the `/brycen` namespace.
- **Easy Reporting**: Provide a simple way for users to report failures without infrastructure overhead.

**Non-Goals:**
- Developing a full-fledged CLI manager (e.g., a "brycen" CLI tool installed in the system PATH).
- Supporting legacy AI tool versions.
- Automating the installation of Python or Node.js themselves; the tool will require one of these to be pre-installed.

## Decisions

### 1. Smart Installer Strategy (Environment Probe)
- **Decision**: The installer will be a Shell (Bash/PowerShell) script that probes for Python first, then Node.js.
- **Rationale**: Python is already the implementation language of the script, so it's the natural primary path. Node.js/npm is the most robust way to distribute CLI tools to web developers.
- **Alternatives**: 
  - *Distribute as a single binary (PyInstaller)*: Rejected due to large file sizes (10MB+) and the need for per-OS builds.
  - *Strictly Node.js*: Rejected because the current script is already functional in Python; we can add Node.js as a fallback later.

### 2. Isolated Execution Environments
- **Decision**: Force the use of project-local virtual environments (`.venv`) for Python.
- **Rationale**: Prevents breaking the user's global Python environment or other projects. `pip install --user` is less isolated and harder to manage.

### 3. Command Namespacing
- **Decision**: Move from `/opsx:test` to `/brycen:generate_tests`.
- **Rationale**: Avoids collisions with other "opsx" tools and provides a unique brand for this specific test generator.

### 4. Error Reporting via `mailto:`
- **Decision**: Use the `mailto:` protocol to launch the user's default email client with pre-filled error logs.
- **Rationale**: Most secure way to handle feedback without requiring a backend server or exposing private API keys in the client-side scripts.

## Risks / Trade-offs

- **[Risk] Shell Script Portability** → **[Mitigation]** Maintain two versions of the installer (Bash for Unix/macOS/Git Bash, and PowerShell for Windows).
- **[Risk] Network Connectivity** → **[Mitigation]** The installer will perform connectivity checks and fail gracefully with instructions for offline setup if needed.
- **[Risk] Node.js Rewrite Effort** → **[Mitigation]** The Node.js version is a fallback; the Python version is the priority and will be delivered first.
