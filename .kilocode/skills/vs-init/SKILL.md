# Skill: vs-init

Interactive wizard for project initialization and configuration.

## Purpose

Diagnose project state and guide user through setup of all available methodologies and tools:
- GRACE framework
- Session continuity (SESSION_LOG.md + TASK_LOG.md)
- ConPort MCP
- Design-first collaboration
- Batch mode
- Time tracking
- Project-specific rules

## When to Use

- New project setup
- After cloning vibestart template
- When adding new methodologies to existing project
- When user says: "init project", "setup project", "run vs-init"

## Process

### Step 1: Diagnostic

Run automatic diagnostic and report:

```
=== VIBESTART PROJECT DIAGNOSTIC ===

[System] Checking project structure...
  - Project root: [path]
  - Has docs/ directory: [yes/no]
  - Has src/ directory: [yes/no]

[GRACE] Checking GRACE artifacts...
  - docs/knowledge-graph.xml: [exists/missing]
  - docs/requirements.xml: [exists/missing]
  - docs/technology.xml: [exists/missing]
  - docs/development-plan.xml: [exists/missing]
  - docs/verification-plan.xml: [exists/missing]

[Setup] Checking configuration...
  - vs.project.toml: [exists/missing]
  - AGENTS.md: [exists/missing]
  - docs/SESSION_LOG.md: [exists/missing]
  - docs/TASK_LOG.md: [exists/missing]
  - docs/grace-macros.md: [exists/missing]

[ConPort] Checking MCP setup...
  - .kilocode/mcp_settings.json: [exists/missing]
  - uv available: [yes/no]

=== DIAGNOSTIC COMPLETE ===
```

### Step 2: Ask Questions

Ask user interactively (one at a time or in logical groups):

**Group 1: Project Basics**
1. "What is your project name?"
2. "What does it do? (one sentence)"
3. "Who will use it?"

**Group 2: Technology Stack** (will be written to docs/technology.xml)
4. "What is the primary language?" (TypeScript, JavaScript, Python, etc.)
5. "What runtime?" (Node.js, Bun, Deno, etc.)
6. "What framework?" (Next.js, FastAPI, React, Vue, none, etc.)
7. "What test runner?" (Vitest, Jest, pytest, etc.)

**Group 3: Methodologies** (will be written to vs.project.toml)
8. "Enable GRACE framework?" (recommended: yes)
9. "Enable session continuity (SESSION_LOG.md + TASK_LOG.md)?" (recommended: yes)
10. "Enable ConPort MCP for long-term memory?" (requires uv, recommended: no for beginners)
11. "Enable design-first collaboration?" (recommended: yes)
12. "Enable batch mode for autonomous execution?" (recommended: yes)
13. "Enable time tracking?" (recommended: no for beginners)

**Group 4: Rules**
14. "Do you have project-specific rules to add?" (creates docs/ai/project-rules.md)
15. "Do you want private local rules (not committed)?" (creates docs/ai/private-rules.local.md in .gitignore)

### Step 3: Create Artifacts

Based on answers, create/update:

1. **vs.project.toml** - Master configuration
   - Set enabled features
   - Configure tools
   - Set policies

2. **docs/technology.xml** - Technology stack (GRACE)
   - Language, runtime, framework
   - Dependencies
   - Testing configuration
   - Observability

3. **docs/requirements.xml** - Project requirements (GRACE)
   - Project name and annotation
   - Actors (if provided)
   - Initial use cases (if provided)

4. **AGENTS.md** - Agent instructions
   - Generate from vs.project.toml configuration
   - Include enabled features
   - Include session management rules

5. **docs/SESSION_LOG.md** - Session log (if enabled)
6. **docs/TASK_LOG.md** - Task log (if enabled)
7. **docs/grace-macros.md** - GRACE macros (if GRACE enabled)
8. **.kilocode/mcp_settings.json** - ConPort config (if enabled)
9. **docs/ai/project-rules.md** - Project-specific rules (if requested)
10. **docs/ai/private-rules.local.md** - Private rules (if requested)
11. **.gitignore** - Add private-rules.local.md

### Step 4: Final Report

Print summary:

```
=== VIBESTART INITIALIZATION COMPLETE ===

✅ Created Files:
  - vs.project.toml
  - docs/technology.xml
  - docs/requirements.xml
  - AGENTS.md
  - docs/SESSION_LOG.md
  - docs/TASK_LOG.md
  - docs/grace-macros.md

✅ Enabled Features:
  - GRACE framework
  - Session continuity
  - Design-first collaboration
  - Batch mode

⏳ Next Steps:
  1. Define use cases in docs/requirements.xml
  2. Run macro g-init (or $grace-plan) to design modules
  3. Start coding with GRACE methodology

📚 Documentation:
  - docs/grace-macros.md - Available macros (g-init, g-feature, etc.)
  - AGENTS.md - Full agent instructions
  - vs.project.toml - Configuration (edit to change features)
```

## Configuration Reference

### vs.project.toml Features

| Feature | Description | Default |
|---------|-------------|---------|
| `grace` | GRACE framework with docs/*.xml | true |
| `session_log` | SESSION_LOG.md + TASK_LOG.md | true |
| `conport` | ConPort MCP for long-term memory | false |
| `design_first` | Plan before code | true |
| `batch_mode` | Autonomous task execution | true |
| `time_tracking` | Log agent sessions | false |

### Feature Dependencies

```
grace
  └─ requires: docs/*.xml structure

session_log
  └─ requires: nothing
  └─ enhances: grace

conport
  └─ requires: uv, MCP setup, VS Code reload
  └─ conflicts with: nothing (complements grace)

batch_mode
  └─ requires: session_log
  └─ requires: docs/BATCH_TASKS.md

time_tracking
  └─ requires: conport (for storage)
```

## Example Usage

```
User: Run vs-init

Agent:
=== VIBESTART PROJECT DIAGNOSTIC ===
[System] Checking project structure...
  - Project root: D:\_prj\myproject
  - Has docs/ directory: no
  - Has src/ directory: no
...

What is your project name?
> myproject

What does it do?
> Task management app

What is the primary language?
> TypeScript

Enable GRACE framework? (recommended: yes)
> yes

...
```

## Notes

- Always read existing vs.project.toml if present (don't overwrite without asking)
- Always read existing docs/*.xml if present (merge, don't overwrite)
- If project already has AGENTS.md, ask before overwriting
- ConPort requires uv installation and VS Code reload - warn user
