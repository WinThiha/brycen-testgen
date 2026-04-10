## ADDED Requirements

### Requirement: JSON-Based Test Case Review
The system SHALL provide a manual review step for generated test cases by including a boolean selection field in the `temp_tests.json` file.

#### Scenario: AI generates JSON with boolean field
- **WHEN** the AI generates the `temp_tests.json` file
- **THEN** every test case entry in the JSON MUST include a `"selected": true` boolean field

#### Scenario: AI pauses for user review
- **WHEN** `temp_tests.json` has been written and before the Excel generation script is executed
- **THEN** the AI MUST use the `ask_user` tool to pause and prompt the user to review the file

#### Scenario: User excludes test cases
- **WHEN** the user sets `"selected": false` for one or more items in `temp_tests.json` and confirms the prompt
- **THEN** only the test cases where `"selected": true` are written to the Excel output file

### Requirement: Filtering in Excel Generation
The Excel generation script SHALL filter the input JSON data based on the boolean selection field.

#### Scenario: Script reads filtered JSON
- **WHEN** `opsx-testgen.py` reads `temp_tests.json`
- **THEN** it MUST iterate over the list and only process items where the `"selected"` key is `true`

#### Scenario: Backwards Compatibility
- **WHEN** the `"selected"` key is missing from a test case entry
- **THEN** the script MUST default to `true` and include the test case in the output

### Requirement: Empty Selection Handling
The system SHALL handle cases where no test cases are selected for output.

#### Scenario: No tests selected
- **WHEN** all items in `temp_tests.json` have `"selected": false`
- **THEN** the script MUST either skip Excel generation or generate an empty table with headers only, without crashing
