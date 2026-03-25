---
name: vs-init
description: "Smart initialization with comprehensive conflict detection, framework integrity check, and migration support"
---

Initialize vibestart in a project with intelligent conflict detection and resolution.

## Prerequisites

Before running vs-init, ensure:
- You are in the project root directory
- The AI agent has filesystem read/write capabilities

## Template Files

All documents MUST be created from template files located in this skill's `assets/` directory.
Read each template file, replace the `$PLACEHOLDER` variables with actual values, and write the result to the target project path.

| Template source                            | Target in project           |
|--------------------------------------------|-----------------------------|
| `assets/vs.project.toml.template`          | `vs.project.toml`           |
| `assets/AGENTS.md.template`                | `AGENTS.md` (project root)  |
| `assets/docs/development-plan.xml.template`| `docs/development-plan.xml` |
| `assets/docs/knowledge-graph.xml.template` | `docs/knowledge-graph.xml`  |
| `assets/docs/requirements.xml.template`    | `docs/requirements.xml`     |
| `assets/docs/technology.xml.template`      | `docs/technology.xml`       |
| `assets/docs/verification-plan.xml.template`| `docs/verification-plan.xml`|
| `assets/docs/decisions.xml.template`       | `docs/decisions.xml`        |

> **Important:** Never hardcode template content inline. Always read from the `.template` files — they are the single source of truth for document structure.

---

## Step 0: Git Checkpoint Safety

Before any file modifications, ensure a safety net exists for rollback.

### 0.1 Check Git Status

```
[SKILL:vs-init] Step 0.1: Checking git status...

Git status:
  • Repository: [yes/no]
  • Clean working directory: [yes/no]
  • Current branch: [branch-name or "N/A"]
```

**Detection Commands:**
- Check for `.git/` directory existence
- Run `git status --porcelain` to detect uncommitted changes
- Run `git symbolic-ref -q HEAD` to detect detached HEAD
- Run `git ls-files -u` to detect merge conflicts

### 0.2 Handle Git Repository State

#### Scenario A: Git Repository with Uncommitted Changes

If `git status --porcelain` returns output (dirty state):

```
╔═══════════════════════════════════════════════════════════════════════════╗
║                    UNCOMMITTED CHANGES DETECTED                           ║
╠═══════════════════════════════════════════════════════════════════════════╣
║                                                                            ║
║  Your project has uncommitted changes that should be saved before          ║
║  vs-init modifies any files.                                               ║
║                                                                            ║
║  Changed files:                                                            ║
║    • <list changed files from git status>                                  ║
║                                                                            ║
║  Options:                                                                  ║
║    [C] Commit changes now (RECOMMENDED)                                    ║
║        → git add . && git commit -m "chore: pre-vs-init save"             ║
║        → Then create safety tag and proceed                                ║
║                                                                            ║
║    [S] Stash changes temporarily                                           ║
║        → git stash push -m "pre-vs-init-backup"                           ║
║        → You can restore later with git stash pop                          ║
║                                                                            ║
║    [A] Abort vs-init                                                       ║
║        → Manually commit/stash your changes, then run vs-init again        ║
║                                                                            ║
╚═══════════════════════════════════════════════════════════════════════════╝

Your choice [C/S/A]:
```

**Actions:**
- **[C] Commit:** Run `git add . && git commit -m "chore: pre-vs-init save"`, then proceed to Step 0.3
- **[S] Stash:** Run `git stash push -m "pre-vs-init-backup"`, then proceed to Step 0.3
- **[A] Abort:** Exit vs-init with message explaining user should manually handle changes

#### Scenario B: No Git Repository

If `.git/` directory does not exist:

