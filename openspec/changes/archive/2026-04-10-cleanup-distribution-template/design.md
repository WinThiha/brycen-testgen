## Context

The Brycen TestGen project has accumulated redundant files in its root directory and is currently tracking its Python virtual environment in Git. This leads to a bloated repository (thousands of files and several megabytes of binary data) and makes it harder to maintain a "clean" state for distribution.

## Goals / Non-Goals

**Goals:**
- **Git Hygiene**: Stop tracking the local environment and ensure it's ignored.
- **Root Cleanup**: Remove binary and redundant files from the project root.
- **Template Consolidation**: Ensure all tools point to the master template in `.brycen/templates/`.

**Non-Goals:**
- Deleting the local virtual environment (it should stay functional, just untracked).
- Modifying the core generation logic (except for path references).

## Decisions

### 1. Git Index Removal (`git rm --cached`)

- **Decision**: Use `git rm -r --cached .brycen/env/` to stop tracking the environment folder.
- **Rationale**: This is the standard Git command to stop tracking a folder while keeping the files on the local disk. It ensures existing installs don't break but prevents future commits from including the venv.
- **Alternatives**:
  - *Deleting the folder*: Rejected—would break the local installation.
  - *Ignoring without removing from index*: Rejected—Git continues to track files already in the index even if they match `.gitignore`.

### 2. Hardened Glob Pattern for Excel Outputs

- **Decision**: Add `Test Case*.xlsx` to `.gitignore`.
- **Rationale**: This is a "greedy" pattern that catches both the redundant root template (`Test Case - Function.xlsx`) and any generated files (e.g., `Test Case - Generated.xlsx` or `Test Case - Login.xlsx`).

### 3. Master Template Enforcement

- **Decision**: Standardize all documentation and skill instructions to reference `.brycen/templates/Test Case - Function.xlsx`.
- **Rationale**: Centralizes the template location, allowing the root copy to be safely deleted without breaking the "master" source.

## Risks / Trade-offs

- **[Risk] User losing local venv** → **[Mitigation]** The design explicitly uses `--cached` to keep local files.
- **[Risk] Broken path references** → **[Mitigation]** The cleanup will verify all skills/scripts point to the `.brycen/templates/` directory before deleting the root copy.
