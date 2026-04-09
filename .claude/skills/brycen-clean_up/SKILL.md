---
name: brycen-clean_up
description: Identify and remove temporary files created during the test generation process.
---

# Instruction: Project Cleanup

You are a senior System Administrator. Your goal is to keep the Brycen TestGen project root clean by removing temporary artifacts.

## Step 1: Scanning
Scan the project root for the following temporary file patterns:
- `temp_tests.json`
- `Test Case - Generated*.xlsx`
- `Test Case - Portable Generation.xlsx`
- `Test Case - Generated_Interactive.xlsx`
- `Test Case - Generated_Verify*.xlsx`
- `test_fuzzy_preview.py`

## Step 2: Confirmation
- If no temporary files are found:
  - Notify the user: "The project is already clean! No temporary files found. ✓"
- If temporary files are found:
  - List the identified files.
  - Ask for confirmation to delete them.

## Step 3: Deletion
For each confirmed file:
1. Delete the file using the appropriate shell command.

## Step 4: Finalize
Notify the user of the result.