```
╔═══════════════════════════════════════════════════════════════════════════╗
║                    NO GIT REPOSITORY DETECTED                             ║
╠═══════════════════════════════════════════════════════════════════════════╣
║                                                                            ║
║  This project is not under version control.                                ║
║                                                                            ║
║  ⚠️  WARNING: Without git, you cannot rollback if vs-init causes issues.  ║
║                                                                            ║
║  Strong recommendation: Initialize git first for safety.                   ║
║                                                                            ║
║  Options:                                                                  ║
║    [I] Initialize git with initial commit (RECOMMENDED)                    ║
║        → git init                                                          ║
║        → git add .                                                         ║
║        → git commit -m "chore: initial commit before vs-init"             ║
║        → Then proceed with vs-init                                         ║
║                                                                            ║
║    [2] Continue without git safety net (NOT recommended)                   ║
║        → Continue at your own risk                                         ║
║        → No rollback capability                                            ║
║                                                                            ║
║    [A] Abort vs-init                                                       ║
║        → Manually set up git, then run vs-init again                       ║
║                                                                            ║
╚═══════════════════════════════════════════════════════════════════════════╝

Your choice [I/2/A]:
```

**Actions:**
- **[I] Initialize:** Run `git init && git add . && git commit -m "chore: initial commit before vs-init"`, then proceed to Step 0.3
- **[2] Continue:** Skip to Step 0.4 with warning logged
- **[A] Abort:** Exit vs-init

#### Scenario C: Clean Git Repository

If working directory is clean (no uncommitted changes):

```
╔═══════════════════════════════════════════════════════════════════════════╗
║                    CREATING SAFETY CHECKPOINT                             ║
╠═══════════════════════════════════════════════════════════════════════════╣
║                                                                            ║
║  ✓ Working directory is clean                                              ║
║                                                                            ║
║  Creating safety tag: vs-init-backup-YYYYMMDD-HHMMSS                       ║
║    → git tag -a vs-init-backup-YYYYMMDD-HHMMSS -m "vs-init checkpoint"    ║
║                                                                            ║
║  If something goes wrong, rollback with:                                   ║
║    git checkout vs-init-backup-YYYYMMDD-HHMMSS                             ║
║                                                                            ║
╚═══════════════════════════════════════════════════════════════════════════╝
```

### 0.3 Store Safety Tag Reference

After creating the safety tag, store it for later reference:

```
[SKILL:vs-init] Step 0.3: Safety checkpoint created

Safety tag: vs-init-backup-YYYYMMDD-HHMMSS
Rollback command: git checkout vs-init-backup-YYYYMMDD-HHMMSS
```

**Tag Naming Convention:**
```
vs-init-backup-YYYYMMDD-HHMMSS
```

Example: `vs-init-backup-20260325-172500`

### 0.4 Edge Cases for Git Safety

| Edge Case | Detection | Resolution |
|-----------|-----------|------------|
| Detached HEAD | `git symbolic-ref -q HEAD` fails | Prompt user to checkout a branch first |
| Merge conflicts | `git ls-files -u` not empty | Require user to resolve conflicts before proceeding |
| Staged but uncommitted | `git diff --cached` not empty | Include in uncommitted changes prompt |
| Submodule directory | `.git` file exists (not directory) | Check submodule status, same rules apply |
| Bare repository | `git rev-parse --is-bare-repository` = true | Skip vs-init, not applicable |
| Tag creation fails | Command returns non-zero | Warn user, proceed without tag |

---

## Step 0.5: Detect Existing XML Files

After git checkpoint, scan for existing XML files that may contain valuable data.

```
[SKILL:vs-init] Step 0.5: Scanning for existing XML files...

Existing XML files:
  • docs/requirements.xml - [GRACE-compatible ✓ / Unknown format ⚠]
  • docs/decisions.xml - [GRACE-compatible ✓ / Unknown format ⚠]
  • docs/development-plan.xml - [GRACE-compatible ✓ / Unknown format ⚠]
  • docs/knowledge-graph.xml - [GRACE-compatible ✓ / Unknown format ⚠]
  • docs/verification-plan.xml - [GRACE-compatible ✓ / Unknown format ⚠]
  • docs/technology.xml - [GRACE-compatible ✓ / Unknown format ⚠]
  • docs/custom-config.xml - [Unknown format ⚠ / Skipped]
```

