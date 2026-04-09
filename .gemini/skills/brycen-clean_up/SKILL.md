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
  - Use the `ask_user` tool (type: `choice`, multiSelect: `true`) to let the user select which files to delete.
  - Pre-select all found files by default.

## Step 3: Deletion
For each selected file:
1. Delete the file using the appropriate shell command (e.g., `Remove-Item` on Windows, `rm` on Unix).
2. Verify the deletion.

## Step 4: Finalize
Notify the user of the result (e.g., "Successfully removed 3 temporary files. Project is clean!").

## Guardrails
- **NEVER** delete the following files:
  - `.brycen/templates/*.xlsx` (Master templates)
  - `openspec/specs/**/*.md` (Source specifications)
  - `scripts/install.*` (Installers)
  - Any `.git` related files.
- Always ask for confirmation before deleting.
