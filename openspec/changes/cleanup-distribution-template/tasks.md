## 1. Git Hygiene and Exclusion

- [x] 1.1 Add `.brycen/env/` to the `.gitignore` file.
- [x] 1.2 Add `temp_tests.json` and `Test Case*.xlsx` to the `.gitignore` file.
- [x] 1.3 Remove `.brycen/env/` from the Git index using `git rm -r --cached`.

## 2. Root Directory Cleanup

- [x] 2.1 Delete `Test Case - Function.xlsx` from the project root.
- [x] 2.2 Delete `Checklist.xlsx` from the project root.

## 3. Reference Standardization

- [x] 3.1 Update `.gemini/skills/brycen-generate_tests/SKILL.md` to ensure it references the master template at `.brycen/templates/Test Case - Function.xlsx`.
- [x] 3.2 Update `CLAUDE.md` documentation to reflect the cleanup.
- [x] 3.3 Verify all other AI skill copies (`.claude`, `.opencode`, etc.) point to the master template.

## 4. Verification

- [x] 4.1 Run `git status` to verify that `.brycen/env/` is now "untracked" and the root files are staged for deletion.
- [x] 4.2 Run a test generation command to ensure the script still works using the master template.
