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
The system SHALL use the master Excel template located at `.brycen/templates/Test Case - Function.xlsx` and populate a new copy with the **user-selected** test cases starting from **Row 7**.

#### Scenario: Create new Excel file from template
- **WHEN** the user confirms their selection in the interactive UI
- **THEN** the system creates a new `.xlsx` file based on `.brycen/templates/Test Case - Function.xlsx`, populating only the selected test cases starting from Row 7

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
- **WHEN** the user runs `/brycen:generate_tests <path>`
- **THEN** the system initiates the analysis and generation flow for the specified path

### Requirement: Metadata Collection and Injection
The system SHALL collect metadata including Author, System Name (Title), and Sub System Name from the user, and inject this data along with the current date into specific sheets and cells of the generated Excel workbook.

#### Scenario: Inject metadata into Title sheet
- **WHEN** the Excel workbook is generated
- **THEN** the system populates the System Name at `Title!I13`, Date at `Title!L18` and `Title!L19`, and Author at `Title!P18` and `Title!P19`.

#### Scenario: Inject metadata into TestCase sheet
- **WHEN** the Excel workbook is generated
- **THEN** the system populates the System Name at `TestCase!Q1`, Sub System Name at `TestCase!Q2`, Date at `TestCase!AI1`, and Author at `TestCase!AP1`.

#### Scenario: Inject metadata into NG Report sheet
- **WHEN** the Excel workbook is generated
- **THEN** the system populates the System Name at `NG Report!Q1`, Sub System Name at `NG Report!Q2`, Date at `NG Report!AI1`, and Author at `NG Report!AP1`.

#### Scenario: Graceful handling of missing metadata
- **WHEN** the intermediate JSON file lacks the `meta` object
- **THEN** the system proceeds with generating test cases without injecting the missing metadata and issues a non-fatal warning.

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
