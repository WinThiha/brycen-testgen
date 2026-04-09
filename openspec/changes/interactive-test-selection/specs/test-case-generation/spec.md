## MODIFIED Requirements

### Requirement: Excel Template Population
The system SHALL use a provided Excel template (`.xlsx`) and populate a new copy with the **user-selected** test cases starting from **Row 7**.

#### Scenario: Create new Excel file from template
- **WHEN** the user confirms their selection in the interactive UI
- **THEN** the system creates a new `.xlsx` file based on `Test Case - Function.xlsx`, populating only the selected test cases starting from Row 7
