---
name: generate-tests
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
      "Classification": "Feature or Menu Name",
      "Content": "What is being tested",
      "Test method": "Step-by-step instructions",
      "Test result": "Expected result"
    }
  ]
}
```

Write this JSON to a temporary file named `temp_tests.json` in the project root.

## Step 4: Execution
After writing `temp_tests.json`, you MUST execute the following shell command to generate the Excel file:

```bash
python scripts/opsx-testgen.py --input temp_tests.json --template "Test Case - Function.xlsx" --output "Test Case - Generated.xlsx"
```

*Note: Replace "Test Case - Generated.xlsx" with a name reflecting the feature if possible.*

Finalize by notifying the user that the Excel file has been generated.
