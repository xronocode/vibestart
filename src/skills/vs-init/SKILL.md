---
name: vs-init
description: "Smart initialization with comprehensive conflict detection, framework integrity check, and migration support"
---

# vs-init Skill

Initialize vibestart in a project with intelligent conflict detection and resolution.

## Overview

vs-init performs:
1. **Framework Integrity Check** — verifies all components exist
2. **Conflict Detection** — finds 6 types of conflicts
3. **Conflict Resolution** — offers options, creates backups
4. **Missing Pieces Detection** — finds and repairs absent components
5. **Project Initialization** — creates all required files
6. **Migration Support** — upgrades from v1.0 or grace-marketplace

## Execution Flow

```
Phase 1/6: Framework Integrity Check (7 checks)
Phase 2/6: Conflict Detection (6 types)
Phase 3/6: Resolution Summary
Phase 4/6: Execute Resolution
Phase 5/6: Render AGENTS.md (automatic)
Phase 6/6: Project Integrity Verification
```

---

## Integrated AGENTS.md Rendering

vs-init automatically renders AGENTS.md from fragments as part of initialization. This eliminates the need for a separate vs-render command.

**When rendering happens:**
- At the end of every successful vs-init execution
- After configuration changes (re-run vs-init)
- After enabling/disabling features (re-run vs-init)

**Render process:**
1. Load vs.project.toml configuration
2. Load fragments based on enabled features
3. Load project-specific overrides
4. Assemble and write AGENTS.md
5. Create backup of previous version if exists

---

## Phase 1: Framework Integrity Check

### Step 1.1: Detect Agent

```
[SKILL:vs-init] Phase 1/5: Framework Integrity Check
[SYSTEM] Detecting AI agent...

Detected agents:
  ✓ Kilo Code (.kilocode/config.json)
  ✓ Cursor (.cursorrules)

Agent skills paths:
  • Kilo Code: ~/.kilocode/skills/
  • Cursor: ~/.cursor/skills/
```

### Step 1.2: Check Framework Installation

```
[SYSTEM] Checking framework installation...

Required paths:
  ✓ ~/.vibestart/framework/
  ✓ ~/.vibestart/framework/standards/
  ✓ ~/.vibestart/framework/templates/
  ✓ ~/.vibestart/framework/skills/
  ✓ ~/.vibestart/framework/fragments/

OR

[SYSTEM] Checking framework installation...
  ✗ ~/.vibestart/framework/ NOT FOUND

╔═══════════════════════════════════════════════════════════════╗
║                    FRAMEWORK NOT INSTALLED                      ║
╠═══════════════════════════════════════════════════════════════╣
║                                                                ║
║  vibestart framework is not installed or corrupted.           ║
║                                                                ║
║  Options:                                                      ║
║    [1] Download from GitHub (xronocode/vibestart)             ║
║    [2] Copy from development project                          ║
║    [3] Repair missing components only                         ║
║                                                                ║
╚═══════════════════════════════════════════════════════════════╝

Your choice [1/2/3]:
```

### Step 1.3: Check Global Configuration

```
[SYSTEM] Checking global configuration...

Required files:
  ✓ ~/.vibestart/global-defaults.toml
  ✓ ~/.vibestart/skills-registry.json
  ✓ ~/.vibestart/projects-registry.json

OR

[SYSTEM] Checking global configuration...
  ✗ ~/.vibestart/global-defaults.toml MISSING
  ✗ ~/.vibestart/skills-registry.json MISSING
  ✗ ~/.vibestart/projects-registry.json MISSING

[SKILL:vs-init] Creating global configuration...
  ✓ Created ~/.vibestart/global-defaults.toml
  ✓ Created ~/.vibestart/skills-registry.json
  ✓ Created ~/.vibestart/projects-registry.json
```

### Step 1.4: Check Standards Integrity

