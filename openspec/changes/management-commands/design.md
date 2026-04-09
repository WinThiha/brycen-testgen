## Context

The current Brycen TestGen installation process is centralized in the `scripts/install.ps1` and `scripts/install.sh` files. These scripts handle environment detection, virtual environment creation, and file fetching from GitHub. However, once installed, there is no built-in way to update the project or clean up temporary files without manually running these scripts or deleting files. This design introduces AI-managed commands to wrap these existing scripts and add cleanup functionality.

## Goals / Non-Goals

**Goals:**
- Provide a clean, AI-managed interface for updating the project.
- Implement version tracking to avoid unnecessary downloads.
- Provide a safe way to clean up temporary files created during test generation.
- Ensure all supported AI tools (Gemini, Claude, OpenCode) are updated.

**Non-Goals:**
- Replacing the existing installer scripts (we will leverage them instead).
- Providing a full-blown package manager.
- Modifying core application logic unrelated to maintenance.

## Decisions

### 1. Version Tracking Strategy

- **Decision**: Use a simple text file `.brycen/VERSION` for local tracking and fetch a corresponding `VERSION` file from the remote repository's root.
- **Rationale**: Minimalist and robust. Doesn't require complex parsing or local databases.
- **Alternatives**:
  - *Hardcoding version in Python*: Rejected—makes it harder for the AI skills to check version without executing Python.
  - *Git tags*: Rejected—requires the user to have Git installed and configured, which isn't guaranteed in all project environments.

### 2. Update Implementation via Existing Installer

- **Decision**: The `/brycen:update` skill will first check the version. If an update is needed (or forced), it will execute the local `scripts/install.ps1` or `scripts/install.sh`.
- **Rationale**: Reuses the tested installation logic. The installer script already handles file fetching and environment setup.
- **Alternatives**:
  - *Skill-managed fetching*: Rejected—would duplicate the logic in the installer scripts, making maintenance harder.

### 3. Dedicated `/brycen:clean_up` Command

- **Decision**: Create a standalone command that identifies specific temporary files (`temp_tests.json`, `Test Case - Generated*.xlsx`, etc.) and offers to delete them.
- **Rationale**: Keeps the update process focused on code syncing. Cleanup is a separate, frequent maintenance task.

## Risks / Trade-offs

- **[Risk] Installer script overwriting local customizations** → **[Mitigation]** The AI will warn the user before running the update, emphasizing that core project files will be refreshed.
- **[Risk] Accidental deletion of user-edited files in cleanup** → **[Mitigation]** The cleanup skill will list all identified files and ask for confirmation before deleting.
- **[Risk] Version mismatch if GitHub is unreachable** → **[Mitigation]** The skill will handle fetch failures gracefully and notify the user that it couldn't check for updates.
