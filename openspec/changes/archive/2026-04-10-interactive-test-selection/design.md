## Context

The current `opsx-testgen.py` script takes `temp_tests.json` and immediately writes all tests to an Excel file. Users have no opportunity to review or filter the AI-generated list. The new approach adds a boolean `"selected": true` field to the generated JSON, which the user can edit manually before confirming the final Excel generation.

## Goals / Non-Goals

**Goals:**
- Provide a review step for generated test cases before final file output.
- Use a simple boolean field in `temp_tests.json` for selection.
- Avoid terminal UI issues in Gemini CLI by offloading review to the user's editor.
- Use the Gemini CLI `ask_user` tool to create a clean review pause.

**Non-Goals:**
- Interactive terminal-based checkboxes (dropped due to CLI bugs).
- AI-assisted "add more" capability.
- Automatic filtering without user intervention.

## Decisions

### 1. JSON-based Selection (Option A)

- **Decision**: Add a `"selected": true` boolean to every test item in `temp_tests.json`.
- **Rationale**: This is the cleanest, most robust way to allow selection. It avoids all TTY/terminal rendering issues and uses the user's existing editor (IDE) for the review interface.
- **Alternatives**:
  - *InquirerPy (Terminal UI)*: Rejected due to buggy behavior and freezing in Gemini CLI.
  - *Markdown Checkboxes*: Rejected as it adds a separate file to track.

### 2. Filtering in opsx-testgen.py

- **Decision**: Add a single filtering step inside `opsx-testgen.py` that iterates over the JSON list and only processes items where `selected` is `true`.
- **Rationale**: Minimal code change required. If the `selected` key is missing (e.g. for legacy support), it defaults to `true`.

### 3. AI-Managed Pause

- **Decision**: The AI (Gemini CLI) will call `ask_user` after writing `temp_tests.json`.
- **Rationale**: This leverages the native CLI capability to pause execution and wait for user confirmation.

## Risks / Trade-offs

- **[Risk] User forgetting to save the JSON file** → **[Mitigation]** The AI will explicitly instruct the user to "Save and Confirm" in the prompt.
- **[Risk] User accidentally deleting the JSON content** → **[Mitigation]** The script will handle empty JSON cases gracefully.
