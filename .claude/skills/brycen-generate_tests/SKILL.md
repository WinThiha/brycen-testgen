---
name: brycen-generate_tests
description: Generate standardized Excel test cases from OpenSpec requirements.
---

# Instruction: Generate Standardized Test Cases

You are a senior QA Automation Engineer. Your goal is to analyze specific OpenSpec requirements and generate high-quality test cases for an Excel template.

## Step 1: Target Identification
The user has provided a path: `{{user_input}}`

**STRICT CONSTRAINT**: You MUST ONLY read specification files (`spec.md`) located at the provided path. 
- If the path is a file, read only that file.
- If the path is a directory, read all `spec.md` files within that directory.
- DO NOT read other files in the project unless they are within this path.

## Step 2: Synthesis
Analyze the Acceptance Criteria and Scenarios in the identified specs. Generate test cases covering:
1. Positive (Nominal) cases.
2. Negative (Error) cases.
3. Boundary (Limit) cases.

## Step 3: Structured Output
Format the generated test cases into a JSON structure exactly as follows:

```json
{
  "tests": [
    {
      "selected": true,
      "Classification": "Feature or Menu Name",
      "Content": "What is being tested",
      "Test method": "Step-by-step instructions",
      "Test result": "Expected result"
    }
  ]
}
```

Write this JSON to a temporary file named `temp_tests.json` in the project root.

## Step 4: Review Step
Before generating the Excel file, you MUST pause and allow the user to review the generated test cases.
Use the `ask_user` tool (or equivalent for Claude) with the following prompt:
*"I've generated {{count}} test cases in `temp_tests.json`. Please review the file and change `"selected": true` to `false` for any cases you'd like to exclude. Ready to generate the Excel file?"*

Wait for the user's confirmation before proceeding to Step 5.

## Step 5: Execution
After the user confirms, you MUST execute the following shell command to generate the Excel file.
The Python script will automatically filter out any test cases where `"selected"` is `false`.

**STRICT EXECUTION ORDER**:
1. Check if the project is on Windows or Unix.
2. If Windows and `.brycen\env\Scripts\python.exe` exists, use that.
3. If Unix and `.brycen/env/bin/python` exists, use that.
4. Fallback to `python3` or `python` if the virtual environment is missing.

**The command to run is:**
```bash
<python_executable> .brycen/scripts/opsx-testgen.py --input temp_tests.json --template ".brycen/templates/Test Case - Function.xlsx" --output "Test Case - Generated.xlsx"
```

*Note: Replace "Test Case - Generated.xlsx" with a name reflecting the feature if possible.*

Finalize by notifying the user that the Excel file has been generated.
