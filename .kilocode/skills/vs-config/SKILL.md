# Skill: vs-config

View and edit vs.project.toml configuration.

## Commands

### View current configuration
```
$vs-config
$vs-config show
```

Shows:
- Enabled features
- Tool configuration
- Policies
- Rules

### Edit configuration
```
$vs-config edit
```

Opens vs.project.toml in editor or guides through interactive editing.

### Get specific value
```
$vs-config get features.grace
$vs-config get tools.testing.mocking_policy.prefer
```

### Set specific value
```
$vs-config set features.conport true
$vs-config set session.auto_update_log false
```

## Output Format

```
=== VIBESTART CONFIGURATION ===

Project: vibestart
Version: 0.1.0

FEATURES:
  ✅ grace: true
  ✅ session_log: true
  ❌ conport: false
  ✅ design_first: true
  ✅ batch_mode: true
  ❌ time_tracking: false

GRACE:
  markup_style: ts
  verification_first: true

SESSION:
  run_diagnostic: true
  auto_update_log: true

RULES:
  local_overrides: docs/ai/project-rules.md
  optional: docs/ai/private-rules.local.md

POLICIES:
  system_prompts: PLACEHOLDER_ONLY
  rls: ALWAYS_ON

To edit: $vs-config edit
To enable/disable feature: $vs-feature <name> <on|off>
```

## Notes

- Changes to vs.project.toml may require running `$vs-sync` to update AGENTS.md
- Some changes require VS Code reload (e.g., enabling ConPort)
