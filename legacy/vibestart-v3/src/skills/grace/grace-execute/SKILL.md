---
name: grace-execute
description: "Execute the GRACE development plan step by step with controller-managed context packets, verification-plan excerpts, scoped reviews, level-based verification, and commits after validated sequential steps."
---

# grace-execute Skill

Execute the GRACE development plan step by step.

## Purpose

Implement modules according to `docs/development-plan.xml`:
1. Execute modules in dependency order
2. Follow contracts strictly
3. Verify each module before proceeding
4. Commit after each validated step

## Execution Mode

**Sequential execution** — one module at a time, verified before proceeding.

For parallel execution, use `/grace-multiagent-execute`.

---

## Execution Flow

```
[SKILL:grace-execute] Starting sequential execution...
```

---

## Step 1: Find Next Module

```
[SKILL:grace-execute] Step 1: Finding next module to implement...
[STANDARD:grace] Reading docs/development-plan.xml...
```

### Selection Criteria

1. **STATUS = "planned"** — not yet started
2. **Lowest LAYER** — dependencies first
3. **Lowest ORDER** — within layer
4. **All dependencies STATUS = "done"** — can proceed

```
Found next module:
  • M-001: Config (LAYER=0, ORDER=1)
  • Dependencies: none
  • Status: planned
```

---

## Step 2: Load Context

```
[SKILL:grace-execute] Step 2: Loading context for M-001...
[STANDARD:grace] Reading module contract...
[STANDARD:grace] Reading verification requirements...
```

### Context Packet

```
Module: M-001 Config
Contract:
  PURPOSE: Load and validate all environment variables at startup
  SCOPE: Configuration loading, validation, singleton access
  
Verification (V-M-001):
  • Config loads successfully with valid env
  • Config throws on missing required variable
  • Config throws on invalid value
  • Config is singleton (same instance returned)

Target:
  • Source: src/lib/config/index.ts
  • Tests: src/lib/config/index.test.ts
```

---

## Step 3: Implement Module

```
[SKILL:grace-execute] Step 3: Implementing M-001...
[STANDARD:grace] Creating source file...
[STANDARD:grace] Adding MODULE_CONTRACT...
[STANDARD:grace] Adding semantic blocks...
[TOOL:filesystem] Writing src/lib/config/index.ts...
```

### Implementation Requirements

1. **Add MODULE_CONTRACT** at top of file
2. **Add semantic blocks** for critical sections
3. **Follow contract** exactly (inputs, outputs, errors)
4. **Add log markers** with correlationId
5. **Handle all error cases** defined in contract

### Example Implementation

```typescript
// FILE: src/lib/config/index.ts
// VERSION: 1.0.0
// START_MODULE_CONTRACT
//   PURPOSE: Load and validate all environment variables at startup
//   SCOPE: Configuration loading, validation, singleton access
//   DEPENDS: none
//   LINKS: M-001
// END_MODULE_CONTRACT
//
// START_MODULE_MAP
//   getConfig - Returns validated AppConfig singleton
//   validateEnv - Validates environment variables
// END_MODULE_MAP

import { z } from 'zod';

// START_BLOCK_SCHEMA
const configSchema = z.object({
  NODE_ENV: z.enum(['development', 'test', 'production']),
  DATABASE_URL: z.string().url(),
  JWT_SECRET: z.string().min(32),
  // ...
});
// END_BLOCK_SCHEMA

// START_BLOCK_VALIDATE_ENV
export function validateEnv(env: NodeJS.ProcessEnv): AppConfig {
  const result = configSchema.safeParse(env);
  
  if (!result.success) {
    logger.error('[Config][validateEnv][BLOCK_VALIDATE_ENV] Invalid config', {
      errors: result.error.errors,
    });
    throw new ConfigError('CONFIG_INVALID_VALUE', result.error);
  }
  
  return result.data;
}
// END_BLOCK_VALIDATE_ENV

// START_BLOCK_SINGLETON
let configInstance: AppConfig | null = null;

export function getConfig(): AppConfig {
  if (!configInstance) {
    configInstance = validateEnv(process.env);
    logger.info('[Config][getConfig][BLOCK_SINGLETON] Config loaded');
  }
  return configInstance;
}
// END_BLOCK_SINGLETON

// START_CHANGE_SUMMARY
//   LAST_CHANGE: [v1.0.0 - Initial implementation]
// END_CHANGE_SUMMARY
```

---

## Step 4: Write Tests

```
[SKILL:grace-execute] Step 4: Writing tests for M-001...
[STANDARD:grace] Reading verification requirements...
[STANDARD:verification] Creating test file...
[TOOL:filesystem] Writing src/lib/config/index.test.ts...
```

### Test Requirements

Based on V-M-001:
1. Config loads successfully with valid env
2. Config throws on missing required variable
3. Config throws on invalid value
4. Config is singleton (same instance returned)

### Example Tests

