## Context

The current test case creation process is manual and time-consuming. While AI agents are excellent at generating test scenarios from specifications, they cannot natively and reliably manipulate binary Excel files (`.xlsx`). This design bridges that gap by using a structured JSON intermediate format and a dedicated CLI tool.

## Goals / Non-Goals

**Goals:**
- **Portability**: Create a skill and command set that works across Gemini CLI, Claude Code, Kilo, and OpenCode.
- **Accuracy**: Ensure generated test cases map directly to OpenSpec requirements and scenarios.
- **Format Preservation**: Maintain all styling and structure of the `Test Case - Function.xlsx` template.
- **Automation**: Automate the creation of a new, populated Excel file from a single CLI command.

**Non-Goals:**
- **Test Execution**: This tool is for test case *design*, not automated *execution*.
- **Legacy Support**: We will not support old `.xls` formats; only modern `.xlsx`.
- **Evidence Management**: Capturing screenshots or test evidence is explicitly out of scope for this version.

## Decisions

### 1. Implementation Language: Python with `openpyxl`
- **Rationale**: Python's `openpyxl` library is the industry standard for reading/writing `.xlsx` files while preserving complex formatting, styles, and data validation present in templates.
- **Alternatives**: Node.js with `exceljs` was considered, but `openpyxl` offers more robust handling of existing template features.

### 2. Communication Bridge: Structured JSON
- **Rationale**: The AI skill will output a temporary `tests.json` file. This provides a clear "contract" between the AI's reasoning phase and the script's execution phase, making it easier to debug and verify.
- **Alternatives**: Piping data directly via stdin was considered but found to be less reliable for large sets of test cases.

### 3. Distribution: Global CLI Tool (`opsx-testgen`)
- **Rationale**: By packaging the Python script as a global tool (via `pipx` or a standalone executable), the Skill can assume the tool is available in the user's PATH, keeping the workspace clean of implementation-specific scripts.

### 4. Integration: Cross-CLI Skill Aliases
- **Rationale**: We will provide configuration files for `.gemini`, `.claude`, etc., that all point to the same `SKILL.md`. This ensures a "write once, run anywhere" experience for the user.

### 5. Formatting and Style Consistency
- **Rationale**: To ensure a professional look, the script will copy the `Alignment`, `Font`, `Border`, and `Fill` objects from a reference row (Row 11) in the template. This ensures that text wrapping, centering, and borders are identical to the template's design.
- **Start Row**: Data entry will begin at **Row 7**, as confirmed by template analysis.

## Risks / Trade-offs

- [Risk] Path Ambiguity → Mitigation: The skill will be instructed to use absolute paths or paths relative to the project root to ensure files are found correctly across different OSs.
- [Risk] Style Overwriting → Mitigation: Instead of setting static styles, the script will copy the style objects from the template's existing rows.

