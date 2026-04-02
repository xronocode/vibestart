---
name: grace-fix
description: "Debug an issue using GRACE semantic navigation. Use when encountering bugs, errors, or unexpected behavior - navigate through the graph, verification plan, and semantic blocks to analyze the mismatch and apply a targeted fix."
---

# grace-fix Skill

Debug issues using GRACE semantic navigation.

## Purpose

When something breaks, grace-fix:
1. Locates the failing module in the graph
2. Traces dependencies to find root cause
3. Checks verification plan for expected behavior
4. Analyzes semantic blocks for the issue
5. Guides targeted fix

## Execution Flow

```
[SKILL:grace-fix] Starting debug session...
```

---

## Step 1: Gather Error Context

```
[SKILL:grace-fix] Step 1/5: Gathering error context...
```

### Ask User

```
Please provide error details:
  1. Error message or stack trace
  2. What were you trying to do?
  3. Which module or feature is affected?
  4. Any recent changes?
```

### Or Parse Error

```
Error detected:
  Type: TypeError
  Message: Cannot read property 'id' of undefined
  Location: src/modules/user/impl.ts:45
  Stack trace:
    at UserService.getById (impl.ts:45)
    at AuthMiddleware.validate (auth.ts:23)
    at Router.handle (routes.ts:15)
```

---

## Step 2: Locate in Knowledge Graph

```
[SKILL:grace-fix] Step 2/5: Locating in knowledge graph...
[STANDARD:grace] Reading docs/knowledge-graph.xml...
```

### Graph Navigation

```
Located modules:
  • M-User (src/modules/user) ← Error location
  • M-Auth (src/modules/auth) ← Caller
  • M-Router (src/routes) ← Entry point

Dependencies:
  M-Router → M-Auth → M-User → M-Database

  M-User depends on:
    • M-Database (DATA_LAYER)
    • M-Logger (UTILITY)
```

---

## Step 3: Check Verification Plan

```
[SKILL:grace-fix] Step 3/5: Checking verification plan...
[STANDARD:verification] Reading docs/verification-plan.xml...
```

### Expected Behavior

```
V-M-User (M-User):
  Contract: User retrieval and management

  Scenarios:
    • scenario-1: Get user by valid ID → returns User
    • scenario-2: Get user by invalid ID → returns null
    • scenario-3: Get user when database unavailable → throws DBError

  Traces:
    • [User][getById][BLOCK_VALIDATE_ID]
    • [User][getById][BLOCK_DB_QUERY]
    • [User][getById][BLOCK_RETURN]

  Current test status: ✗ FAILING
    Error: Expected User, got undefined
```

---

## Step 4: Analyze Semantic Blocks

```
[SKILL:grace-fix] Step 4/5: Analyzing semantic blocks...
[TOOL:filesystem] Reading src/modules/user/impl.ts...
```

### Block Analysis

```typescript
// BLOCK: getById
async getById(id: string): Promise<User | null> {
  // BLOCK_VALIDATE_ID
  if (!id) {
    this.logger.warn('[User][getById][BLOCK_VALIDATE_ID] Empty ID');
    return null;
  }

  // BLOCK_DB_QUERY
  const result = await this.db.query('SELECT * FROM users WHERE id = $1', [id]);
  // ⚠ ISSUE: No null check on result.rows[0]

  // BLOCK_RETURN
  return result.rows[0]; // ← Error: rows might be empty
}
```

### Root Cause

```
Root cause identified:
  Location: src/modules/user/impl.ts:52
  Block: BLOCK_RETURN
  Issue: No null check for empty result set

  When database returns empty rows array:
    result.rows[0] → undefined
    Accessing undefined.id → TypeError
```

---

## Step 5: Propose Fix

```
[SKILL:grace-fix] Step 5/5: Proposing fix...
```

### Fix Options

```
╔═══════════════════════════════════════════════════════════════════════╗
║                          GRACE FIX ANALYSIS                            ║
╠═══════════════════════════════════════════════════════════════════════╣
║                                                                        ║
║  Error: TypeError: Cannot read property 'id' of undefined              ║
║  Module: M-User                                                        ║
║  File: src/modules/user/impl.ts:52                                     ║
║  Block: BLOCK_RETURN                                                   ║
║                                                                        ║
║  Root Cause:                                                           ║
║    No null check for empty database result set                         ║
║                                                                        ║
║  ──────────────────────────────────────────────────────────────────── ║
║                                                                        ║
║  Proposed Fix:                                                         ║
║                                                                        ║
║  // BLOCK_RETURN                                                       ║
║  const row = result.rows[0];                                           ║
║  if (!row) {                                                           ║
║    this.logger.info('[User][getById][BLOCK_RETURN] User not found');   ║
║    return null;  // Contract: returns null for not found               ║
║  }                                                                     ║
║  return row;                                                           ║
║                                                                        ║
║  ──────────────────────────────────────────────────────────────────── ║
║                                                                        ║
║  Affected artifacts:                                                   ║
║    • docs/knowledge-graph.xml (no change needed)                       ║
║    • docs/verification-plan.xml (add edge case to V-M-User)            ║
║                                                                        ║
║  Tests to update:                                                      ║
║    • src/modules/user/user.test.ts                                     ║
║                                                                        ║
║  ✅ Ready to apply fix                                                 ║
║  ⏳ Apply fix? [Y/n]                                                   ║
║                                                                        ║
╚═══════════════════════════════════════════════════════════════════════╝
```

---

## Fix Application

After user confirms:

```
[SKILL:grace-fix] Applying fix...
[TOOL:filesystem] Writing src/modules/user/impl.ts...
  ✓ Fix applied

[STANDARD:verification] Updating test...
[TOOL:filesystem] Writing src/modules/user/user.test.ts...
  ✓ Test case added

[TOOL:bash] Running tests...
  ✓ Tests passing

[SKILL:grace-fix] Running /grace-refresh...
  ✓ Artifacts synchronized
```

---

## Summary

```
╔═══════════════════════════════════════════════════════════════════════╗
║                          GRACE FIX COMPLETE                            ║
╠═══════════════════════════════════════════════════════════════════════╣
║                                                                        ║
║  Issue: TypeError in M-User.getById                                    ║
║  Root cause: Missing null check for empty result                       ║
║                                                                        ║
║  Changes:                                                              ║
║    ✓ src/modules/user/impl.ts (fix applied)                            ║
║    ✓ src/modules/user/user.test.ts (test added)                        ║
║    ✓ docs/verification-plan.xml (scenario added)                       ║
║                                                                        ║
║  Verification:                                                         ║
║    ✓ All tests passing                                                 ║
║    ✓ Contract maintained                                               ║
║    ✓ Trace logs present                                                ║
║                                                                        ║
║  ✅ Done: Issue fixed and verified                                     ║
║  ⏳ Next: Continue with /grace-execute                                 ║
║                                                                        ║
╚═══════════════════════════════════════════════════════════════════════╝
```

---

## Debug Commands

```bash
# Interactive debug
/grace-fix

# With error context
/grace-fix --error="TypeError in user module"

# Focus on specific module
/grace-fix --module=M-User

# Dry run (analysis only, no fix)
/grace-fix --dry-run
```
