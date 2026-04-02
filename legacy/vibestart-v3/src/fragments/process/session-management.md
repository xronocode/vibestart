## Session Management
<!-- Fragment: process/session-management.md -->

This project uses `docs/SESSION_LOG.md` and `docs/TASK_LOG.md` for session context persistence.

### Session Management

**Files:**
- `docs/TASK_LOG.md` — Structured task tracking with checkboxes
- `docs/SESSION_LOG.md` — Machine-readable session log

**Rules:**
1. At session start — FIRST read `docs/TASK_LOG.md`
2. After EACH completed step — append to TASK_LOG.md
3. At session end — write SESSION_END to SESSION_LOG.md
4. If task interrupted — mark "INTERRUPTED at: [step]"
5. On "continue" / "resume" — find last unclosed step and continue

### Diagnostic Sequence

**Run at the START of every session:**

```
=== VIBESTART SESSION DIAGNOSTIC ===

[GRACE] Read docs/development-plan.xml → find first non-done step...
  Report: "Current position: Phase X | Step Y | Module M-XXX | Status: ..."

[GRACE] Read docs/TASK_LOG.md → check open tasks...
  Report: Last task and next step

[GRACE] Read docs/session-log.md → last session summary...
  Report: Last session status and next action

=== DIAGNOSTIC COMPLETE ===
Reporting:
- ✅ GRACE: Current position [Phase X / Step Y / Module M-XXX]
- ✅ Tasks: [N open tasks]
- ✅ Last session: [status and summary]

Awaiting instruction to proceed.
```

### Tool Context Transparency

**Every action must be announced BEFORE execution:**

```
[GRACE] Reading docs/development-plan.xml...
[Setup] Creating docs/session-log.md...
[Code] Writing src/config/index.ts...
[Test] Running verification checklist...
[Git] Committing: grace(M-001): Config module
```

**Prefixes:**
- `[System]` — checking OS, paths, tools
- `[GRACE]` — reading/writing docs/*.xml or running /grace:* commands
- `[GRACE-CODEGEN]` — planning module architecture
- `[Setup]` — configuring files and directories
- `[Code]` — writing or editing source files
- `[Test]` — running verification / tests
- `[Git]` — git operations
- `[Batch]` — batch mode autonomous execution

After completing any step, print:
```
✅ Done: [what was completed]
⏳ Next: [what comes next]
🔴 Blocked: [what is blocking] → [FOUNDER] needed
```

### GRACE Macros

Common workflows are defined in `~/.vibestart/framework/macros/`:
- `g-init` — init → plan → verification
- `g-feature` — requirements → plan → verification → execute → reviewer
- `g-drift` — status → refresh → verification
- `g-fix` — fix → verification → refresh
- `g-commit` — status → reviewer → verification → commit → refresh

**Usage:** "Run macro g-feature for [feature]"

### Batch Mode — Autonomous Work

User fills `docs/BATCH_TASKS.md` and writes "run batch". Agent executes autonomously.

**Trigger:** "batch" | "run batch" | "autonomous mode"

**Rules:**
- Read BATCH_TASKS.md top to bottom, strictly in order
- After each task: update SESSION_LOG.md and TASK_LOG.md
- Mark task: [x] DONE or [!] BLOCKED
- If blocked — record reason and proceed to next
- Do NOT ask questions — write "QUESTION: ..." under task in file

**Task Format:**
```markdown
- [ ] TASK-N | M-XXX | /grace:COMMAND | What exactly to run
```

**Limits — NEVER without explicit instruction:**
- Do not touch system prompts
- Do not deploy to production
- Do not modify .env files
- Do not delete files