```
[SYSTEM] Checking standards integrity...

Required standards:
  ✓ grace (v2.0.0)
  ✓ architecture (v1.0.0)
  ✓ error-handling (v1.0.0)
  ✓ git-workflow (v1.0.0)
  ✓ agent-transparency (v1.0.0)
  ✓ compatibility (v1.0.0)

OR

[SYSTEM] Checking standards integrity...
  ✓ grace
  ✗ architecture MISSING
  ✓ error-handling
  ✗ agent-transparency MISSING

╔═══════════════════════════════════════════════════════════════╗
║                    MISSING STANDARDS                            ║
╠═══════════════════════════════════════════════════════════════╣
║                                                                ║
║  Missing:                                                      ║
║    • architecture                                              ║
║    • agent-transparency                                        ║
║                                                                ║
║  Options:                                                      ║
║    [1] Download missing from repository                       ║
║    [2] Skip (not recommended)                                  ║
║                                                                ║
╚═══════════════════════════════════════════════════════════════╝

Your choice [1/2]:
```

### Step 1.5: Check Templates Integrity

```
[SYSTEM] Checking templates integrity...

Required templates:
  ✓ development-plan.xml.template
  ✓ requirements.xml.template
  ✓ knowledge-graph.xml.template
  ✓ verification-plan.xml.template
  ✓ technology.xml.template
  ✓ decisions.xml.template
```

### Step 1.6: Check Skills Integrity

```
[SYSTEM] Checking skills in agent...

Agent: Kilo Code
Skills path: ~/.kilocode/skills/

Required skills:
  ✓ vs-init (v2.0.0)

Optional skills (GRACE):
  ✓ grace-init (vibestart v2.0.0)
  ✓ grace-plan (vibestart v2.0.0)
  ✓ grace-execute (vibestart v2.0.0)
  ✓ grace-status (vibestart v2.0.0)
  ✓ grace-refresh (vibestart v2.0.0)
```

### Step 1.7: Check Fragments Integrity

```
[SYSTEM] Checking fragments integrity...

Core fragments:
  ✓ core/architecture.md
  ✓ core/error-handling.md
  ✓ core/git-workflow.md
  ✓ core/agent-transparency.md

Process fragments:
  ✓ process/design-first.md
  ✓ process/batch-mode.md
  ✓ process/session-management.md

Stack fragments:
  ✓ stacks/typescript.md
  ✓ stacks/python.md
  ✓ stacks/react.md
```

---

## Phase 2: Conflict Detection

```
[SKILL:vs-init] Phase 2/5: Conflict Detection
```

### Check 2.1: Skills Conflicts (CONF-001)

```
[SYSTEM] Scanning for skill conflicts...

Scanning:
  • ~/.kilocode/skills/
  • .kilocode/skills/
  • .cursor/skills/

Found skills:
  • grace-init (grace-marketplace v1.0.0) at ~/.kilocode/skills/grace-init
  • grace-plan (grace-marketplace v1.0.0) at ~/.kilocode/skills/grace-plan
  • grace-execute (grace-marketplace v1.0.0) at ~/.kilocode/skills/grace-execute

vibestart v2.0 provides enhanced versions:
  • grace-init v2.0.0 (with vs-init integration)
  • grace-plan v2.0.0 (with templates)
  • grace-execute v2.0.0 (with session logging)

╔═══════════════════════════════════════════════════════════════╗
║                    [CONF-001] DUPLICATE SKILLS                  ║
╠═══════════════════════════════════════════════════════════════╣
║                                                                ║
║  Found 3 skills from grace-marketplace                        ║
║  vibestart v2.0 has enhanced versions                         ║
║                                                                ║
║  Resolution options:                                           ║
║    [1] vibestart-override (RECOMMENDED)                       ║
║        → Backup originals to ~/.vibestart/backups/            ║
║        → Install vibestart v2.0 versions                      ║
║                                                                ║
║    [2] keep-original                                           ║
║        → Keep grace-marketplace skills                        ║
║        → Only add vs-* skills                                 ║
║                                                                ║
║    [3] merge-manual                                            ║
║        → Review each conflict manually                        ║
║                                                                ║
╚═══════════════════════════════════════════════════════════════╝

Your choice [1/2/3]:
```

### Check 2.2: AGENTS.md Conflict (CONF-002)

