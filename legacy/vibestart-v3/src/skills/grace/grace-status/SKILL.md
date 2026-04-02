---
name: grace-status
description: "Show the current health status of a GRACE project. Use to get an overview of project artifacts, codebase metrics, knowledge graph health, verification coverage, and suggested next actions."
---

# grace-status Skill

Display current project health and status.

## Purpose

Provides a quick overview of:
1. GRACE artifact existence and validity
2. Module implementation progress
3. Verification coverage
4. Knowledge graph consistency
5. **NEW:** Integration status (Entire.io, ConPort)
6. Suggested next actions

## Execution Flow

```
[SKILL:grace-status] Checking project health...
```

---

## Step 0: Check Integration Status

```
[SKILL:grace-status] Step 0/6: Checking integrations...
[TOOL:read] Reading vs.project.toml...
```

### Integration Detection

```
Integrations:
  • Entire.io: [enabled/disabled]
  • ConPort: [enabled/disabled]
```

If Entire.io enabled:
```
  Entire.io:
    ✓ CLI installed (v1.2.0)
    ✓ Git hooks active
    ✓ Checkpoint branch: entire/checkpoints/v1
    ✓ Checkpoints: 15 sessions
```

If ConPort enabled:
```
  ConPort:
    ✓ MCP configured
    ✓ Memory Bank: .conport/memory.db
    ✓ Memories: 42 entries
    ✓ Last session: 2026-03-27T14:30:22Z
```

If integration issues:
```
  ⚠️ Entire.io: hooks not found
    → Run: entire enable
    
  ⚠️ ConPort: MCP not configured
    → Run: /vs-init --repair
```

---

## Step 1: Check Artifact Existence

```
[SKILL:grace-status] Step 1/6: Checking artifacts...
[STANDARD:grace] Scanning docs/ directory...
```

### Artifacts to Check

| Artifact | Path | Required |
|----------|------|----------|
| Requirements | `docs/requirements.xml` | Yes |
| Technology | `docs/technology.xml` | Yes |
| Development Plan | `docs/development-plan.xml` | Yes |
| Knowledge Graph | `docs/knowledge-graph.xml` | Yes |
| Verification Plan | `docs/verification-plan.xml` | Yes |
| Decisions | `docs/decisions.xml` | No |
| Session Log | `docs/session-log.md` | No |

### Output

```
Artifacts:
  ✓ docs/requirements.xml (valid)
  ✓ docs/technology.xml (valid)
  ✓ docs/development-plan.xml (valid)
  ✓ docs/knowledge-graph.xml (valid)
  ✓ docs/verification-plan.xml (valid)
  ✓ docs/decisions.xml (valid)
  ○ docs/session-log.md (optional, not found)
```

---

## Step 2: Analyze Module Progress

```
[SKILL:grace-status] Step 2/6: Analyzing module progress...
[STANDARD:grace] Reading docs/development-plan.xml...
```

### Extract Module Status

```
Module Progress:
  Phase 1 (Foundation):
    ✓ M-001 Config (done)
    ✓ M-002 Logger (done)
    ✓ M-003 Database (done)
    ⏳ M-004 Auth (in_progress)
    ○ M-005 Cache (pending)

  Phase 2 (Core):
    ○ M-006 UserService (pending)
    ○ M-007 TaskService (pending)
    ...

  Summary:
    • Total modules: 15
    • Completed: 3 (20%)
    • In Progress: 1 (7%)
    • Pending: 11 (73%)
```

---

## Step 3: Check Knowledge Graph Health

```
[SKILL:grace-status] Step 3/6: Checking knowledge graph...
[STANDARD:grace] Validating docs/knowledge-graph.xml...
```

### Validation Checks

1. **Node existence** — All referenced modules exist
2. **Edge validity** — All edges reference existing nodes
3. **Orphan detection** — Nodes without connections
4. **Cycle detection** — Circular dependencies

### Output

```
Knowledge Graph:
  ✓ Nodes: 15 modules
  ✓ Edges: 12 dependencies
  ✓ No orphan nodes
  ✓ No circular dependencies
  ⚠ Cross-links: 3 (review for accuracy)
```

---

## Step 4: Check Verification Coverage

```
[SKILL:grace-status] Step 4/6: Checking verification coverage...
[STANDARD:verification] Reading docs/verification-plan.xml...
```

### Coverage Analysis

```
Verification Coverage:
  ✓ Test files: 8/15 modules (53%)
  ✓ Trace requirements: 10/15 modules (67%)
  ✓ Phase gates: 4 defined

  Missing tests:
    • M-005 Cache
    • M-008 NotificationService
    • ...
```

---

## Step 5: Generate Recommendations

```
[SKILL:grace-status] Step 5/6: Generating recommendations...
```

### Recommendation Logic

```
if modules_in_progress > 0:
  suggest: "Continue with /grace-execute"
elif modules_pending > 0:
  suggest: "Start next phase with /grace-execute"
elif verification_gaps > 0:
  suggest: "Update verification with /grace-verification"
elif all_done:
  suggest: "Run final review with /grace-reviewer"
```

---

## Summary

```
╔═══════════════════════════════════════════════════════════════════════╗
║                       GRACE PROJECT STATUS                             ║
╠═══════════════════════════════════════════════════════════════════════╣
║                                                                        ║
║  Project: my-project                                                   ║
║  Stack: TypeScript, Node.js, Fastify                                   ║
║                                                                        ║
║  Artifacts: 6/7 (86%)                                                  ║
║    ✓ All required artifacts present                                    ║
║                                                                        ║
║  Modules: 3/15 complete (20%)                                          ║
║    Phase 1: ████████░░░░░░░░░░░░ 40%                                   ║
║    Phase 2: ░░░░░░░░░░░░░░░░░░░░ 0%                                    ║
║    Phase 3: ░░░░░░░░░░░░░░░░░░░░ 0%                                    ║
║    Phase 4: ░░░░░░░░░░░░░░░░░░░░ 0%                                    ║
║                                                                        ║
║  Verification: 53% coverage                                            ║
║    ⚠ 7 modules missing tests                                           ║
║                                                                        ║
║  Knowledge Graph: ✓ Healthy                                            ║
║                                                                        ║
║  Integrations:                                                         ║
║    ✓ Entire.io (enabled) — 15 checkpoints                              ║
║    ✓ ConPort (enabled) — 42 memories                                   ║
║                                                                        ║
║  ──────────────────────────────────────────────────────────────────── ║
║                                                                        ║
║  Suggested Actions:                                                    ║
║    1. Continue M-004 Auth implementation                               ║
║    2. Add tests for completed modules                                  ║
║    3. Run /grace-execute to continue development                       ║
║                                                                        ║
║  ✅ Status: IN_PROGRESS                                                ║
║  ⏳ Next: /grace-execute (continue M-004)                              ║
║                                                                        ║
╚═══════════════════════════════════════════════════════════════════════╝
```

---

## Status Indicators

| Indicator | Meaning |
|-----------|---------|
| ✓ | Complete/Valid |
| ⏳ | In Progress |
| ○ | Pending/Optional |
| ⚠ | Warning/Needs attention |
| ✗ | Error/Missing required |

---

## Quick Commands

```bash
# Full status check
/grace-status

# Focus on specific area
/grace-status --focus=modules
/grace-status --focus=verification
/grace-status --focus=graph
```
