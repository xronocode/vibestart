---
name: grace-session
description: "Manage AI development sessions. Start sessions with context, end with summaries, and migrate decisions to GRACE artifacts."
---

# grace-session Skill

Manage AI development sessions with context and continuity.

## Purpose

Provides session management for AI agents:
1. Start sessions with relevant context
2. Track session activities
3. End sessions with summaries
4. Migrate important decisions to GRACE

## Prerequisites

**Required:**
- vs.project.toml exists
- GRACE artifacts initialized

**Optional:**
- ConPort integration (for persistent memory)
- Entire.io integration (for session audit)

---

## Commands

### Start Session

```bash
/grace-session start "Implement M-Auth module"
```

### End Session

```bash
/grace-session end "Completed M-Auth contract and implementation"
```

### Session Info

```bash
/grace-session info
```

---

## Execution Flow: Start Session

```
[SKILL:grace-session] Starting session...
```

### Step 1: Generate Session ID

```
Session ID: sess_YYYYMMDD_HHMMSS
Example: sess_20260327_143022
```

### Step 2: Load Context

**If ConPort enabled:**
```
[ConPort] Loading context for task: "Implement M-Auth module"
[ConPort] Found 5 relevant memories
[ConPort] Loading session history...
```

**If Entire.io enabled:**
```
[Entire.io] Starting session capture...
[Entire.io] Session will be linked to next commit
```

### Step 3: Load GRACE Context

```
[GRACE] Loading relevant modules:
  • M-Auth (in_progress) — from development-plan.xml
  • M-Config (done) — dependency
  • M-Logger (done) — dependency

[GRACE] Loading contracts:
  • M-Auth contract from knowledge-graph.xml
```

### Step 4: Create Session Entry

```markdown
## Session: sess_20260327_143022

**Started:** 2026-03-27T14:30:22Z
**Task:** Implement M-Auth module
**Context:**
- ConPort memories: 5 loaded
- GRACE modules: 3 loaded
- Entire.io: capture active

**Goals:**
- [ ] Complete M-Auth contract
- [ ] Implement M-Auth
- [ ] Add tests
```

### Step 5: Output Session Start

```
╔═══════════════════════════════════════════════════════════════════════╗
║                       SESSION STARTED                                  ║
╠═══════════════════════════════════════════════════════════════════════╣
║                                                                        ║
║  Session ID: sess_20260327_143022                                      ║
║  Task: Implement M-Auth module                                         ║
║                                                                        ║
║  Context loaded:                                                       ║
║    ✓ ConPort: 5 memories                                               ║
║    ✓ GRACE: 3 modules, 2 contracts                                     ║
║    ✓ Entire.io: capture active                                         ║
║                                                                        ║
║  Goals:                                                                ║
║    • Complete M-Auth contract                                          ║
║    • Implement M-Auth                                                  ║
║    • Add tests                                                         ║
║                                                                        ║
║  To end session: /grace-session end "<summary>"                        ║
║                                                                        ║
╚═══════════════════════════════════════════════════════════════════════╝
```

---

## Execution Flow: End Session

```
[SKILL:grace-session] Ending session...
```

### Step 1: Capture Summary

```
User provides summary:
"Completed M-Auth contract and implementation. Tests pending."
```

### Step 2: Record Session Data

```
Session Data:
  • Duration: 1h 45m
  • Files touched: 3
  • Modules updated: M-Auth
  • Decisions made: 2
```

### Step 3: Update Session Log

```markdown
## Session: sess_20260327_143022

**Started:** 2026-03-27T14:30:22Z
**Ended:** 2026-03-27T16:15:00Z
**Duration:** 1h 45m

**Task:** Implement M-Auth module
**Summary:** Completed M-Auth contract and implementation. Tests pending.

**Files touched:**
  • src/modules/auth/contract.ts
  • src/modules/auth/impl.ts
  • tests/auth.test.ts

**Modules updated:**
  • M-Auth (status: done)

**Decisions made:**
  • D-003: JWT for authentication
  • D-004: bcrypt for password hashing
```

### Step 4: Store in ConPort (if enabled)

```
[ConPort] Storing session summary...
[ConPort] Extracting decisions...
[ConPort] Stored 2 memories:
  • mem_abc123: "JWT for authentication"
  • mem_abc124: "bcrypt for password hashing"
```

### Step 5: Link to Entire.io (if enabled)

```
[Entire.io] Linking session to checkpoint...
[Entire.io] Checkpoint: chk_abc123
[Entire.io] Session transcript saved
```