```
[SYSTEM] Checking AGENTS.md...

File: AGENTS.md (287 lines)

Analysis:
  ✓ Contains "GRACE Framework"
  ✗ No vibestart generation marker
  ✓ Contains session management rules
  ✓ Contains semantic markup reference

Scenario: S1 - Manual or another framework (High risk)

╔═══════════════════════════════════════════════════════════════╗
║                    [CONF-002] AGENTS.md CONFLICT               ║
╠═══════════════════════════════════════════════════════════════╣
║                                                                ║
║  This AGENTS.md appears to be manually created or from        ║
║  another framework (grace-marketplace).                       ║
║                                                                ║
║  Resolution options:                                           ║
║    [1] backup-and-regenerate                                   ║
║        → Save to AGENTS.md.backup                              ║
║        → Generate new from vibestart fragments                ║
║                                                                ║
║    [2] keep-add-marker                                         ║
║        → No content changes                                    ║
║        → Add generation metadata                               ║
║                                                                ║
║    [3] merge-preserve-custom (RECOMMENDED)                     ║
║        → Extract custom sections                               ║
║        → Generate base from fragments                          ║
║        → Merge custom rules back                               ║
║                                                                ║
║    [4] keep-original                                           ║
║        → No changes                                            ║
║                                                                ║
╚═══════════════════════════════════════════════════════════════╝

Your choice [1/2/3/4]:
```

### Check 2.3: Configuration Conflict (CONF-003)

```
[SYSTEM] Checking configuration files...

Found:
  • vs.project.toml (vibestart config)
  • .cursorrules (Cursor rules)
  • .kilocode/config.json (Kilo Code config)

Analysis:
  • vs.project.toml: features.grace=true, session_log=true
  • .cursorrules: different session format
  • .kilocode/config.json: no GRACE reference

╔═══════════════════════════════════════════════════════════════╗
║                    [CONF-003] CONFIGURATION CONFLICT           ║
╠═══════════════════════════════════════════════════════════════╣
║                                                                ║
║  Multiple configuration files with potentially overlapping    ║
║  settings detected.                                           ║
║                                                                ║
║  Resolution options:                                           ║
║    [1] consolidate (RECOMMENDED)                               ║
║        → vs.project.toml as master                             ║
║        → Other files add reference                             ║
║                                                                ║
║    [2] keep-separate                                           ║
║        → May cause drift over time                             ║
║                                                                ║
║    [3] review-manual                                           ║
║        → Manual review of each conflict                       ║
║                                                                ║
╚═══════════════════════════════════════════════════════════════╝

Your choice [1/2/3]:
```

### Check 2.4: GRACE Artifacts Conflict (CONF-004)

```
[SYSTEM] Checking docs/*.xml...

Found:
  ✓ docs/development-plan.xml (VERSION="0.2.0", grace-marketplace format)
  ✓ docs/knowledge-graph.xml (VERSION="0.1.0")
  ✓ docs/verification-plan.xml (VERSION="0.1.0")
  ✗ docs/requirements.xml MISSING
  ✗ docs/technology.xml MISSING
  ✗ docs/decisions.xml MISSING

Scenario: grace-marketplace format, missing v2.0 files

╔═══════════════════════════════════════════════════════════════╗
║                    [CONF-004] GRACE ARTIFACTS CONFLICT         ║
╠═══════════════════════════════════════════════════════════════╣
║                                                                ║
║  Existing files use grace-marketplace format.                 ║
║  vibestart v2.0 uses enhanced format.                         ║
║  Some required files are missing.                             ║
║                                                                ║
║  Resolution options:                                           ║
║    [1] migrate (RECOMMENDED)                                   ║
║        → Backup originals                                      ║
║        → Convert structure to v2.0                             ║
║        → Add missing files                                     ║
║                                                                ║
║    [2] keep-add-missing                                        ║
║        → No format changes                                     ║
║        → Create missing files only                             ║
║                                                                ║
║    [3] full-reset                                              ║
║        → Replace all with vibestart templates                  ║
║        ⚠️ LOSES EXISTING CONTENT                               ║
║                                                                ║
╚═══════════════════════════════════════════════════════════════╝

Your choice [1/2/3]:
```

### Check 2.5: Session Log Conflict (CONF-005)