**GRACE Compatibility Detection:**
- Check for root element matching expected structure
- Look for GRACE-specific elements (`<UC-*>`, `<D-*>`, `<M-*>`, `<node-*>`)
- Validate XML is well-formed

---

## Step 0.6: XML Migration Analysis and Prompt

If GRACE-compatible XML files are detected, offer migration options.

### Migration Options Prompt

```
╔═══════════════════════════════════════════════════════════════════════════╗
║                    EXISTING XML FILES DETECTED                            ║
╠═══════════════════════════════════════════════════════════════════════════╣
║                                                                            ║
║  Found existing GRACE-compatible XML files:                                ║
║                                                                            ║
║    • docs/requirements.xml (<N> use cases, <N> decisions, <N> constraints) ║
║    • docs/decisions.xml (<N> decisions)                                    ║
║    • docs/development-plan.xml (<N> modules, <N> data flows)               ║
║    • docs/knowledge-graph.xml (<N> nodes, <N> edges)                       ║
║                                                                            ║
║  Options:                                                                  ║
║    [1] Migrate existing data (RECOMMENDED)                                 ║
║        → Extract valuable data from existing files                         ║
║        → Merge with new template structure                                 ║
║        → Create backups of originals                                       ║
║        → Generate migration report                                         ║
║                                                                            ║
║    [2] Fresh start - replace all                                           ║
║        → Backup existing files                                             ║
║        → Create fresh from templates                                       ║
║        → ⚠️ All existing data will be lost                                ║
║                                                                            ║
║    [3] Keep existing - skip XML creation                                   ║
║        → Leave existing XML files unchanged                                ║
║        → Only create missing files                                         ║
║                                                                            ║
╚═══════════════════════════════════════════════════════════════════════════╝

Your choice [1/2/3]:
```

### Migration Preview (if user selects [1])

Before executing migration, show what will be preserved:

```
╔═══════════════════════════════════════════════════════════════════════════╗
║                    MIGRATION PREVIEW                                      ║
╠═══════════════════════════════════════════════════════════════════════════╣
║                                                                            ║
║  The following data will be preserved:                                     ║
║                                                                            ║
║  From requirements.xml:                                                    ║
║    ✓ UC-XXX: <use case title>                                              ║
║    ✓ D-XXX: <decision title>                                               ║
║    ✓ <N> technical constraints                                             ║
║    ✓ <N> business constraints                                              ║
║    ✓ Glossary with <N> terms                                               ║
║                                                                            ║
║  From decisions.xml:                                                       ║
║    ✓ D-XXX: <decision title>                                               ║
║    ✓ D-XXX: <decision title>                                               ║
║                                                                            ║
║  From development-plan.xml:                                                ║
║    ✓ M-XXX: <module name>                                                  ║
║    ✓ DF-XXX: <data flow name>                                              ║
║                                                                            ║
║  From knowledge-graph.xml:                                                 ║
║    ✓ <N> nodes preserved                                                   ║
║    ✓ <N> edges validated                                                   ║
║                                                                            ║
║  Warnings:                                                                 ║
║    ⚠ Unknown element <customMetadata> will be moved to LegacyData         ║
║    ⚠ Orphaned edge removed: <edge-id>                                     ║
║                                                                            ║
╚═══════════════════════════════════════════════════════════════════════════╝

Proceed with migration? [Y/n]:
```

### Data Extraction Rules

#### requirements.xml Extraction

| Source Pattern | Target Element | Migration Rule |
|----------------|----------------|----------------|
| `<UseCases>/<UC-*>` | `<UseCases>/<UC-*>` | Copy entire element, preserve ID |
| `<Decisions>/<D-*>` | `<Decisions>/<D-*>` | Copy to requirements.xml Decisions section |
| `<Constraints>/*` | `<Constraints>/*` | Copy all constraint sections |
| `<Glossary>/<term>` | `<Glossary>/<term>` | Copy all term definitions |
| `<ProjectInfo>` | `<ProjectInfo>` | Merge with new project info |
| Unknown elements | `<LegacyData>` | Preserve with warning |

#### decisions.xml Extraction

