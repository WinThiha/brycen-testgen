## Context

The current test generation workflow generates the core test cases into the active worksheet of an Excel template (`Test Case - Function.xlsx`). However, it misses the header information (metadata) such as System Name, Sub System Name, Author, and Date, which are required for a complete deliverable. This requires manual data entry post-generation.

## Goals / Non-Goals

**Goals:**
- Automatically collect `Author`, `System Name` (Title), and `Sub System Name` from the user during the test generation process.
- Embed this collected metadata, along with the current system date, into the intermediate JSON file (`temp_tests.json`).
- Parse this metadata in the Python script (`opsx-testgen.py`) and inject it into specific cells across three worksheets (`Title`, `TestCase`, and `NG Report`).

**Non-Goals:**
- Modifying the actual test case generation logic (the LLM prompt for generating test rows).
- Changing the template structure itself.

## Decisions

1. **Metadata Collection:** Update the SKILL definitions (`generate-tests` across platforms) to explicitly ask the user for `Author`, `System Name`, and `Sub System Name` before generating `temp_tests.json`.
   - *Rationale:* Collecting this upfront ensures the LLM has all the data it needs to construct the complete JSON payload.
2. **JSON Schema Update:** Introduce a `meta` block to `temp_tests.json` to hold these values.
   - *Rationale:* Separating metadata from the list of `tests` keeps the JSON structure clean and easy to parse.
3. **Python Script (`opsx-testgen.py`) Updates:**
   - Read the `meta` object.
   - Generate the current date in `%Y/%m/%d` format (or similar standard format).
   - Write to specific worksheets and cells using `openpyxl`.
   - *Rationale:* `openpyxl` can target specific sheets and cells easily, including the top-left cell of merged ranges, which matches the provided coordinates.

## Risks / Trade-offs

- **Risk:** Template changes could break hardcoded cell coordinates.
  - *Mitigation:* Document the expected cell coordinates clearly in the code. If the template changes in the future, these coordinates will need to be updated.
- **Risk:** The Python script might fail if the `meta` block is missing from older JSON files.
  - *Mitigation:* Use `.get()` or handle `KeyError` gracefully in the Python script to ensure backwards compatibility where possible, or print a warning and skip metadata injection.