```
[SYSTEM] Checking session logs...

Found:
  • docs/SESSION_LOG.md (different format)
  • docs/TASK_LOG.md (different format)

Format mismatch: Current format differs from vibestart template

╔═══════════════════════════════════════════════════════════════╗
║                    [CONF-005] SESSION LOG CONFLICT             ║
╠═══════════════════════════════════════════════════════════════╣
║                                                                ║
║  Resolution options:                                           ║
║    [1] migrate-format (RECOMMENDED)                            ║
║        → Preserve content                                      ║
║        → Update structure                                      ║
║                                                                ║
║    [2] keep-existing                                           ║
║        → No changes                                            ║
║                                                                ║
║    [3] archive-fresh                                           ║
║        → Archive old logs                                      ║
║        → Start fresh                                           ║
║                                                                ║
╚═══════════════════════════════════════════════════════════════╝

Your choice [1/2/3]:
```

### Check 2.6: Gitignore Conflict (CONF-006)

```
[SYSTEM] Checking .gitignore...

Found: .gitignore

Missing entries:
  ✗ docs/ai/private-rules.local.md
  ✗ .env*.local
  ✗ context_portal/

╔═══════════════════════════════════════════════════════════════╗
║                    [CONF-006] GITIGNORE INCOMPLETE             ║
╠═══════════════════════════════════════════════════════════════╣
║                                                                ║
║  Add missing entries to .gitignore?                           ║
║                                                                ║
║  [Y/n]                                                         ║
║                                                                ║
╚═══════════════════════════════════════════════════════════════╝
```

---

## Phase 3: Resolution Summary

```
[SKILL:vs-init] Phase 3/5: Resolution Summary
```

```
╔═══════════════════════════════════════════════════════════════════════╗
║                    CONFLICT RESOLUTION SUMMARY                         ║
╠═══════════════════════════════════════════════════════════════════════╣
║                                                                        ║
║ [CONF-001] Skills Conflict                                             ║
║   Resolution: vibestart-override                                       ║
║   Action: Backup to ~/.vibestart/backups/, install v2.0               ║
║                                                                        ║
║ [CONF-002] AGENTS.md Conflict                                          ║
║   Resolution: merge-preserve-custom                                    ║
║   Action: Extract custom, generate base, merge                         ║
║                                                                        ║
║ [CONF-003] Configuration Conflict                                      ║
║   Resolution: consolidate                                              ║
║   Action: vs.project.toml as master, others reference                  ║
║                                                                        ║
║ [CONF-004] GRACE Artifacts Conflict                                    ║
║   Resolution: migrate                                                  ║
║   Action: Backup, convert to v2.0, add missing                         ║
║                                                                        ║
║ [CONF-005] Session Log Conflict                                        ║
║   Resolution: migrate-format                                           ║
║   Action: Preserve content, update structure                           ║
║                                                                        ║
║ [CONF-006] Gitignore Incomplete                                        ║
║   Resolution: add-missing                                              ║
║   Action: Append required entries                                      ║
║                                                                        ║
╠═══════════════════════════════════════════════════════════════════════╣
║                                                                        ║
║  Backups will be created in:                                           ║
║    • ~/.vibestart/backups/                                             ║
║    • docs/.backup/                                                     ║
║    • AGENTS.md.backup                                                  ║
║                                                                        ║
║  Proceed with resolution? [Y/n]                                        ║
║                                                                        ║
╚═══════════════════════════════════════════════════════════════════════╝
```

---

## Phase 4: Execute Resolution

```
[SKILL:vs-init] Phase 4/5: Executing Resolution
```

### Execute CONF-001: Skills

```
[SKILL:vs-init] Resolving [CONF-001] Skills Conflict...
[STANDARD:compatibility] Resolution: vibestart-override

[TOOL:filesystem] Backing up original skills...
  ✓ grace-init → ~/.vibestart/backups/grace-init-1.0.0/
  ✓ grace-plan → ~/.vibestart/backups/grace-plan-1.0.0/
  ✓ grace-execute → ~/.vibestart/backups/grace-execute-1.0.0/

[TOOL:filesystem] Installing vibestart v2.0 skills...
  ✓ Copying grace-init v2.0.0 → ~/.kilocode/skills/grace-init
  ✓ Copying grace-plan v2.0.0 → ~/.kilocode/skills/grace-plan
  ✓ Copying grace-execute v2.0.0 → ~/.kilocode/skills/grace-execute

[TOOL:filesystem] Updating skills-registry.json...
  ✓ Updated source: vibestart
  ✓ Added conflict resolution record

✅ Done: Skills conflict resolved
```