| Source Pattern | Target Element | Migration Rule |
|----------------|----------------|----------------|
| `<Decisions>/<D-*>` | `<Decisions>/<D-*>` | Copy entire element with all children |
| `<Categories>/*` | `<Categories>/*` | Merge with template categories |
| `<Statistics>` | `<Statistics>` | Recalculate after migration |
| `<review>` sections | `<review>` | Preserve completely |

#### development-plan.xml Extraction

| Source Pattern | Target Element | Migration Rule |
|----------------|----------------|----------------|
| `<Modules>/<M-*>` | `<Modules>/<M-*>` | Copy with full contract definition |
| `<DataFlow>/<DF-*>` | `<DataFlow>/<DF-*>` | Copy entire flow definition |
| `<ImplementationOrder>/*` | `<ImplementationOrder>/*` | Preserve phases and steps |
| `<ArchitectureNotes>/*` | `<ArchitectureNotes>/*` | Copy all notes |

#### knowledge-graph.xml Extraction

| Source Pattern | Target Element | Migration Rule |
|----------------|----------------|----------------|
| `<Nodes>/<M-*>` | `<Nodes>/<M-*>` | Copy node with all metadata |
| `<Edges>/<edge>` | `<Edges>/<edge>` | Copy all edges, validate references |
| `<CrossLinks>/*` | `<CrossLinks>/*` | Copy and update document references |
| `<Layers>/*` | `<Layers>/*` | Recalculate after node migration |

### Migration Algorithm

```
for each XML file in docs/:
    if file is GRACE-compatible:
        parse XML structure
        for each child of root element:
            if child matches known GRACE structure:
                extract to corresponding section
            else if child has ID attribute:
                extract as custom section with warning
            else:
                preserve in <LegacyData> section
        create backup: docs/.backup/<filename>.YYYYMMDD-HHMMSS
        write migrated file
    else:
        log warning for manual review
        skip migration
```

---

## Step 0.7: Generate Migration Report

After migration, generate a detailed report.

### Migration Report Format

Create file: `docs/.backup/migration-report-YYYYMMDD-HHMMSS.xml`

```xml
<?xml version="1.0" encoding="UTF-8"?>
<MigrationReport TIMESTAMP="YYYY-MM-DDTHH:MM:SSZ">
  
  <Summary>
    <source-files><count></source-files>
    <extracted-elements><count></extracted-elements>
    <preserved-elements><count></preserved-elements>
    <warnings><count></warnings>
    <errors><count></errors>
  </Summary>
  
  <FileMigrations>
    <File name="<filename>.xml">
      <status>migrated|replaced|skipped</status>
      <backup>docs/.backup/<filename>.YYYYMMDD-HHMMSS</backup>
      <extracted>
        <element type="<type>" id="<id>" action="preserved|modified|legacy" />
      </extracted>
      <warnings>
        <warning><description></warning>
      </warnings>
    </File>
  </FileMigrations>
  
  <PreservationMap>
    <!-- Maps old IDs to new IDs if renumbering occurred -->
    <mapping old="<old-id>" new="<new-id>" />
  </PreservationMap>
  
  <RollbackInstructions>
    <step-1>To rollback: cp docs/.backup/*.xml.YYYYMMDD-HHMMSS docs/</step-1>
    <step-2>Or use git: git checkout vs-init-backup-YYYYMMDD-HHMMSS -- docs/</step-2>
  </RollbackInstructions>
  
</MigrationReport>
```

### Migration Summary Display

```
╔═══════════════════════════════════════════════════════════════════════════╗
║                    MIGRATION COMPLETE                                      ║
╠═══════════════════════════════════════════════════════════════════════════╣
║                                                                            ║
║  Files migrated: <count>                                                   ║
║  Elements preserved: <count>                                               ║
║  Warnings: <count>                                                         ║
║                                                                            ║
║  Backups created in: docs/.backup/                                         ║
║  Migration report: docs/.backup/migration-report-YYYYMMDD-HHMMSS.xml       ║
║                                                                            ║
║  To rollback:                                                              ║
║    git checkout vs-init-backup-YYYYMMDD-HHMMSS -- docs/                    ║
║                                                                            ║
╚═══════════════════════════════════════════════════════════════════════════╝
```

