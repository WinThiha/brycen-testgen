## Why

Automating test case creation from OpenSpec requirements reduces manual effort, ensures consistency, and minimizes human error in identifying edge cases. This change introduces a universal skill and CLI tool to generate standardized Excel test cases directly from specifications, significantly speeding up the QA process.

## What Changes

- **New Global CLI Tool**: A cross-platform CLI tool (`opsx-testgen`) to handle binary Excel manipulation, ensuring consistency across different development environments.
- **Universal OpenSpec Skill**: A `generate-tests` skill that instructs AI agents (Gemini, Claude, Kilo, etc.) to analyze specifications and produce structured test data.
- **Dedicated Command Alias**: Integration of a `/opsx:test` (or `/brycen:test`) command to trigger the end-to-end generation flow.
- **Template-Based Generation**: Support for generating new Excel files from the `Test Case - Function.xlsx` template with auto-incrementing IDs and pre-filled expected results.

## Capabilities

### New Capabilities
- `test-case-generation`: Core capability for analyzing OpenSpec requirements and generating structured test scenarios for Excel export.

### Modified Capabilities
- (None)

## Impact

- **Workflow**: Adds a standardized QA automation step to the OpenSpec development lifecycle.
- **Dependencies**: Requires the installation of a new global CLI tool (`opsx-testgen`).
- **Tooling**: Requires adding command aliases to `.gemini/`, `.claude/`, and other tool-specific configuration directories.