### Execute CONF-002: AGENTS.md

```
[SKILL:vs-init] Resolving [CONF-002] AGENTS.md Conflict...
[STANDARD:compatibility] Resolution: merge-preserve-custom

[TOOL:filesystem] Backing up...
  ✓ AGENTS.md → AGENTS.md.backup

[SKILL:vs-init] Extracting custom sections...
  Found custom sections:
    • Project-specific API rules
    • Custom logging format
    • Team conventions

[SKILL:vs-init] Generating base from fragments...
  ✓ Loading core/ fragments
  ✓ Loading process/ fragments
  ✓ Loading stacks/typescript.md
  ✓ Generated base AGENTS.md

[TOOL:filesystem] Merging custom sections...
  ✓ Appended "Project-Specific Rules" section
  ✓ Preserved 3 custom sections

✅ Done: AGENTS.md merged with custom rules preserved
```

### Execute CONF-003: Configuration

```
[SKILL:vs-init] Resolving [CONF-003] Configuration Conflict...
[STANDARD:compatibility] Resolution: consolidate

[TOOL:filesystem] Updating configuration files...
  ✓ vs.project.toml unchanged (master)
  ✓ .cursorrules: Added reference to vs.project.toml
  ✓ .kilocode/config.json: Added vibestart reference

✅ Done: Configuration consolidated
```

### Execute CONF-004: GRACE Artifacts

```
[SKILL:vs-init] Resolving [CONF-004] GRACE Artifacts Conflict...
[STANDARD:compatibility] Resolution: migrate

[TOOL:filesystem] Backing up existing files...
  ✓ docs/development-plan.xml → docs/.backup/development-plan.xml
  ✓ docs/knowledge-graph.xml → docs/.backup/knowledge-graph.xml
  ✓ docs/verification-plan.xml → docs/.backup/verification-plan.xml

[STANDARD:grace] Migrating to v2.0 format...
  ✓ docs/development-plan.xml: Added unique tags, updated VERSION
  ✓ docs/knowledge-graph.xml: Added CrossLinks, updated structure
  ✓ docs/verification-plan.xml: Added phase-gates

[TOOL:filesystem] Creating missing files from templates...
  ✓ docs/requirements.xml (from template)
  ✓ docs/technology.xml (from template)
  ✓ docs/decisions.xml (from template)

✅ Done: GRACE artifacts migrated and complete
```

### Execute CONF-005: Session Logs

```
[SKILL:vs-init] Resolving [CONF-005] Session Log Conflict...
[STANDARD:compatibility] Resolution: migrate-format

[TOOL:filesystem] Migrating session logs...
  ✓ docs/SESSION_LOG.md: Preserved content, updated structure
  ✓ docs/TASK_LOG.md: Preserved tasks, updated format

✅ Done: Session logs migrated
```

### Execute CONF-006: Gitignore

```
[SKILL:vs-init] Resolving [CONF-006] Gitignore Conflict...
[STANDARD:compatibility] Resolution: add-missing

[TOOL:filesystem] Updating .gitignore...
  ✓ Added: docs/ai/private-rules.local.md
  ✓ Added: .env*.local
  ✓ Added: context_portal/

✅ Done: Gitignore updated
```

---

## Phase 5: Render AGENTS.md (Automatic)

```
[SKILL:vs-init] Phase 5/6: Rendering AGENTS.md from fragments...
```

### Step 5.1: Load Configuration

```
[SKILL:vs-init] Loading vs.project.toml...

Configuration loaded:
  • Project: my-project
  • Features: grace, session_log, batch_mode
  • Stack: typescript, node, fastify
  • Local overrides: docs/ai/project-rules.md (if exists)
  • Private overrides: docs/ai/private-rules.local.md (if exists)
```

### Step 5.2: Load and Assemble Fragments

