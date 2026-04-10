## Why

The current test generation process correctly creates test cases but leaves out critical metadata such as the author, system name (title), sub-system name, and the creation date. To finalize the deliverables, this metadata needs to be injected into specific cells across the `Title`, `TestCase`, and `NG Report` sheets of the Excel template. This ensures the output is complete and ready for distribution or review without manual editing.

## What Changes

- Update the test generation SKILLs (Gemini, Claude, KiloCode, etc.) to prompt the user for Author, Title (System Name), and Sub System Name.
- Modify the SKILLs to output a `meta` block in the generated `temp_tests.json` containing these values.
- Update the `opsx-testgen.py` script to parse the `meta` block and fetch the current system date.
- Inject the metadata and date into specific cells on the `Title`, `TestCase`, and `NG Report` sheets:
  - **System Name (Title)**: `Title!I13`, `TestCase!Q1`, `NG Report!Q1`
  - **Sub System Name**: `TestCase!Q2`, `NG Report!Q2`
  - **Author**: `Title!P18` & `Title!P19`, `TestCase!AP1`, `NG Report!AP1`
  - **Current Date**: `Title!L18` & `Title!L19`, `TestCase!AI1`, `NG Report!AI1`

## Capabilities

### New Capabilities

- None

### Modified Capabilities

- `test-case-generation`: Expanding the test case generation process to include and inject metadata (Author, System Name, Sub System Name, Date) into the generated Excel workbook.

## Impact

- **Test Generation SKILLs**: Will be updated to request more information and output an updated JSON format.
- **`opsx-testgen.py`**: Will be modified to read metadata and write to additional sheets and cells in the Excel template.
- **End Users**: Will be prompted for a few extra details when generating tests but will receive a fully complete Excel file.