### Edge Cases for XML Migration

| Edge Case | Detection | Resolution |
|-----------|-----------|------------|
| Malformed XML | XML parsing fails | Abort migration, offer fresh start |
| Unknown root element | Root not in known types | Treat as generic XML, extract text content |
| Missing required attributes | ID attribute missing | Generate new ID with prefix `MIGRATED-` |
| Duplicate IDs across files | Same ID in multiple files | Prefix with file type: `REQ-UC-001` |
| Circular references in graph | Graph traversal detects cycle | Break cycle, add warning to report |
| External file references | `<ref doc="...">` to missing file | Remove reference, add warning |
| Binary content in XML | Base64 or CDATA detected | Preserve as-is in LegacyData |
| Very large files | File > 1MB | Warn user, offer partial migration |
| Non-UTF-8 encoding | Encoding declaration check | Convert to UTF-8, log conversion |

---

## Step 1: Detect Environment

Scan the project to understand the current state.

### 1.1 Check for Existing Artifacts

```
[SKILL:vs-init] Step 1: Detecting environment...

Checking existing artifacts:
  • AGENTS.md: [exists/missing]
  • vs.project.toml: [exists/missing]
  • docs/: [exists/missing]
  • docs/*.xml: [count] files found
```

### 1.2 Detect Agent Type

Identify which AI agent is running:
- Kilo Code: Check for `.kilocode/config.json`
- Cursor: Check for `.cursorrules`
- Claude Code: Check for `.claude/`

### 1.3 Detect Project Stack

Auto-detect the technology stack by checking for:
- `package.json` → Node.js/TypeScript
- `pyproject.toml` / `requirements.txt` → Python
- `go.mod` → Go
- `Cargo.toml` → Rust

### 1.4 Handle AGENTS.md Conflict

If `AGENTS.md` already exists:

```
╔═══════════════════════════════════════════════════════════════╗
║                    AGENTS.md EXISTS                           ║
╠═══════════════════════════════════════════════════════════════╣
║                                                                ║
║  An AGENTS.md file already exists in this project.           ║
║                                                                ║
║  Options:                                                      ║
║    [1] backup-and-replace (RECOMMENDED)                       ║
║        → Save current to AGENTS.md.backup                     ║
║        → Generate new from template                           ║
║                                                                ║
║    [2] keep-existing                                           ║
║        → No changes to AGENTS.md                              ║
║        → Continue with other files                            ║
║                                                                ║
╚═══════════════════════════════════════════════════════════════╝

Your choice [1/2]:
```

---

## Step 2: Create Files

Create all required vibestart files from templates.

### 2.1 Gather Project Information

If no existing configuration, ask the user for:
- Project name and short description
- Primary language and framework
- Key features to enable (GRACE, session logging, batch mode)
- Testing stack (if known)

### 2.2 Create Configuration File

```
[SKILL:vs-init] Step 2: Creating files...

Creating vs.project.toml:
  ✓ Read template from assets/vs.project.toml.template
  ✓ Replaced placeholders with detected/provided values
  ✓ Written to vs.project.toml
```

### 2.3 Create docs/ Directory and XML Files

For each `assets/docs/*.xml.template` file:

```
Creating docs/ structure:
  ✓ docs/development-plan.xml (from template)
  ✓ docs/knowledge-graph.xml (from template)
  ✓ docs/requirements.xml (from template)
  ✓ docs/technology.xml (from template)
  ✓ docs/verification-plan.xml (from template)
  ✓ docs/decisions.xml (from template)
```

If any file already exists:
- Create backup: `docs/.backup/<filename>.backup`
- Proceed with template-based creation

### 2.4 Create AGENTS.md

```
Creating AGENTS.md:
  ✓ Read template from assets/AGENTS.md.template
  ✓ Replaced $PROJECT_NAME, $KEYWORDS, $ANNOTATION
  ✓ Written to AGENTS.md
```

