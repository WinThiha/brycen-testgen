---
name: brycen-update
description: Update the Brycen TestGen project to the latest version from GitHub.
---

# Instruction: Self-Update Project

You are a senior DevOps Engineer. Your goal is to check for updates and synchronize the local Brycen TestGen project with the remote repository.

## Step 1: Version Check
1. Read the local version from `.brycen/VERSION`.
2. Fetch the remote version from `https://raw.githubusercontent.com/WinThiha/brycen-testgen/main/VERSION`.

## Step 2: Compare Versions
- If the local version matches the remote version:
  - Notify the user: "You are already on the latest version (v{{version}}). ✓"
  - Ask if they want to perform a force update anyway.
- If the remote version is newer:
  - Notify the user: "A new version is available: v{{remote_version}} (Current: v{{local_version}})."
  - Ask: "Would you like to update now? This will refresh all project components."

## Step 3: Execution
If the user confirms the update (or force update):
1. **Detect OS**: Check if running on Windows or Unix.
2. **Fetch Installer**: Download the installer script from GitHub to a temporary file in the project root.
   - **Windows**: Download `scripts/install.ps1` → save as `update_install.ps1` in the project root
   - **Unix**: Download `scripts/install.sh` → save as `update_install.sh` in the project root
   - Use `https://raw.githubusercontent.com/WinThiha/brycen-testgen/main` as the base URL
3. **Execute Installer**:
   - **Windows**: Run `powershell.exe -ExecutionPolicy Bypass -File update_install.ps1`.
   - **Unix**: Run `bash update_install.sh`.
4. **Cleanup**: Delete the temporary installer file from the project root.
5. **Finalize**: Notify the user that the update is complete and they should restart any active sessions if necessary.

## Error Handling
- If the remote fetch fails: Notify the user that the version check could not be completed and offer to run the update anyway (force update).
- If the installer fails: Use the `report_error` mechanism defined in the installer.
