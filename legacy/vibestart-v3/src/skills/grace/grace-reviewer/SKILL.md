---
name: grace-reviewer
description: "GRACE integrity reviewer. Use for fast scoped gate reviews during execution, or full integrity audits at phase boundaries and after broader code, graph, or verification changes."
---

# grace-reviewer Skill

Review code and artifacts for GRACE integrity.

## Purpose

Ensures code and artifacts maintain GRACE standards:
1. Contract compliance
2. Semantic block presence
3. Trace log correctness
4. Graph consistency
5. Verification coverage

## Execution Flow

```
[SKILL:grace-reviewer] Starting review...
```

---

## Review Scopes

| Scope | Description | Speed |
|-------|-------------|-------|
| `--module=M-XXX` | Single module review | Fast |
| `--phase=1` | Phase gate review | Medium |
| `--full` | Complete audit | Slow |

---

## Step 1: Contract Compliance

```
[SKILL:grace-reviewer] Step 1/5: Checking contract compliance...
[STANDARD:grace] Reading docs/development-plan.xml...
```

### Checks

1. **Interface match** — Implementation matches contract
2. **Input validation** — All inputs validated
3. **Output types** — Returns match contract
4. **Error codes** — All errors defined in contract

### Output

```
Contract Compliance:
  ✓ M-Auth: Interface matches contract
  ✓ M-Auth: All inputs validated
  ✓ M-Auth: Returns match contract
  ⚠ M-Auth: Error ERR_TOKEN_EXPIRED not in contract
```

---

## Step 2: Semantic Block Review

```
[SKILL:grace-reviewer] Step 2/5: Reviewing semantic blocks...
[TOOL:filesystem] Scanning source files...
```

### Checks

1. **Block presence** — Critical functions have blocks
2. **Block naming** — Follows conventions
3. **Block coverage** — All paths covered

### Output

```
Semantic Blocks:
  ✓ src/modules/auth/impl.ts
    • BLOCK_VALIDATE_TOKEN (present)
    • BLOCK_CHECK_SESSION (present)
    • BLOCK_RETURN (present)

  ⚠ src/modules/user/impl.ts
    • Missing BLOCK_VALIDATE_ID in getById
    • Missing BLOCK_ERROR_HANDLE in createUser
```

---

## Step 3: Trace Log Review

```
[SKILL:grace-reviewer] Step 3/5: Reviewing trace logs...
[STANDARD:verification] Checking log markers...
```

### Checks

1. **Log presence** — Critical blocks log
2. **Log format** — Follows Agent Transparency Protocol
3. **Correlation IDs** — Present and propagated

### Output

```
Trace Logs:
  ✓ M-Auth: All critical blocks have logs
  ✓ M-Auth: Log format follows ATP
  ⚠ M-User: Missing correlationId in getById logs

  Expected format:
    [Module][function][BLOCK_NAME] message
    { correlationId, ...fields }
```

---

## Step 4: Graph Consistency

```
[SKILL:grace-reviewer] Step 4/5: Checking graph consistency...
[STANDARD:grace] Validating docs/knowledge-graph.xml...
```

### Checks

1. **Node validity** — All nodes reference existing modules
2. **Edge validity** — All edges reference existing nodes
3. **Layer consistency** — Edges don't violate layer rules
4. **Orphan detection** — No disconnected nodes

### Output

```
Graph Consistency:
  ✓ All nodes valid
  ✓ All edges valid
  ✓ Layer rules respected
  ⚠ Orphan detected: M-Legacy (no edges)

  Layer Rules:
    • Layer 1 can depend on Layer 0 ✓
    • Layer 2 can depend on Layer 1 ✓
    • Layer 3 can depend on Layer 2 ✓
```

---

## Step 5: Verification Coverage

```
[SKILL:grace-reviewer] Step 5/5: Checking verification coverage...
[STANDARD:verification] Reading docs/verification-plan.xml...
```

### Checks

1. **Test existence** — Test files exist
2. **Test passing** — Tests pass
3. **Coverage adequate** — Critical paths covered

### Output

