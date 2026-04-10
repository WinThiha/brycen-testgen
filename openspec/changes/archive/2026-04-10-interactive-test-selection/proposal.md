## Why

After AI generates test cases, all of them are written to the Excel file with no opportunity for the user to review or curate the output. Users need a way to select only the test cases they want before the file is produced.

## What Changes

- **New manual selection step**: After `temp_tests.json` is generated, the AI pauses and asks the user to review the file.
- **JSON review field**: `temp_tests.json` now includes a `"selected": true` boolean for every test case. Users can set this to `false` in their editor to exclude a test.
- **Filtering in `opsx-testgen.py`**: The Python script now filters the JSON data and only writes test cases where `"selected"` is `true`.
- **Simplified dependencies**: Dropped the requirement for `InquirerPy` and `prompt_toolkit`, keeping the environment lightweight and avoiding terminal rendering issues in Gemini CLI.

## Capabilities

### New Capabilities
- `test-case-review`: Manual review of generated JSON data with boolean selection fields before Excel output is written.

### Modified Capabilities
- `test-case-generation`: The generation flow now includes a mandatory pause for user review between JSON writing and Excel population.

## Impact

- **`.brycen/scripts/opsx-testgen.py`**: Logic added to filter tests based on the `"selected"` boolean field.
- **`scripts/install.ps1` / `install.sh`**: No changes needed (InquirerPy is not required).
- **`.brycen/env/`**: Stays lightweight with only core dependencies.
