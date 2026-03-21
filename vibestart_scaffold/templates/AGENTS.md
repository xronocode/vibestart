# {PROJECT_NAME} — Agent Instructions
# GRACE + ConPort unified workflow
# Installed by: github.com/xronocode/vibestart

---

## ⚡ COMMUNICATION RULES

**Announce every action BEFORE execution. Confirm with ✅ AFTER.**

Use these prefixes on every action:

```
[GRACE]    — reading/writing docs/*.xml or running /grace:* command
[ConPort]  — any ConPort MCP tool call
[CODE]     — writing or editing source files
[VERIFY]   — running tests or verification checklist
[GIT]      — git operations
[FOUNDER]  — action required from you (agent stops and waits)
[GATE]     — phase gate check
```

After every step:
```
✅ Done: [what was completed]
⏳ Next: [what comes next]
🔴 Blocked: [reason] → [FOUNDER] needed
```

---

## 🔍 DIAGNOSTIC SEQUENCE

**Run at the START of every session. Print each step. Never skip.**

```
=== SESSION DIAGNOSTIC ===

[ConPort] get_product_context
  ✅ PASS: project name and stack present
  ❌ FAIL: load projectBrief.md → update_product_context, then retry

[ConPort] get_active_context
  ✅ PASS: active module and goal present
  ⚠️  EMPTY: no prior session — start from first pending step
  ⚠️  STALE (>24h): confirm with founder before resuming

[GRACE] Read docs/development-plan.xml → first STATUS != "done"
  Report: "Current: Phase X | Step Y | Module M-XXX | Status: ..."

[ConPort] get_custom_data category="blockers"
  ✅ NONE: proceed
  ⚠️  FOUND: list blockers, ask founder which to resolve first

[ConPort] get_recent_activity_summary hours_ago=24
  Report: last 3 actions

=== DIAGNOSTIC COMPLETE ===
ConPort:      [LOADED / EMPTY / ERROR]
GRACE:        Phase X / Step Y / Module M-XXX
Blockers:     [NONE / N open]
Last activity: [timestamp — description]

Awaiting your instruction.
```

---

## 📐 SOURCE OF TRUTH HIERARCHY

| System | Role | Location |
|--------|------|----------|
| **GRACE XML** | Immutable architecture truth | `docs/*.xml` |
| **ConPort** | Session working memory | `context_portal/context.db` |
| **Source code** | Implementation | `src/` |

**NEVER write the same information to both GRACE and ConPort.**

---

## 🗂️ TOOLS DIVISION

### GRACE owns:
- `docs/development-plan.xml` — module statuses, contracts, phases
- `docs/requirements.xml` — finalized architectural decisions
- `docs/knowledge-graph.xml` — module dependency graph
- `docs/verification-plan.xml` — acceptance criteria
- Source code blocks: `// START: BLOCK_NAME` … `// END: BLOCK_NAME`

### ConPort owns:
- Active context: what is being built RIGHT NOW
- Temporary decisions: under evaluation, not yet approved
- Session blockers
- Gate results
- Semantic search

### Never duplicate:
| Information | GRACE | ConPort |
|-------------|:-----:|:-------:|
| Module contracts | ✅ | ❌ |
| Finalized decisions | ✅ | ❌ |
| Active module | ❌ | ✅ |
| Temp decisions | ❌ | ✅ |
| Blockers | ❌ | ✅ |

---

## 🚀 SESSION START PROTOCOL

```
1. [ConPort] get_product_context
2. [ConPort] get_active_context
3. [ConPort] get_custom_data category="blockers"
4. [GRACE]   Read docs/development-plan.xml — first non-done step
5. [ConPort] get_recent_activity_summary hours_ago=24
6. Print diagnostic summary
7. [FOUNDER] Await instruction
```

---

## 🔧 WORKFLOW PER MODULE

### A — Before writing code
```
[GRACE]    Read contract in docs/development-plan.xml → M-XXX
[GRACE]    Read verification in docs/verification-plan.xml → V-M-XXX
[ConPort]  update_active_context { module, goal, constraints, started }
[GRACE]    Set STATUS="in-progress" in development-plan.xml
[GRACE]    /grace:generate M-XXX
```

### B — While building
```
[CODE]     Writing [filename]...
[ConPort]  log_progress status="IN_PROGRESS" description="..."
           ⚠️ Do NOT change STATUS in development-plan.xml during build
```

### C — Verification
```
[VERIFY]   Run V-M-XXX from verification-plan.xml
           ✅ PASS or ❌ FAIL per criterion. Any FAIL → fix first.
```

### D — After verification passes
```
[GRACE]    Set STATUS="done" in development-plan.xml
[GRACE]    /grace:refresh
[ConPort]  update_active_context → next module
[GIT]      Commit (format below)
```

---

## 📝 DECISION LOGGING

**Temp → ConPort:** `[ConPort] log_decision summary="..." tags=["M-XXX"]`

**Final → GRACE XML only:** founder approves → adds to `docs/requirements.xml`  
Then: `[ConPort] delete_decision_by_id` — remove from ConPort after moving.

---

## 🚦 PHASE GATES

```
[GATE]     All modules done ✅ → performance targets met ✅
[FOUNDER]  Sign-off required — do not proceed without it
[ConPort]  log_custom_data category="gates" key="gate-X" value={result, date}
```

---

## 🔴 CRITICAL POLICIES

**System prompts** — placeholder strings only. Never generate content.  
**Secrets** — never in ConPort, GRACE XML, logs, comments, or git.  
**LLM calls** — server-side only, never from client code.

---

## 📦 COMMIT FORMAT

```
grace(M-XXX): imperative description

Phase N, Step N
Module: Name (src/path/file.ts)
Contract: one-line purpose
```

---

## 🧠 CONPORT QUICK REFERENCE

| Need | Tool |
|------|------|
| Load project overview | `get_product_context` |
| Load/save session state | `get_active_context` / `update_active_context` |
| Log blocker | `log_custom_data category="blockers"` |
| Log temp decision | `log_decision` |
| Track step | `log_progress` / `update_progress` |
| Gate result | `log_custom_data category="gates"` |
| Recent activity | `get_recent_activity_summary` |
| Search by concept | `search_custom_data_value_fts` |

---

## 📋 FOUNDER CHECKPOINTS

Agent STOPS and waits when:
1. System prompt placeholder created → needs content before gate
2. Blocker found that agent cannot resolve
3. Phase gate → sign-off required
4. Decision needs approval before moving to GRACE XML
5. Manual infrastructure step needed

```
🔴 WAITING FOR FOUNDER
Reason:      [one-line]
What I need: [specific ask]
After you respond: [next action]
```
