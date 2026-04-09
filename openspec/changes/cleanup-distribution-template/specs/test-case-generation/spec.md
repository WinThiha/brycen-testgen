## MODIFIED Requirements

### Requirement: Excel Template Population
The system SHALL use the master Excel template located at `.brycen/templates/Test Case - Function.xlsx` and populate a new copy with the generated test cases starting from **Row 7**.

#### Scenario: Create new Excel file from template
- **WHEN** the generation process is triggered
- **THEN** the system creates a new `.xlsx` file based on `.brycen/templates/Test Case - Function.xlsx` starting from Row 7.
