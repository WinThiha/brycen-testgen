## 1. Clean Up Dependencies

- [x] 1.1 Remove `InquirerPy` and `prompt_toolkit` from `.brycen/env` (optional, for weight reduction)

## 2. Selection Implementation

- [x] 2.1 In `opsx-testgen.py`, add logic to filter tests based on the `"selected": true` boolean
- [x] 2.2 Default to `true` if the key is missing to ensure backwards compatibility

## 3. Workflow Update

- [x] 3.1 Update the AI's instruction for test generation to include adding `"selected": true` to every test item in `temp_tests.json`
- [x] 3.2 Update the AI's instruction to call `ask_user` after JSON writing and before Excel generation

## 4. Verification

- [x] 4.1 Run the full flow: AI generates JSON with boolean fields → AI pauses → Edit some to `false` → Confirm → Verify Excel contains only the `true` items
- [x] 4.2 Test with empty selection (all `false`) to ensure the script handles it without crashing
