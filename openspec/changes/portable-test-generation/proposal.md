## Why

Currently, the test case generation capability (`/opsx:test`) is tightly coupled with this template project. Developers need a way to easily install this functionality, including the scripts, command aliases, and AI skills, into any existing project they are working on with minimal manual configuration.

## What Changes

- **Renamed Command Alias**: The command `/opsx:test` is renamed to `/brycen:generate_tests` to provide a personalized, distinct namespace.
- **Smart Installer**: A new cross-platform installation script that probes the user's system for Python (v3.8+) or Node.js (v14+).
- **Isolated Execution**: Implementation of a virtual environment (`.venv`) for Python to prevent global dependency conflicts, or a fallback to `npx` for Node.js users.
- **Artifact Provisioning**: Automatic downloading and placement of Excel templates and AI-specific skill files (`SKILL.md`) into the target project.
- **Error Reporting**: Integrated failure detection that offers to report issues to the maintainer via a pre-populated email.
- **AI Support Expansion**: Support for Gemini, Claude, and OpenCode command configurations.

## Capabilities

### New Capabilities
- `portable-test-installation`: Logic and scripts for installing and configuring the test generation tool across different environments and AI assistants.

### Modified Capabilities
- `test-case-generation`: Updating the existing test generation requirements to reflect the new command name and the transition from a template-specific script to a portable tool.

## Impact

- **Project Configuration**: Affects `.gemini/`, `.claude/`, and `.opencode/` directory structures and command definitions.
- **Script Management**: Moves from project-specific scripts to a distributable package or set of scripts managed by an installer.
- **Dependencies**: Introduces a requirement for `openpyxl` (Python) or a Node.js equivalent, managed through isolated environments.