```
Verification Coverage:
  ✓ M-Auth: Tests exist and pass
  ✓ M-Auth: 85% coverage
  ⚠ M-User: Tests exist but 2 failing
  ✗ M-Cache: No tests found

  Test Results:
    • Total: 45
    • Passing: 41
    • Failing: 2
    • Skipped: 2
```

---

## Phase Gate Review

For `--phase=N` reviews:

```
╔═══════════════════════════════════════════════════════════════════════╗
║                     PHASE 1 GATE REVIEW                                ║
╠═══════════════════════════════════════════════════════════════════════╣
║                                                                        ║
║  Modules: 5/5 complete (100%)                                          ║
║                                                                        ║
║  Contract Compliance:                                                  ║
║    ✓ M-001 Config                                                      ║
║    ✓ M-002 Logger                                                      ║
║    ✓ M-003 Database                                                    ║
║    ✓ M-004 Auth                                                        ║
║    ✓ M-005 Cache                                                       ║
║                                                                        ║
║  Verification:                                                         ║
║    ✓ All tests passing (45/45)                                         ║
║    ✓ Coverage: 87%                                                     ║
║                                                                        ║
║  Code Quality:                                                         ║
║    ✓ No TypeScript errors                                              ║
║    ✓ No lint errors                                                    ║
║    ✓ All semantic blocks present                                       ║
║                                                                        ║
║  ──────────────────────────────────────────────────────────────────── ║
║                                                                        ║
║  Gate Status: ✅ PASS                                                  ║
║                                                                        ║
║  Ready for Phase 2: Yes                                                ║
║  Sign-off required: Yes                                                ║
║                                                                        ║
╚═══════════════════════════════════════════════════════════════════════╝
```

---

## Full Audit

For `--full` reviews:

```
╔═══════════════════════════════════════════════════════════════════════╗
║                     GRACE INTEGRITY AUDIT                              ║
╠═══════════════════════════════════════════════════════════════════════╣
║                                                                        ║
║  Summary:                                                              ║
║    • Modules reviewed: 15                                              ║
║    • Issues found: 3                                                   ║
║    • Warnings: 5                                                       ║
║                                                                        ║
║  ──────────────────────────────────────────────────────────────────── ║
║                                                                        ║
║  Issues (must fix):                                                    ║
║    1. M-User: Missing error code in contract                           ║
║    2. M-Cache: No tests                                                ║
║    3. docs/knowledge-graph.xml: Orphan node M-Legacy                   ║
║                                                                        ║
║  Warnings (should fix):                                                ║
║    1. M-Auth: Low coverage (67%)                                       ║
║    2. M-User: Missing correlationId in logs                            ║
║    3. M-Task: Missing BLOCK_ERROR_HANDLE                               ║
║    4. docs/verification-plan.xml: Outdated test file path              ║
║    5. No session-log.md found                                          ║
║                                                                        ║
║  ──────────────────────────────────────────────────────────────────── ║
║                                                                        ║
║  Audit Status: ⚠ ISSUES FOUND                                          ║
║                                                                        ║
║  Recommended actions:                                                  ║
║    1. Fix M-User error code issue                                      ║
║    2. Add tests for M-Cache                                            ║
║    3. Remove or connect M-Legacy node                                  ║
║    4. Run /grace-refresh to sync artifacts                             ║
║                                                                        ║
╚═══════════════════════════════════════════════════════════════════════╝
```

---

## Usage

```bash
# Module review
/grace-reviewer --module=M-Auth

# Phase gate review
/grace-reviewer --phase=1

# Full audit
/grace-reviewer --full

# Quick check (changed files only)
/grace-reviewer --quick
```

---

## Review Checklist

### Contract Compliance
- [ ] Interface matches contract
- [ ] All inputs validated
- [ ] Returns match contract
- [ ] All errors defined

### Semantic Blocks
- [ ] Critical functions have blocks
- [ ] Block names follow conventions
- [ ] All paths covered

### Trace Logs
- [ ] Critical blocks log
- [ ] Format follows ATP
- [ ] Correlation IDs present

### Graph Consistency
- [ ] All nodes valid
- [ ] All edges valid
- [ ] Layer rules respected
- [ ] No orphans

### Verification
- [ ] Tests exist
- [ ] Tests pass
- [ ] Coverage adequate
