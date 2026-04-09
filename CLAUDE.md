# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Project Is

This is the **Brycen TestGen** template project — a portable test case generation tool. It analyzes OpenSpec `spec.md` files and produces a populated Excel test case file using a Python script and a bundled template.

## Generating Test Cases

Use the `/brycen:generate_tests` command (or its alias `/opsx:test`) with a path to a spec file or directory:

```
/brycen:generate_tests openspec/specs/test-case-generation
```

The skill (`.claude/skills/brycen-generate_tests/SKILL.md`) drives this flow:
1. Read target `spec.md` file(s) at the given path — **no other files**.
2. Generate test cases (positive, negative, boundary) and write to `temp_tests.json` in the project root with `"selected": true` for each item.
3. Pause for user review of `temp_tests.json` via the AI's confirmation prompt.
4. Filtered items (where `selected` is `true`) are processed by the Python script to produce the Excel output.

### Running the Python script manually

```bash
# Windows (preferred — uses bundled venv)
.brycen/env/Scripts/python.exe .brycen/scripts/opsx-testgen.py \
  --input temp_tests.json \
  --template ".brycen/templates/Test Case - Function.xlsx" \
  --output "Test Case - Generated.xlsx"

# Unix
.brycen/env/bin/python .brycen/scripts/opsx-testgen.py \
  --input temp_tests.json \
  --template ".brycen/templates/Test Case - Function.xlsx" \
  --output "Test Case - Generated.xlsx"
```

Python executable priority: `.brycen/env/Scripts/python.exe` (Windows) → `.brycen/env/bin/python` (Unix) → `python3` → `python`.

## Architecture

### Key files

| Path | Purpose |
|------|---------|
| `.brycen/scripts/opsx-testgen.py` | Core script: reads `temp_tests.json`, copies template, populates Excel |
| `.brycen/templates/Test Case - Function.xlsx` | Source Excel template |
| `.brycen/env/` | Bundled Python venv with `openpyxl` pre-installed |
| `temp_tests.json` | Intermediate JSON written by AI, consumed by the script |
| `openspec/specs/` | Canonical OpenSpec specification files |
| `openspec/changes/` | In-progress and archived change proposals |

### Excel population details (opsx-testgen.py)

- Data starts at **Row 7**; styles are copied from **Row 11** (reference row).
- Column mapping: `No` (col 1), `Classification` (col 3), `Content` (col 8), `Test method` (col 13), `Test result` (col 24).
- JSON structure required in `temp_tests.json`:
  ```json
  {
    "tests": [
      {
        "selected": true,
        "Classification": "...",
        "Content": "...",
        "Test method": "...",
        "Test result": "..."
      }
    ]
  }
  ```

### OpenSpec workflow

Changes follow a lifecycle managed by `/opsx:propose`, `/opsx:apply`, and `/opsx:archive`. Active changes live in `openspec/changes/<name>/`; completed ones are moved to `openspec/changes/archive/`.

### Multi-AI support

Command definitions and skills are mirrored across `.claude/`, `.gemini/`, `.opencode/`, `.codex/`, and `.kilocode/` directories so the same workflow works in any of those AI assistants.