```
[SKILL:vs-init] Loading fragments based on configuration...

Loading fragments:
  ✓ core/architecture.md (always)
  ✓ core/error-handling.md (always)
  ✓ core/git-workflow.md (always)
  ✓ core/agent-transparency.md (always)
  ✓ process/design-first.md (feature: design_first)
  ✓ process/batch-mode.md (feature: batch_mode)
  ✓ process/session-management.md (feature: session_log)
  ✓ knowledge/grace-activation.md (feature: grace)
  ✓ stacks/typescript.md (stack: typescript)
  ✓ stacks/node.md (stack: node)
  ✓ stacks/fastify.md (stack: fastify)
```

### Step 5.3: Write AGENTS.md

```
[SKILL:vs-init] Writing AGENTS.md...

Checking for existing AGENTS.md...
  → Found: AGENTS.md (existing)
  → Creating backup: AGENTS.md.backup

Writing new AGENTS.md...
  ✓ 450 lines written
  ✓ Generation marker added
  ✓ Timestamp: 2026-03-23T16:00:00Z
```

---

## Phase 6: Project Integrity Verification

```
[SKILL:vs-init] Phase 6/6: Project Integrity Verification
```

```
[SYSTEM] Verifying project integrity...

FRAMEWORK:
  ✓ vibestart v2.0.0 installed
  ✓ Standards: 6/6 present
  ✓ Templates: 6/6 present
  ✓ Skills: 1/1 required (vs-init)
  ✓ Fragments: 10/10 present

GLOBAL:
  ✓ ~/.vibestart/global-defaults.toml
  ✓ ~/.vibestart/skills-registry.json
  ✓ ~/.vibestart/projects-registry.json

PROJECT:
  ✓ vs.project.toml
  ✓ AGENTS.md (generated from fragments)
  ✓ docs/development-plan.xml (v2.0)
  ✓ docs/requirements.xml
  ✓ docs/knowledge-graph.xml (v2.0)
  ✓ docs/verification-plan.xml (v2.0)
  ✓ docs/technology.xml
  ✓ docs/decisions.xml
  ✓ docs/SESSION_LOG.md
  ✓ docs/TASK_LOG.md
  ✓ .gitignore (complete)

AGENT INTEGRATION:
  ✓ Kilo Code detected
  ✓ Skills: ~/.kilocode/skills/
  ✓ grace-* skills accessible (v2.0)

CONFLICTS:
  ✓ 6 detected, 6 resolved
  ✓ Backups created in ~/.vibestart/backups/

╔═══════════════════════════════════════════════════════════════════════╗
║                    INITIALIZATION COMPLETE                             ║
╠═══════════════════════════════════════════════════════════════════════╣
║                                                                        ║
║  Project: my-project                                                   ║
║  Framework: vibestart v2.0.0                                           ║
║  Agent: Kilo Code                                                      ║
║                                                                        ║
║  Conflicts resolved: 6                                                 ║
║  Backups created: ~/.vibestart/backups/                                ║
║  AGENTS.md: Generated from fragments (450 lines)                        ║
║                                                                        ║
║  ✅ Done: Project initialized successfully                             ║
║  ⏳ Next: Run /grace-status to verify setup                            ║
║           Run /grace-init to start GRACE workflow                      ║
║                                                                        ║
╚═══════════════════════════════════════════════════════════════════════╝
```
[SKILL:vs-init] Phase 5/5: Project Integrity Verification
```

```
[SYSTEM] Verifying project integrity...

FRAMEWORK:
  ✓ vibestart v2.0.0 installed
  ✓ Standards: 6/6 present
  ✓ Templates: 6/6 present
  ✓ Skills: 4/4 required, 8/8 optional
  ✓ Fragments: 10/10 present

GLOBAL:
  ✓ ~/.vibestart/global-defaults.toml
  ✓ ~/.vibestart/skills-registry.json
  ✓ ~/.vibestart/projects-registry.json

PROJECT:
  ✓ vs.project.toml
  ✓ AGENTS.md (generated, with custom rules)
  ✓ docs/development-plan.xml (v2.0)
  ✓ docs/requirements.xml
  ✓ docs/knowledge-graph.xml (v2.0)
  ✓ docs/verification-plan.xml (v2.0)
  ✓ docs/technology.xml
  ✓ docs/decisions.xml
  ✓ docs/SESSION_LOG.md
  ✓ docs/TASK_LOG.md
  ✓ .gitignore (complete)

