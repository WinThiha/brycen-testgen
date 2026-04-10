## Why

The self-update skill references `scripts/install.ps1` and `scripts/install.sh`, but these files are never carried over to an installed project. The installer script fetches core engine files (Python script, template, VERSION) and AI assistant configs — but not itself. This means running `/brycen:update` in any project installed from this template fails because the script it tries to execute doesn't exist.

## What Changes

- Modify the update mechanism to download and execute the installer script from the remote repository on-demand, rather than relying on a local copy that doesn't exist in installed projects
- Update the self-update skill (`SKILL.md`) to fetch the install script from GitHub before executing it, making the process self-healing
- Update the self-update spec to reflect that updates use a remote-fetched script instead of a local one

## Capabilities

### New Capabilities

_None_

### Modified Capabilities

- `self-update`: Update mechanism must fetch the installer from remote rather than execute a local file that doesn't exist in installed projects

## Impact

- `.opencode/skills/brycen-update/SKILL.md` — update execution step to download-then-execute
- `.claude/skills/brycen-update/SKILL.md` — same change (mirrored)
- `.gemini/skills/brycen-update/SKILL.md` — same change (mirrored)
- `.kilocode/skills/brycen-update/SKILL.md` — same change (mirrored)
- `.codex/skills/brycen-update/SKILL.md` — same change (mirrored)
- `openspec/specs/self-update/spec.md` — update scenario to reflect remote-fetch approach