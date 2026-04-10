## Context

The Brycen TestGen project distributes itself as a template. Users install it by cloning or copying the repo, then running `scripts/install.ps1` (Windows) or `scripts/install.sh` (Unix). The installer fetches core files (Python script, Excel template, VERSION) and AI assistant configs from GitHub into the project.

The self-update skill (`/brycen:update`) follows the same pattern: version check → confirmation → execute the local `scripts/install.ps1` or `scripts/install.sh`.

**The bug**: The installer never copies itself into the installed project. After initial setup, `scripts/install.ps1` and `scripts/install.sh` remain in the template repo but are absent from any project that was set up via the installer. When `/brycen:update` tries to run these files, they don't exist.

Five skill files across as many AI assistant directories all reference the same broken path.

## Goals / Non-Goals

**Goals:**
- Make the update process self-healing — it should work in any installed project, even without local install scripts
- Eliminate the assumption that `scripts/install.ps1` or `scripts/install.sh` exist locally
- Keep the initial install flow (cloning + running scripts) unchanged

**Non-Goals:**
- Changing the initial installation flow (clone + run script)
- Bundling the install scripts into `.brycen/` during initial setup (Option A — chicken-and-egg problem)
- Removing the install scripts from the repo (they're still needed for first-time setup)

## Decisions

### Decision 1: Remote-fetch the install script before executing (Option B)

**Choice**: Download the install script from GitHub on-demand, then execute the downloaded copy.

**Alternatives considered**:
- **Option A (move scripts into `.brycen/`)**: Would require the initial `scripts/install.ps1` to also copy itself into `.brycen/scripts/`, adding complexity. Still leaves a chicken-and-egg gap for projects that somehow miss that step. Fragile.
- **Option C (inline all update logic in SKILL.md)**: Would duplicate the entire installer logic inside the skill prompt. Maintenance burden — two places to keep in sync. The skill document would become very long and AI-dependent for correctness.

**Rationale**: Option B is the simplest fix with the fewest moving parts. The install scripts already fetch everything from GitHub — we just need to fetch the install script itself the same way. This is idempotent and self-repairing: the latest script is always retrieved, so even if the local copy is outdated or missing, the update still works.

### Decision 2: Where to download the script

**Choice**: Download to the project root as a temporary file (e.g., `update_install.ps1`), execute it, then delete it.

**Rationale**: Downloading to the project root keeps the path predictable. The cleanup step prevents stale scripts from accumulating. The filename prefix (`update_`) avoids collision with any existing `scripts/` directory.

### Decision 3: Consistent approach across all AI skill files

**Choice**: Update all five mirrored SKILL.md files identically.

**Rationale**: The project maintains parity across `.opencode/`, `.claude/`, `.gemini/`, `.kilocode/`, and `.codex/`. All must reflect the same download-then-execute pattern.

## Risks / Trade-offs

- **[Network dependency on update]** → Every update now requires network access to fetch the script. This is already the case for the files the script fetches, so it's not a new requirement. The version check step also needs network. No added risk.
- **[Downloaded script could be tampered]** → We're already trusting GitHub as the source of truth for all fetched files. The install script is no different from `opsx-testgen.py` in this regard. Could add a SHA check in a future change, but out of scope here.
- **[Cleanup failure leaves temp file]** → If the AI crashes between download and cleanup, a `update_install.ps1` file remains. Low impact — it's inert and can be safely deleted. The `.gitignore` could be updated to exclude it, but that's optional.
- **[Script execution policy on Windows]** → The existing installer uses `-ExecutionPolicy Bypass`. The download-then-execute approach uses the same flag, so no change in security posture.