## 1. Versioning Setup

- [x] 1.1 Create the local `.brycen/VERSION` file with the initial version string (e.g., `1.1.0`).
- [x] 1.2 Add the `VERSION` file to the root of the project (for remote fetching).

## 2. Update Command Implementation

- [x] 2.1 Create the `.gemini/commands/brycen/update.toml` command definition.
- [x] 2.2 Create the `.gemini/skills/brycen-update/SKILL.md` file with the update flow (fetch remote version, compare, run installer).
- [x] 2.3 Update `scripts/install.ps1` to also fetch the new update and cleanup command/skill files.
- [x] 2.4 Update `scripts/install.sh` to also fetch the new update and cleanup command/skill files.

## 3. Cleanup Command Implementation

- [x] 3.1 Create the `.gemini/commands/brycen/clean_up.toml` command definition.
- [x] 3.2 Create the `.gemini/skills/brycen-clean_up/SKILL.md` file with the cleanup flow (scan for temp files, ask to delete).

## 4. Multi-AI Synchronization

- [x] 4.1 Sync the update and cleanup commands/skills to the `.claude/` directory.
- [x] 4.2 Sync the update and cleanup commands/skills to the `.opencode/` directory.

## 5. Verification

- [x] 5.1 Run `/brycen:update` and verify version check and installer execution.
- [x] 5.2 Run `/brycen:clean_up` and verify file detection and deletion.
