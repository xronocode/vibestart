---
name: grace-multiagent-execute
description: "Execute a GRACE development plan in controller-managed parallel waves with selectable safety profiles, verification-plan excerpts, batched shared-artifact sync, and scoped reviews."
---

# grace-multiagent-execute Skill

Execute GRACE development plan with parallel agents.

## Purpose

Accelerates development by:
1. Running independent modules in parallel
2. Managing agent coordination
3. Batching artifact synchronization
4. Scoped quality reviews

## Execution Flow

```
[SKILL:grace-multiagent-execute] Starting parallel execution...
```

---

## Step 1: Analyze Dependency Graph

```
[SKILL:grace-multiagent-execute] Step 1/5: Analyzing dependencies...
[STANDARD:grace] Reading docs/knowledge-graph.xml...
```

### Wave Calculation

```
Modules: 15
Analyzing dependencies...

Wave 1 (Layer 0, no deps):
  • M-001 Config
  • M-002 Logger
  • M-003 Database

Wave 2 (Layer 1, depends on Wave 1):
  • M-004 Auth (depends: M-001, M-002, M-003)
  • M-005 Cache (depends: M-001, M-002)

Wave 3 (Layer 2, depends on Wave 2):
  • M-006 UserService (depends: M-004, M-005)
  • M-007 TaskService (depends: M-004, M-005)

Wave 4 (Layer 3, depends on Wave 3):
  • M-008 Routes (depends: M-006, M-007)
```

---

## Step 2: Select Safety Profile

```
[SKILL:grace-multiagent-execute] Step 2/5: Selecting safety profile...
```

### Safety Profiles

| Profile | Parallelism | Review | Auto-continue |
|---------|-------------|--------|---------------|
| `conservative` | 2 agents | Every module | No |
| `balanced` (default) | 3 agents | Every wave | Yes |
| `aggressive` | 5 agents | Phase gates only | Yes |

### Selection

```
Available profiles:
  [1] conservative — Maximum safety, slower
  [2] balanced — Good balance (recommended)
  [3] aggressive — Maximum speed, higher risk

Select profile [1/2/3]: 2
```

---

## Step 3: Execute Wave 1

```
[SKILL:grace-multiagent-execute] Step 3/5: Executing Wave 1...
```

### Wave Execution

```
Wave 1: Foundation (3 modules)
┌─────────────────────────────────────────────────────────────────────┐
│ Agent-1: M-001 Config                                               │
│ Agent-2: M-002 Logger                                               │
│ Agent-3: M-003 Database                                             │
└─────────────────────────────────────────────────────────────────────┘

[Agent-1] [SKILL:grace-execute] Implementing M-001 Config...
[Agent-2] [SKILL:grace-execute] Implementing M-002 Logger...
[Agent-3] [SKILL:grace-execute] Implementing M-003 Database...

[Agent-1] ✓ M-001 complete (2m 15s)
[Agent-2] ✓ M-002 complete (1m 45s)
[Agent-3] ✓ M-003 complete (3m 20s)

Wave 1 Results:
  ✓ M-001 Config: SUCCESS
  ✓ M-002 Logger: SUCCESS
  ✓ M-003 Database: SUCCESS

Running scoped review...
  ✓ All modules pass review
```

---

## Step 4: Execute Subsequent Waves

```
[SKILL:grace-multiagent-execute] Step 4/5: Executing Waves 2-4...
```

### Wave 2

```
Wave 2: Core Logic (2 modules)
┌─────────────────────────────────────────────────────────────────────┐
│ Agent-1: M-004 Auth                                                 │
│ Agent-2: M-005 Cache                                                │
└─────────────────────────────────────────────────────────────────────┘

[Agent-1] [SKILL:grace-execute] Implementing M-004 Auth...
[Agent-2] [SKILL:grace-execute] Implementing M-005 Cache...

[Agent-1] ✓ M-004 complete (4m 30s)
[Agent-2] ✓ M-005 complete (2m 10s)

Wave 2 Results:
  ✓ M-004 Auth: SUCCESS
  ✓ M-005 Cache: SUCCESS
```

