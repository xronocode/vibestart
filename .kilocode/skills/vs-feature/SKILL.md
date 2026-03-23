# Skill: vs-feature

Enable or disable features in vs.project.toml.

## Usage

### List available features
```
$vs-feature list
```

### Enable feature
```
$vs-feature enable conport
$vs-feature on conport
```

### Disable feature
```
$vs-feature disable conport
$vs-feature off conport
```

### Show feature details
```
$vs-feature info conport
```

## Available Features

| Feature | Description | Dependencies |
|---------|-------------|--------------|
| `grace` | GRACE framework with docs/*.xml | none |
| `session_log` | SESSION_LOG.md + TASK_LOG.md | none |
| `conport` | ConPort MCP for long-term memory | uv, MCP setup |
| `design_first` | Plan before code | none |
| `batch_mode` | Autonomous task execution | session_log |
| `time_tracking` | Log agent sessions | conport |

## Output Examples

### List features
```
=== AVAILABLE FEATURES ===

✅ grace          - GRACE framework [ENABLED]
✅ session_log    - Session continuity [ENABLED]
❌ conport        - Long-term memory [DISABLED]
✅ design_first   - Plan before code [ENABLED]
✅ batch_mode     - Autonomous execution [ENABLED]
❌ time_tracking  - Session tracking [DISABLED]

Usage: $vs-feature enable <name>
```

### Enable feature
```
$vs-feature enable conport

[Setup] Enabling conport...

⚠️  ConPort requires:
  - uv installed
  - VS Code reload after setup

Checking dependencies:
  ✅ uv available
  ✅ MCP supported

Creating:
  ✅ .kilocode/mcp_settings.json

Updating:
  ✅ vs.project.toml: features.conport = true

⏳ Next steps:
  1. Reload VS Code (Ctrl+Shift+P → Reload Window)
   2. Run `/grace-status` to verify

```

### Disable feature
```
$vs-feature disable conport

[Setup] Disabling conport...

Updating:
  ✅ vs.project.toml: features.conport = false

Note: MCP settings preserved in .kilocode/mcp_settings.json
Delete manually if not needed.
```

### Feature info
```
$vs-feature info conport

=== FEATURE: conport ===

Name: ConPort MCP
Description: Long-term memory for AI agents using SQLite

Status: DISABLED

Dependencies:
  - uv (Python package manager)
  - MCP (Model Context Protocol)
  - VS Code reload required

Conflicts: none

Storage: context_portal/context.db

When to use:
  - Long-running projects with multiple sessions
  - Need to remember decisions across sessions
  - Want semantic search over project context

When NOT to use:
  - Quick one-off projects
  - Don't want external dependencies
  - Prefer file-based session logs only

To enable: $vs-feature enable conport
```

## Dependency Handling

When enabling a feature with dependencies:

1. Check if dependencies are met
2. If not, either:
   - Auto-enable dependency features (if safe)
   - Prompt user to enable dependencies first
   - Abort with instructions

Example:
```
$vs-feature enable time_tracking

⚠️  time_tracking requires: conport

Enable conport first:
  $vs-feature enable conport

Or enable both:
  $vs-feature enable conport time_tracking
```
