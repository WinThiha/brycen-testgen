## ADDED Requirements

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
