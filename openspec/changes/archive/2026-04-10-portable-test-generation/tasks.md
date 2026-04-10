## 1. Preparation

- [x] 1.1 Create the standardized `.brycen/` directory structure to store templates, scripts, and environments.
- [x] 1.2 Copy the `Test Case - Function.xlsx` template to the new `.brycen/templates/` directory.
- [x] 1.3 Relocate `scripts/opsx-testgen.py` to `.brycen/scripts/opsx-testgen.py` and ensure it can run standalone.

## 2. Installer Development

- [x] 2.1 Implement `scripts/install.ps1` (Windows) with system probing for Python 3.8+.
- [x] 2.2 Implement `scripts/install.sh` (Unix/macOS) with system probing for Python 3.8+.
- [x] 2.3 Add logic to the installers to create a project-local Python virtual environment (`.venv`) inside `.brycen/`.
- [x] 2.4 Add logic to install the `openpyxl` dependency into the newly created `.venv`.

## 3. AI Assistant Configuration

- [x] 3.1 Generate the `.gemini/commands/brycen/generate_tests.toml` configuration pointing to the local `.venv`.
- [x] 3.2 Generate the `.claude/commands/brycen/generate_tests.md` configuration (or equivalent for Claude).
- [x] 3.3 Generate the `.opencode/command/brycen-generate_tests.md` configuration.
- [x] 3.4 Update all related `SKILL.md` files to document the new `/brycen:generate_tests` command.

## 4. Error Handling and Reporting

- [x] 4.1 Implement catch-all error blocks in the installers to capture and display failures.
- [x] 4.2 Add the "Report to Brycen" prompt and `mailto:` link generator to the installers.
- [x] 4.3 Add a try-except block to the Python script to handle runtime failures and offer reporting.

## 5. Testing and Verification

- [x] 5.1 Verify the installer creates a functional `.venv` and installs dependencies correctly.
- [x] 5.2 Test the `/brycen:generate_tests` command through Gemini CLI to ensure it executes the script.
- [x] 5.3 Confirm the `mailto:` link correctly populates the email client on failure.

## 6. Remote Artifact Fetching

- [x] 6.1 Define a `BASE_URL` variable in `scripts/install.ps1` and `scripts/install.sh` pointing to the central repository.
- [x] 6.2 Implement file download logic (`Invoke-WebRequest` / `curl`) to fetch `opsx-testgen.py` and `Test Case - Function.xlsx` into the `.brycen` directory.
- [x] 6.3 Implement smart AI detection logic to automatically download the correct `.toml`/`.md` configurations and `SKILL.md` files into the user's local `.gemini`, `.claude`, or `.opencode` directories based on presence.
