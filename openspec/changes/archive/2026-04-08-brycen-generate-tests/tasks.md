## 1. CLI Tool Implementation (opsx-testgen)

- [x] 1.1 Create the `opsx-testgen` Python script using `openpyxl`.
- [x] 1.2 Implement JSON data validation for the intermediate `tests.json` format.
- [x] 1.3 Implement template copying logic to preserve formatting and styles.
- [x] 1.4 Add the auto-incrementing logic for the 'No' column (starting from row 2).
- [x] 1.5 Add support for outputting to a specific filename based on the feature name.

## 2. Universal Skill Design

- [x] 2.1 Create the `generate-tests/SKILL.md` with structured prompt instructions.
- [x] 2.2 Define the strict "Only read specified specs" constraint in the prompt.
- [x] 2.3 Define the exact JSON schema for the AI's output to match `opsx-testgen`'s requirements.
- [x] 2.4 Add the "shell command" instruction to trigger the Python script at the end of the skill.

## 3. Workspace Configuration

- [x] 3.1 Create `.gemini/commands/opsx/test.toml` to link `/opsx:test` to the skill.
- [x] 3.2 Create equivalent command aliases for `.claude/commands/`, `.kilocode/commands/`, etc.
- [x] 3.3 Ensure the `SKILL.md` is correctly located in each tool's skill directory.

## 4. Verification

- [x] 4.1 Test the flow using a single spec file as input.
- [x] 4.2 Test the flow using a directory of specs as input.
- [x] 4.3 Verify that the resulting Excel file matches the template structure exactly.
- [x] 4.4 Verify that the `No` column is correctly incremented.
