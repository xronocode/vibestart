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
║                                                                        ║
║  ✅ Done: Project initialized successfully                             ║
║                                                                        ║
║  Next steps:                                                           ║
║    1. Review and customize vs.project.toml                             ║
║    2. Edit docs/requirements.xml with your requirements                ║
║    3. Run /grace-plan to design module architecture                    ║
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

---

## Quick Reference

| Scenario                    | Action                                    |
|-----------------------------|-------------------------------------------|
| New project                 | Create all files from templates           |
| AGENTS.md exists            | Prompt: backup-and-replace or keep        |
| docs/*.xml exists           | Backup existing, create from template     |
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
