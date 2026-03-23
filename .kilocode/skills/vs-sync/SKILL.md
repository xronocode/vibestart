# Skill: vs-sync

Synchronize AGENTS.md and other files from vs.project.toml configuration.

## Purpose

When vs.project.toml changes, AGENTS.md and other files may need to be regenerated to reflect the new configuration.

## Usage

### Sync all
```
$vs-sync
```

### Sync specific
```
$vs-sync agents
$vs-sync gitignore
$vs-sync macros
```

### Preview changes
```
$vs-sync --dry-run
```

## What Gets Synced

### AGENTS.md
Generated from:
- vs.project.toml features
- vs.project.toml policies
- vs.project.toml session config
- GRACE markup reference

Sections generated:
- Configuration header
- Session management rules
- Tool context transparency
- GRACE macros reference
- Critical policies

### .gitignore
Adds entries for:
- `docs/ai/private-rules.local.md` (if optional_local_overrides set)
- `context_portal/` (if conport enabled)
- `context.db` (if conport enabled)

### docs/grace-macros.md
Regenerates if:
- GRACE feature enabled/disabled
- Macros changed

### docs/BATCH_TASKS.md
Creates template if:
- batch_mode enabled
- File doesn't exist

## Output

```
=== VIBESTART SYNC ===

[Config] Reading vs.project.toml...
  Features: grace, session_log, design_first, batch_mode
  ConPort: disabled

[Sync] AGENTS.md
  Checking current AGENTS.md...
  Differences found:
    - Session config outdated
    - Missing batch mode section
  Regenerating AGENTS.md...
  ✅ Updated

[Sync] .gitignore
  Checking .gitignore...
  Missing entries:
    - docs/ai/private-rules.local.md
  Adding entries...
  ✅ Updated

[Sync] docs/BATCH_TASKS.md
  File missing, creating template...
  ✅ Created

[Sync] docs/grace-macros.md
  No changes needed
  ✅ Skipped

=== SYNC COMPLETE ===

Files updated: 3
Files skipped: 1

Commit changes: git add AGENTS.md .gitignore docs/BATCH_TASKS.md
```

## When to Run

Run `$vs-sync` after:
- Editing vs.project.toml manually
- Running `$vs-feature enable/disable`
- Running `$vs-init`
- Cloning project from repo

## Dry Run

```
$vs-sync --dry-run

=== VIBESTART SYNC (DRY RUN) ===

Would update:
  - AGENTS.md (session config outdated)
  - .gitignore (missing 1 entry)
  - docs/BATCH_TASKS.md (would create)

No files modified.
```

## Notes

- Always shows diff before modifying files
- Creates backups of AGENTS.md before overwriting
- Preserves custom sections in AGENTS.md (marked with <!-- CUSTOM -->)
