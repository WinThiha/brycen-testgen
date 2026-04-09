## Why

The current repository contains significant bloat, including a 10.6MB redundant Excel template and a 4,000+ file Python virtual environment tracked in Git. This makes the project heavy, unprofessional, and prone to "re-bloating" when users generate tests or set up their local environments.

## What Changes

- **Removal of Redundant Root Files**: Delete `Test Case - Function.xlsx` and `Checklist.xlsx` from the project root.
- **Git Untracking of Environment**: Stop tracking the `.brycen/env/` folder in Git.
- **Hardened Gitignore**: Update `.gitignore` to strictly exclude the virtual environment, temporary JSON files, and any generated Excel outputs in the root.

## Capabilities

### New Capabilities
- `project-cleanup`: Ability to maintain a lean project structure by identifying and removing temporary or redundant artifacts.

### Modified Capabilities
- `test-case-generation`: The generation flow is improved by ensuring that output files are correctly ignored by version control.

## Impact

- **`.gitignore`**: Modified to include `.brycen/env/`, `temp_tests.json`, and `Test Case*.xlsx`.
- **Git History**: Size will be reduced (after next commit/GC) by removing binary blobs and thousands of environment files.
- **Developer Experience**: A cleaner workspace with only necessary source files.