### Step 6: Offer Decision Migration

```
Decisions detected:
  • D-003: JWT for authentication
  • D-004: bcrypt for password hashing

Migrate to GRACE? [Y/n]

If "Y":
  [GRACE] Adding to docs/decisions.xml...
  [GRACE] Updating knowledge-graph.xml...
  [GRACE] Decisions migrated
```

### Step 7: Output Session End

```
╔═══════════════════════════════════════════════════════════════════════╗
║                       SESSION ENDED                                    ║
╠═══════════════════════════════════════════════════════════════════════╣
║                                                                        ║
║  Session ID: sess_20260327_143022                                      ║
║  Duration: 1h 45m                                                      ║
║                                                                        ║
║  Summary:                                                              ║
║    Completed M-Auth contract and implementation. Tests pending.        ║
║                                                                        ║
║  Recorded:                                                             ║
║    ✓ Session log updated                                               ║
║    ✓ ConPort: 2 memories stored                                        ║
║    ✓ Entire.io: checkpoint linked                                      ║
║    ✓ GRACE: 2 decisions migrated                                       ║
║                                                                        ║
║  Next session: /grace-session start "<task>"                           ║
║                                                                        ║
╚═══════════════════════════════════════════════════════════════════════╝
```

---

## Execution Flow: Session Info

```
[SKILL:grace-session] Getting session info...
```

### Current Session

```
Current Session:
  • ID: sess_20260327_143022
  • Started: 2026-03-27T14:30:22Z
  • Task: Implement M-Auth module
  • Duration: 1h 45m
  • Status: active
```

### Recent Sessions

```
Recent Sessions (last 5):
  • sess_20260327_143022 — Implement M-Auth (active)
  • sess_20260327_120000 — M-Config setup (completed)
  • sess_20260326_150000 — M-Logger implementation (completed)
  • sess_20260326_100000 — Project initialization (completed)
  • sess_20260325_140000 — GRACE planning (completed)
```

### Session Statistics

```
Statistics:
  • Total sessions: 15
  • Total time: 24h 30m
  • Average session: 1h 38m
  • Modules completed: 3
  • Decisions migrated: 8
```

---

## Integration Details

### With ConPort

**Session Start:**
```python
# Load relevant memories
memories = conport.recall(task, k=5)
context = format_memories(memories)
```

**Session End:**
```python
# Store session summary
conport.store({
    "type": "session",
    "session_id": session_id,
    "summary": summary,
    "decisions": decisions
})
```

### With Entire.io

**Session Start:**
```bash
entire record --session "$SESSION_ID"
```

**Session End:**
```bash
entire checkpoint --message "$summary"
```

---

## Session Log Format

```markdown
## Session: sess_20260327_143022

**Started:** 2026-03-27T14:30:22Z
**Ended:** 2026-03-27T16:15:00Z
**Duration:** 1h 45m

**Task:** Implement M-Auth module
**Summary:** Completed M-Auth contract and implementation. Tests pending.

**Files touched:**
  • src/modules/auth/contract.ts
  • src/modules/auth/impl.ts
  • tests/auth.test.ts

**Modules updated:**
  • M-Auth (status: done)

**Decisions made:**
  • D-003: JWT for authentication
  • D-004: bcrypt for password hashing

**Integration data:**
  • ConPort memories: mem_abc123, mem_abc124
  • Entire.io checkpoint: chk_abc123
```

---

## Best Practices

1. **Start each work session** — `/grace-session start "<task>"`
2. **End with summary** — Always provide a summary when ending
3. **Migrate decisions** — Move architectural decisions to GRACE
4. **Review recent sessions** — Check context before continuing
5. **Use descriptive tasks** — Be specific about what you're doing

---

## When to Use

| Scenario | Command |
|----------|---------|
| Starting new task | `/grace-session start "<task>"` |
| Finishing work | `/grace-session end "<summary>"` |
| Check current session | `/grace-session info` |
| After break | `/grace-session info` then continue |
| Before commit | `/grace-session end` with summary |

---

## Troubleshooting

**Issue: Session not starting**
```
Check: vs.project.toml exists
Check: GRACE artifacts initialized
```

**Issue: ConPort not loading memories**
```
Check: ConPort MCP configured
Check: Memory Bank exists
Run: conport status
```

**Issue: Entire.io not capturing**
```
Check: entire CLI installed
Check: Git hooks active
Run: entire enable
```
