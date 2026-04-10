## Why

Managing a local Brycen TestGen project currently requires manual execution of installation scripts for updates and manual file deletion for cleanup. This change introduces dedicated AI-driven commands to automate these maintenance tasks, ensuring users always have the latest version and a tidy workspace.

## What Changes

- **New `/brycen:update` command**: Automates the synchronization of local components with the remote repository, including version checking.
- **New `/brycen:clean_up` command**: Safely identifies and removes temporary files created during the test generation process.
- **Version tracking**: Introduces a `.brycen/VERSION` file to track the local version against the remote repository.
- **Installer updates**: The installation scripts will be updated to fetch these new management commands and skills.

## Capabilities

### New Capabilities
- `self-update`: Ability to check for updates and synchronize with the remote repository.
- `project-cleanup`: Ability to identify and remove temporary files from the project root.

### Modified Capabilities
- `test-case-generation`: The generation flow is improved by ensuring the environment is always up-to-date and clean.

## Impact

- **`.brycen/VERSION`**: New file to track the current version.
- **`.gemini/commands/brycen/update.toml`**: New command definition.
- **`.gemini/skills/brycen-update/SKILL.md`**: New skill for the update flow.
- **`.gemini/commands/brycen/clean_up.toml`**: New command definition.
- **`.gemini/skills/brycen-clean_up/SKILL.md`**: New skill for the cleanup flow.
- **`scripts/install.ps1` & `scripts/install.sh`**: Updated to fetch new components.
