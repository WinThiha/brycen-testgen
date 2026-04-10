## MODIFIED Requirements

### Requirement: Self-Update via CLI
The system SHALL provide a mechanism to update the project components from the remote repository by fetching the installer script on-demand from GitHub before executing it.

#### Scenario: Check for update (up-to-date)
- **WHEN** the user runs `/brycen:update` and the local `.brycen/VERSION` matches the remote version
- **THEN** the system MUST notify the user that they are already on the latest version

#### Scenario: Check for update (out-of-date)
- **WHEN** the user runs `/brycen:update` and the local `.brycen/VERSION` is older than the remote version
- **THEN** the system MUST display the available version and offer to perform the update

#### Scenario: Force Update
- **WHEN** the user runs `/brycen:update --force`
- **THEN** the system MUST initiate the update process regardless of the current version

#### Scenario: Update execution via remote-fetch (Windows)
- **WHEN** the user confirms an update on Windows
- **THEN** the system MUST download `scripts/install.ps1` from the remote repository to a temporary file in the project root, execute it with `-ExecutionPolicy Bypass`, and delete the temporary file afterward

#### Scenario: Update execution via remote-fetch (Unix)
- **WHEN** the user confirms an update on Unix/macOS
- **THEN** the system MUST download `scripts/install.sh` from the remote repository to a temporary file in the project root, execute it, and delete the temporary file afterward

#### Scenario: Execution fallback when local script exists
- **WHEN** the user confirms an update AND the local `scripts/install.ps1` (Windows) or `scripts/install.sh` (Unix) exists
- **THEN** the system MUST still use the remote-fetch approach to ensure the latest installer logic is used