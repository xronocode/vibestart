---
name: grace-refresh
description: "Synchronize GRACE shared artifacts with the actual codebase. Use targeted refresh after controlled waves, or full refresh after refactors and when you suspect wider drift between the graph, verification plan, and code."
---

# grace-refresh Skill

Synchronize GRACE artifacts with current codebase state.

## Purpose

After code changes, artifacts may drift from reality. grace-refresh:
1. Scans codebase for changes
2. Updates knowledge graph edges
3. Syncs verification plan with tests
4. Updates session log
5. Validates consistency

## Execution Flow

```
[SKILL:grace-refresh] Refreshing GRACE artifacts...
```

---

## Step 1: Detect Changes

```
[SKILL:grace-refresh] Step 1/5: Detecting changes...
[TOOL:git] Checking git status...
```

### Change Detection

```
Changes detected:
  Modified:
    • src/modules/auth/contract.ts
    • src/modules/auth/impl.ts
    • src/modules/user/impl.ts

  Added:
    • src/modules/cache/contract.ts
    • src/modules/cache/impl.ts

  Deleted:
    • src/modules/legacy/old-service.ts
```

---

## Step 2: Update Knowledge Graph

```
[SKILL:grace-refresh] Step 2/5: Updating knowledge graph...
[STANDARD:grace] Reading docs/knowledge-graph.xml...
```

### Graph Updates

1. **Add new nodes** — For new modules/files
2. **Remove stale nodes** — For deleted files
3. **Update edges** — For changed dependencies
4. **Update cross-links** — For new references

### Output

```
Knowledge Graph Updates:
  + Added node: M-Cache (src/modules/cache)
  - Removed node: M-Legacy (src/modules/legacy)
  ~ Updated edge: M-Auth → M-Cache
  ~ Updated edge: M-User → M-Cache

  ✓ Graph synchronized (4 changes)
```

---

## Step 3: Sync Verification Plan

```
[SKILL:grace-refresh] Step 3/5: Syncing verification plan...
[STANDARD:verification] Scanning test files...
```

### Verification Sync

1. **Detect new tests** — Add to verification plan
2. **Remove stale tests** — Clean up deleted test references
3. **Update trace expectations** — Based on code changes

### Output

```
Verification Plan Updates:
  + Added test: src/modules/cache/cache.test.ts
  - Removed test: src/modules/legacy/old-service.test.ts
  ~ Updated traces for: M-Auth, M-User

  ✓ Verification synchronized (3 changes)
```

---

## Step 4: Update Session Log

```
[SKILL:grace-refresh] Step 4/5: Updating session log...
[STANDARD:grace] Appending to docs/session-log.md...
```

### Session Log Entry

```markdown
## Session: 2026-03-24

### Changes
- Added M-Cache module
- Removed M-Legacy module
- Updated M-Auth dependencies

### Artifacts Updated
- docs/knowledge-graph.xml (4 changes)
- docs/verification-plan.xml (3 changes)

### Next Steps
- Continue with M-UserService implementation
```

---

## Step 5: Validate Consistency

```
[SKILL:grace-refresh] Step 5/5: Validating consistency...
[STANDARD:grace] Cross-referencing artifacts...
```

### Consistency Checks

1. **Module references** — All modules in dev plan exist in graph
2. **Test references** — All test files exist
3. **Dependency validity** — All edges reference existing modules

### Output

```
Consistency Check:
  ✓ All modules referenced in graph
  ✓ All test files exist
  ✓ All dependencies valid
  ✓ No orphan nodes
```

---

## Summary

```
╔═══════════════════════════════════════════════════════════════════════╗
║                       GRACE REFRESH COMPLETE                           ║
╠═══════════════════════════════════════════════════════════════════════╣
║                                                                        ║
║  Changes detected: 6                                                   ║
║    • Modified: 3 files                                                 ║
║    • Added: 2 files                                                    ║
║    • Deleted: 1 file                                                   ║
║                                                                        ║
║  Artifacts updated:                                                    ║
║    ✓ docs/knowledge-graph.xml (4 changes)                              ║
║    ✓ docs/verification-plan.xml (3 changes)                            ║
║    ✓ docs/session-log.md (entry added)                                 ║
║                                                                        ║
║  Consistency: ✓ All checks passed                                      ║
║                                                                        ║
║  ✅ Done: Artifacts synchronized with codebase                         ║
║  ⏳ Next: Continue development with /grace-execute                     ║
║                                                                        ║
╚═══════════════════════════════════════════════════════════════════════╝
```

---

## Refresh Modes

### Full Refresh

```bash
/grace-refresh
```

Scans entire codebase and updates all artifacts.

### Targeted Refresh

```bash
/grace-refresh --module=M-Auth
/grace-refresh --phase=1
/grace-refresh --file=src/modules/auth/impl.ts
```

Only updates artifacts related to specific scope.

### Dry Run

```bash
/grace-refresh --dry-run
```

Shows what would be updated without making changes.

---

## When to Use

| Scenario | Command |
|----------|---------|
| After implementing a module | `/grace-refresh --module=M-XXX` |
| After refactoring | `/grace-refresh` |
| Before commit | `/grace-refresh --dry-run` |
| After merge | `/grace-refresh` |
| Suspected drift | `/grace-refresh` |
