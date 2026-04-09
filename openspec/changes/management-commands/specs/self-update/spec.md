## ADDED Requirements

### Requirement: Self-Update via CLI
The system SHALL provide a mechanism to update the project components from the remote repository.

#### Scenario: Check for update (up-to-date)
- **WHEN** the user runs `/brycen:update` and the local `.brycen/VERSION` matches the remote version
- **THEN** the system MUST notify the user that they are already on the latest version

#### Scenario: Check for update (out-of-date)
- **WHEN** the user runs `/brycen:update` and the local `.brycen/VERSION` is older than the remote version
- **THEN** the system MUST display the available version and offer to perform the update

#### Scenario: Force Update
- **WHEN** the user runs `/brycen:update --force`
- **THEN** the system MUST initiate the update process regardless of the current version

#### Scenario: Update execution
- **WHEN** the user confirms an update
- **THEN** the system MUST execute the local `scripts/install.ps1` (on Windows) or `scripts/install.sh` (on Unix) to refresh the project files

### Requirement: Version Tracking
The system SHALL track the local version in a dedicated file.

#### Scenario: Initial Version setup
- **WHEN** the project is first installed or updated
- **THEN** the system MUST create or update the `.brycen/VERSION` file with the latest version string
