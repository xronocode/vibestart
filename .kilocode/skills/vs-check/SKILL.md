# Skill: vs-check

Validate configuration consistency and detect drift.

## Purpose

Detect when:
- vs.project.toml and AGENTS.md are out of sync
- GRACE artifacts are missing or stale
- Session files are corrupted
- Features have missing dependencies

## Usage

### Full check
```
$vs-check
```

### Quick check
```
$vs-check --quick
```

### Specific checks
```
$vs-check config
$vs-check grace
$vs-check session
$vs-check features
```

## Checks Performed

### 1. Config Consistency
- vs.project.toml is valid TOML
- All required fields present
- No conflicting settings

### 2. AGENTS.md Sync
- AGENTS.md matches vs.project.toml
- All enabled features documented
- Policies match

### 3. GRACE Artifacts
- All docs/*.xml present
- XML is valid
- Knowledge graph references valid modules
- Development plan references valid phases

### 4. Session Files
- SESSION_LOG.md format valid
- TASK_LOG.md no orphaned tasks
- No interrupted sessions without resolution

### 5. Feature Dependencies
- All enabled features have dependencies met
- No orphaned configurations

### 6. File References
- local_overrides files exist
- optional_local_overrides in .gitignore

## Output

### All healthy
```
=== VIBESTART CHECK ===

[Config] vs.project.toml
  ✅ Valid TOML
  ✅ All required fields present

[Sync] AGENTS.md
  ✅ Synced with config

[GRACE] Artifacts
  ✅ docs/knowledge-graph.xml
  ✅ docs/requirements.xml
  ✅ docs/technology.xml
  ✅ docs/development-plan.xml
  ✅ docs/verification-plan.xml

[Session] Files
  ✅ SESSION_LOG.md format valid
  ✅ TASK_LOG.md no orphaned tasks

[Features] Dependencies
  ✅ grace: no dependencies
  ✅ session_log: no dependencies
  ✅ batch_mode: requires session_log ✅

[Files] References
  ✅ docs/ai/project-rules.md exists
  ✅ docs/ai/private-rules.local.md in .gitignore

=== ALL CHECKS PASSED ===
```

### Issues found
```
=== VIBESTART CHECK ===

[Config] vs.project.toml
  ✅ Valid TOML
  ✅ All required fields present

[Sync] AGENTS.md
  ❌ OUT OF SYNC
     - Missing batch_mode documentation
     - Session config outdated
     
  Fix: $vs-sync

[GRACE] Artifacts
  ✅ docs/knowledge-graph.xml
  ❌ docs/requirements.xml MISSING
  ✅ docs/technology.xml
  ✅ docs/development-plan.xml
  ✅ docs/verification-plan.xml

  Fix: $grace-init

[Session] Files
  ⚠️  TASK_LOG.md has orphaned task at line 15
     - Task marked IN_PROGRESS but no session active
     
  Fix: Review and update TASK_LOG.md manually

[Features] Dependencies
  ❌ time_tracking requires conport (disabled)
  
  Fix: $vs-feature disable time_tracking
    OR: $vs-feature enable conport

=== CHECKS FAILED ===

Issues: 3 errors, 1 warning

Fix commands:
  1. $vs-sync
  2. $grace-init
  3. $vs-feature disable time_tracking
```

## Exit Codes

- 0: All checks passed
- 1: Warnings only
- 2: Errors found

## CI/CD Integration

Can be used in CI pipelines:

```yaml
# .github/workflows/check.yml
- name: Check vibestart config
  run: npx skills run vs-check
```

## Auto-fix

Some issues can be auto-fixed:
```
$vs-check --fix
```

Auto-fixes:
- Sync AGENTS.md
- Create missing GRACE artifacts
- Disable features with missing dependencies

Does NOT auto-fix:
- Orphaned tasks in TASK_LOG.md
- Invalid XML structure
- Custom rules files