AGENT INTEGRATION:
  ✓ Kilo Code detected
  ✓ Skills: ~/.kilocode/skills/
  ✓ vs-* skills accessible
  ✓ grace-* skills accessible (v2.0)

CONFLICTS:
  ✓ 6 detected, 6 resolved
  ✓ Backups created in ~/.vibestart/backups/

╔═══════════════════════════════════════════════════════════════════════╗
║                    INITIALIZATION COMPLETE                             ║
╠═══════════════════════════════════════════════════════════════════════╣
║                                                                        ║
║  Project: my-project                                                   ║
║  Framework: vibestart v2.0.0                                           ║
║  Agent: Kilo Code                                                      ║
║                                                                        ║
║  Conflicts resolved: 6                                                 ║
║  Backups created: ~/.vibestart/backups/                                ║
║  Custom rules preserved: 3 sections                                    ║
║                                                                        ║
║  ✅ Done: Project initialized successfully                             ║
║  ⏳ Next: Run /grace-status to verify setup                            ║
║           Run /grace-init to start GRACE workflow                      ║"
║                                                                        ║
╚═══════════════════════════════════════════════════════════════════════╝
```

---

## Migration Mode

### From v1.0

```
/vs-init --migrate
```

```
[SKILL:vs-init] Migration mode: v1.0 → v2.0

Detected v1.0 artifacts:
  ✓ AGENTS.md (v1.0 format, manual)
  ✓ docs/development-plan.xml (v1.0 format)
  ✓ docs/knowledge-graph.xml (v1.0 format)
  ✓ docs/verification-plan.xml (v1.0 format)

Migration plan:
  1. Backup all v1.0 files to .vibestart-v1-backup/
  2. Create vs.project.toml from AGENTS.md analysis
  3. Convert docs/*.xml to v2.0 format
  4. Generate new AGENTS.md from fragments
  5. Create missing files (requirements.xml, technology.xml, decisions.xml)
  6. Update .gitignore

Proceed with migration? [Y/n]:
```

### From grace-marketplace

```
/vs-init
```

vs-init will automatically detect grace-marketplace and offer migration options.

---

## Clean Install

For a new project with no existing GRACE:

```
/vs-init
```

```
[SKILL:vs-init] Clean install detected

No conflicts found. Proceeding with full initialization...

Step 1/6: Creating vs.project.toml...
  ✓ Detected stack: typescript, node
  ✓ vs.project.toml created

Step 2/6: Creating docs/ directory...
  ✓ All 6 XML files created from templates

Step 3/6: Rendering AGENTS.md...
  ✓ Loading fragments based on configuration
  ✓ AGENTS.md generated from fragments

Step 4/6: Creating support files...
  ✓ SESSION_LOG.md, TASK_LOG.md created
  ✓ .gitignore updated

Step 5/6: Registering project...
  ✓ Added to projects-registry.json

Step 6/6: Final verification...
  ✓ Project initialized successfully

✅ Done: Project initialized
```

---

## ConPort Option

```
[SKILL:vs-init] Checking MCP servers...

ConPort: not configured

╔═══════════════════════════════════════════════════════════════╗
║                    CONPORT (OPTIONAL)                          ║
╠═══════════════════════════════════════════════════════════════╣
║                                                                ║
║  ConPort provides:                                            ║
║    • Long-term memory for decisions                           ║
║    • Session context persistence                              ║
║    • Semantic search across project                           ║
║    • Cross-project knowledge sharing                          ║
║                                                                ║
║  Without ConPort, vibestart uses:                             ║
║    • docs/SESSION_LOG.md for session tracking                 ║
║    • docs/decisions.xml for decision storage                  ║
║                                                                ║
║  Recommendation:                                               ║
║    • Solo project → SESSION_LOG is sufficient                 ║
║    • Team/long-term project → ConPort recommended             ║
║                                                                ║
║  Enable ConPort? [y/N]                                         ║
║                                                                ║
╚═══════════════════════════════════════════════════════════════╝

If yes:
  ✓ Creating context_portal/ directory
  ✓ Creating .vscode/mcp.json
  ✓ Adding to vs.project.toml: conport.enabled = true
```
