## ADDED Requirements

### Requirement: Specification Analysis
The system SHALL analyze provided OpenSpec specification files or directories to identify acceptance criteria and functional requirements.

#### Scenario: Analyze single spec file
- **WHEN** the user provides a path to a single `spec.md` file
- **THEN** the system extracts all requirements and scenarios from that file

#### Scenario: Analyze spec directory
- **WHEN** the user provides a path to a directory containing multiple `spec.md` files
- **THEN** the system extracts requirements and scenarios from all spec files within that directory

### Requirement: Test Case Synthesis
The system SHALL generate test cases covering positive (nominal), negative (error), and boundary (limit) scenarios based on the analyzed specifications.

#### Scenario: Generate diverse test cases
- **WHEN** a requirement has multiple scenarios
- **THEN** the system generates at least one test case for each scenario plus additional edge cases

### Requirement: Excel Template Population
The system SHALL use a provided Excel template (`.xlsx`) and populate a new copy with the generated test cases starting from **Row 7**.

#### Scenario: Create new Excel file from template
- **WHEN** the generation process is triggered
- **THEN** the system creates a new `.xlsx` file based on `Test Case - Function.xlsx` starting from Row 7.

### Requirement: Formatting and Style Consistency
The system SHALL maintain the alignment, font, and border styles of the original template for all generated rows.

#### Scenario: Maintain template styles
- **WHEN** writing generated data to the Excel file
- **THEN** the system copies style objects (Alignment, Font, etc.) from a reference row (e.g., Row 11) to the newly populated rows.

### Requirement: Standardized Column Mapping
The system SHALL map generated data to the following columns: `No`, `Classification`, `Content`, `Test method`, and `Test result` (Expected Result).

#### Scenario: Map data to correct columns
- **WHEN** writing to the Excel file
- **THEN** the system places 'Classification' in column B, 'Content' in column C, 'Test method' in column D, and 'Test result' in column E

### Requirement: Auto-Incrementing IDs
The system SHALL automatically increment the `No` column for each generated test case.

#### Scenario: Increment test numbers
- **WHEN** multiple test cases are generated
- **THEN** the 'No' column (column A) contains sequential numbers starting from 1

### Requirement: Command Alias Integration
The system SHALL support triggering the generation process via a dedicated command alias that accepts a path as an argument.

#### Scenario: Trigger via command
- **WHEN** the user runs `/opsx:test <path>`
- **THEN** the system initiates the analysis and generation flow for the specified path