```typescript
// FILE: src/lib/config/index.test.ts
// START_MODULE_CONTRACT
//   PURPOSE: Verify Config module behavior
//   SCOPE: Test all verification requirements from V-M-001
// END_MODULE_CONTRACT

import { describe, it, expect, beforeEach } from 'vitest';
import { getConfig, validateEnv } from './index';

describe('Config', () => {
  beforeEach(() => {
    // Reset singleton
    configInstance = null;
  });

  it('loads successfully with valid env', () => {
    const validEnv = {
      NODE_ENV: 'development',
      DATABASE_URL: 'postgresql://localhost:5432/test',
      JWT_SECRET: 'a'.repeat(32),
    };
    
    const config = validateEnv(validEnv);
    expect(config.NODE_ENV).toBe('development');
    expect(config.DATABASE_URL).toBe(validEnv.DATABASE_URL);
  });

  it('throws on missing required variable', () => {
    const invalidEnv = {
      NODE_ENV: 'development',
      // DATABASE_URL missing
      JWT_SECRET: 'a'.repeat(32),
    };
    
    expect(() => validateEnv(invalidEnv)).toThrow(ConfigError);
  });

  it('throws on invalid value', () => {
    const invalidEnv = {
      NODE_ENV: 'invalid', // Not in enum
      DATABASE_URL: 'not-a-url',
      JWT_SECRET: 'short',
    };
    
    expect(() => validateEnv(invalidEnv)).toThrow(ConfigError);
  });

  it('returns singleton instance', () => {
    process.env.NODE_ENV = 'test';
    process.env.DATABASE_URL = 'postgresql://localhost:5432/test';
    process.env.JWT_SECRET = 'a'.repeat(32);
    
    const config1 = getConfig();
    const config2 = getConfig();
    
    expect(config1).toBe(config2);
  });
});
```

---

## Step 5: Run Verification

```
[SKILL:grace-execute] Step 5: Running verification for M-001...
[STANDARD:verification] Running tests...
[TOOL:npm] npm test -- src/lib/config/index.test.ts
```

### Verification Checklist

```
V-M-001 Verification Checklist:

  [✓] Config loads successfully with valid env
  [✓] Config throws on missing required variable
  [✓] Config throws on invalid value
  [✓] Config is singleton (same instance returned)

Result: PASS
```

### If Verification Fails

```
V-M-001 Verification Checklist:

  [✓] Config loads successfully with valid env
  [✓] Config throws on missing required variable
  [✓] Config throws on invalid value
  [✗] Config is singleton (same instance returned)
      Error: Expected config1 to be config2
      Reason: Singleton not properly reset between tests

Result: FAIL

🔴 BLOCKED: Verification failed for M-001
→ Fix issue and re-run verification
```

---

## Step 6: Update Status

```
[SKILL:grace-execute] Step 6: Updating module status...
[STANDARD:grace] Updating docs/development-plan.xml...
  ✓ M-001 STATUS="done"
```

---

## Step 7: Commit

```
[SKILL:grace-execute] Step 7: Committing changes...
[STANDARD:git-workflow] Preparing commit...
[TOOL:git] git add src/lib/config/index.ts src/lib/config/index.test.ts
[TOOL:git] git commit -m "grace(M-001): Config module — env validation

Phase 1, Step 1
Module: Config (src/lib/config/index.ts)
Contract: Load and validate all environment variables at startup"
```

---

## Step 8: Update Knowledge Graph

```
[SKILL:grace-execute] Step 8: Updating knowledge graph...
[STANDARD:grace] Adding M-001 to docs/knowledge-graph.xml...
  ✓ Node added
  ✓ Exports recorded
```

---

## Repeat for Next Module

```
[SKILL:grace-execute] Finding next module...
  → M-002: Logger (LAYER=0, ORDER=2)

✅ Done: M-001 Config
⏳ Next: M-002 Logger
```

---

## Summary

```
╔═══════════════════════════════════════════════════════════════════════╗
║                    GRACE EXECUTE PROGRESS                              ║
╠═══════════════════════════════════════════════════════════════════════╣
║                                                                        ║
║  Completed: 1/15 modules                                               ║
║  In progress: M-002 Logger                                             ║
║  Remaining: 13                                                         ║
║                                                                        ║
║  Phase 1 (Foundation):                                                ║
║    ✓ M-001 Config                                                      ║
║    ⏳ M-002 Logger (next)                                              ║
║    ○ M-003 Database                                                    ║
║    ○ M-004 Auth                                                         ║
║                                                                        ║
║  Commits: 1                                                            ║
║  Tests: 4 passing                                                      ║
║                                                                        ║
║  ✅ Done: Continuing with M-002...                                     ║
║                                                                        ║
╚═══════════════════════════════════════════════════════════════════════╝
```

---

## Execution Rules

1. **Never skip verification** — every module must pass tests
2. **Never skip commit** — commit after each verified module
3. **Never skip status update** — keep development-plan.xml current
4. **Stop on failure** — don't proceed if verification fails
5. **One module at a time** — sequential, not parallel
