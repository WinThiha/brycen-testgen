## MODIFIED Requirements

### Requirement: Command Alias Integration
The system SHALL support triggering the generation process via a dedicated command alias that accepts a path as an argument.

#### Scenario: Trigger via command
- **WHEN** the user runs `/brycen:generate_tests <path>`
- **THEN** the system initiates the analysis and generation flow for the specified path
