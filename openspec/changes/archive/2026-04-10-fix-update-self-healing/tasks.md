## 1. Update Self-Update Skill (All AI Assistants)

- [x] 1.1 Update `.opencode/skills/brycen-update/SKILL.md` — Change Step 3 (Execution) to download the install script from GitHub to a temp file in the project root, execute it, then delete the temp file. Replace `scripts/install.ps1` / `scripts/install.sh` references with remote-fetch-then-execute pattern
- [x] 1.2 Update `.claude/skills/brycen-update/SKILL.md` with the same execution logic
- [x] 1.3 Update `.gemini/skills/brycen-update/SKILL.md` with the same execution logic
- [x] 1.4 Update `.kilocode/skills/brycen-update/SKILL.md` with the same execution logic (N/A — not present in this installation)
- [x] 1.5 Update `.codex/skills/brycen-update/SKILL.md` with the same execution logic (N/A — not present in this installation)

## 2. Update Install Scripts (Remote-Ready)

- [x] 2.1 Verify `scripts/install.ps1` works correctly when executed from the project root after being downloaded as a temp file (no path assumptions about its own location)
- [x] 2.2 Verify `scripts/install.sh` works correctly when executed from the project root after being downloaded as a temp file

## 3. Update OpenSpec Requirements

- [x] 3.1 Update `openspec/specs/self-update/spec.md` to reflect remote-fetch-then-execute pattern instead of relying on local `scripts/install.ps1` / `scripts/install.sh`

## 4. Verification

- [ ] 4.1 Manually test the update flow: delete `scripts/` directory, run the updated skill, confirm it downloads and executes the installer
- [ ] 4.2 Confirm temp file cleanup after successful and failed executions