### 2.5 Update .gitignore

Append vibestart-specific entries if not present:

```gitignore
# vibestart
docs/ai/private-rules.local.md
.env*.local
context_portal/
```

---

## Step 3: Verify & Report

Validate the initialization and provide a summary.

### 3.1 Verify File Creation

```
[SKILL:vs-init] Step 3: Verifying installation...

Verifying created files:
  ✓ vs.project.toml
  ✓ AGENTS.md
  ✓ docs/development-plan.xml
  ✓ docs/knowledge-graph.xml
  ✓ docs/requirements.xml
  ✓ docs/technology.xml
  ✓ docs/verification-plan.xml
  ✓ docs/decisions.xml
  ✓ .gitignore updated
```

### 3.2 Print Summary

```
╔═══════════════════════════════════════════════════════════════════════╗
║                    INITIALIZATION COMPLETE                             ║
╠═══════════════════════════════════════════════════════════════════════╣
║                                                                        ║
║  Project: <project-name>                                               ║
║  Agent: <detected-agent>                                               ║
║  Stack: <detected-stack>                                               ║
║                                                                        ║
║  Created files:                                                        ║
║    • vs.project.toml (configuration)                                   ║
║    • AGENTS.md (agent instructions)                                    ║
║    • docs/*.xml (6 GRACE artifacts)                                    ║
║                                                                        ║
║  Backups: <count> files backed up                                      ║
║  Safety tag: vs-init-backup-YYYYMMDD-HHMMSS                            ║
║                                                                        ║
║  ✅ Done: Project initialized successfully                             ║
║                                                                        ║
║  Next steps:                                                           ║
║    1. Review and customize vs.project.toml                             ║
║    2. Edit docs/requirements.xml with your requirements                ║
║    3. Run /grace-plan to design module architecture                    ║
║                                                                        ║
║  Rollback: git checkout vs-init-backup-YYYYMMDD-HHMMSS                 ║
║                                                                        ║
╚═══════════════════════════════════════════════════════════════════════╝
```

---

## Error Handling

### Missing Templates

If template files are not found:

```
[ERROR] Template files not found at assets/

Ensure the vs-init skill is properly installed with all template files.
Expected location: <skill-path>/assets/*.template
```

### File Write Errors

If unable to write files:

```
[ERROR] Unable to create <filename>

Check:
  • File permissions in project directory
  • Disk space availability
  • No conflicting file locks
```

### Backup Failures

If backup creation fails, warn but continue:

```
[WARN] Could not create backup for <filename>
Continuing with file creation...
```

### Git Safety Failures

If tag creation fails:

```
[WARN] Could not create safety tag
Proceeding without safety checkpoint...
Rollback will require manual file restoration.
```

### Migration Failures

If XML parsing fails during migration:

```
[ERROR] Migration failed for <filename>

The file appears to be malformed XML.
Options:
  [1] Skip this file and continue
  [2] Abort migration, use fresh templates
  [3] Abort vs-init
```

---

## Quick Reference

| Scenario                    | Action                                    |
|-----------------------------|-------------------------------------------|
| New project, no git         | Offer git init, then create files         |
| New project, clean git      | Create safety tag, then create files      |
| Dirty git                   | Prompt commit/stash first                 |
| Existing GRACE XML          | Offer migration with report               |
| AGENTS.md exists            | Prompt: backup-and-replace or keep        |
| docs/*.xml exists           | Backup existing, migrate or create fresh  |
| vs.project.toml exists      | Load config, skip creation                |
| Partial installation        | Create missing files only                 |

---

## Output

After successful execution:
- `vs.project.toml` — Project configuration
- `AGENTS.md` — Agent instructions
- `docs/` — GRACE framework XML files
- `.gitignore` — Updated with vibestart entries
- `docs/.backup/` — Backups of replaced files (if any)
- `docs/.backup/migration-report-*.xml` — Migration report (if migration occurred)
- Git safety tag `vs-init-backup-YYYYMMDD-HHMMSS` — For rollback (if git available)