### Continue Pattern for Waves 3-4...

---

## Step 5: Final Sync and Review

```
[SKILL:grace-multiagent-execute] Step 5/5: Final sync and review...
```

### Artifact Sync

```
[STANDARD:grace] Syncing artifacts...
  ✓ docs/knowledge-graph.xml updated
  ✓ docs/verification-plan.xml updated
  ✓ docs/session-log.md updated
```

### Final Review

```
[SKILL:grace-reviewer] Running full review...

Review Results:
  ✓ Contract compliance: 15/15
  ✓ Semantic blocks: 15/15
  ✓ Trace logs: 15/15
  ✓ Graph consistency: Valid
  ✓ Tests: 45/45 passing
```

---

## Summary

```
╔═══════════════════════════════════════════════════════════════════════╗
║                GRACE MULTIAGENT EXECUTION COMPLETE                     ║
╠═══════════════════════════════════════════════════════════════════════╣
║                                                                        ║
║  Profile: balanced                                                     ║
║  Waves: 4                                                              ║
║  Agents: 3 parallel                                                    ║
║                                                                        ║
║  ──────────────────────────────────────────────────────────────────── ║
║                                                                        ║
║  Results:                                                              ║
║    Wave 1: ✓ 3/3 modules (Foundation)                                  ║
║    Wave 2: ✓ 2/2 modules (Core Logic)                                  ║
║    Wave 3: ✓ 2/2 modules (Services)                                    ║
║    Wave 4: ✓ 1/1 modules (Entry Points)                                ║
║                                                                        ║
║  Total: ✓ 8/8 modules complete                                         ║
║  Duration: 18m 45s                                                     ║
║  Tests: 45/45 passing                                                  ║
║                                                                        ║
║  ──────────────────────────────────────────────────────────────────── ║
║                                                                        ║
║  Artifacts synced:                                                     ║
║    ✓ docs/knowledge-graph.xml                                          ║
║    ✓ docs/verification-plan.xml                                        ║
║    ✓ docs/session-log.md                                               ║
║                                                                        ║
║  ✅ Done: All modules implemented and verified                         ║
║  ⏳ Next: Run /grace-reviewer --full for final audit                   ║
║                                                                        ║
╚═══════════════════════════════════════════════════════════════════════╝
```

---

## Error Handling

### Module Failure

```
Wave 2 Results:
  ✓ M-004 Auth: SUCCESS
  ✗ M-005 Cache: FAILED

Error in M-005:
  TypeError: Cannot connect to Redis
  Block: BLOCK_INIT_CONNECTION

Options:
  [1] Retry M-005 with fix
  [2] Skip M-005, continue with dependent modules
  [3] Abort wave, investigate

Select [1/2/3]:
```

### Wave Abort

```
Wave aborted due to critical failure.
Modules completed: 5/8
Modules pending: 3/8

Run /grace-fix to resolve issue, then:
  /grace-multiagent-execute --resume
```

---

## Usage

```bash
# Full execution with defaults
/grace-multiagent-execute

# Specify profile
/grace-multiagent-execute --profile=conservative
/grace-multiagent-execute --profile=aggressive

# Execute specific phase
/grace-multiagent-execute --phase=1

# Resume after failure
/grace-multiagent-execute --resume

# Dry run (plan only)
/grace-multiagent-execute --dry-run
```

---

## Coordination Protocol

1. **Context packets** — Each agent receives module context
2. **Shared artifacts** — Read-only during execution
3. **Batched sync** — Artifacts updated between waves
4. **Scoped reviews** — Review after each wave
5. **Error isolation** — One failure doesn't crash others

---

## Prerequisites

Before running:
- [ ] `/grace-init` completed
- [ ] `/grace-plan` completed
- [ ] `/grace-verification` completed
- [ ] `/grace-setup-subagents` run (optional but recommended)
