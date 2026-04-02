# Changelog

All notable changes to vibestart are documented in this file.

## v3.2.0 - 2026-04-02

### About

vibestart packages GRACE, environment-specific agent setup, marketplace shortcuts, and optional project memory/documentation integrations into one project-local installer.

### Value Pitch

- Start a new AI coding project with one installer instead of hand-assembling prompts, standards, memory, and shell-specific config
- Keep the setup visible in-repo through generated artifacts such as `AGENTS.md`, `.kilo/`, `.claude/`, `.codex/`, `.qwen/`, and docs XML files
- Bind integrations early so ConPort and Entire are available before meaningful work begins
- Use one release for multiple agent shells instead of maintaining separate bootstrap paths

### Change Notes

#### Added

- First-class Codex support across detection, profiles, config generation, shortcuts, and marketplace installation
- Smoke tests for JSON helpers, agent config generators, and `vs-init --dry-run`

#### Fixed

- MCP config generation for Kilo, Claude, and Qwen now writes valid nested `mcpServers` objects
- `vs-init` now re-execs into Bash 4+ on macOS systems where the default shell is too old
- Repeated `ui.sh` sourcing is now idempotent, avoiding shell variable collisions
- Environment profile loading now reflects the selected shell at runtime
- Marketplace install paths now follow the chosen environment instead of defaulting to Kilo paths

#### Changed

- README now carries a clearer product description, value pitch, and 3.2.0 release notes
- Public version surfaces were synchronized to `3.2.0`

#### Compatibility

- No breaking installer flags were introduced in `v3.2.0`
