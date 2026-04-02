---
name: grace-verification
description: "Define tests, traces, and log-driven verification for modules. Creates or updates docs/verification-plan.xml with test strategy, trace expectations, module and phase gates."
---

# grace-verification Skill

Define verification strategy for the project.

## Purpose

After modules are planned in `docs/development-plan.xml`, grace-verification:
1. Defines test strategy for each module
2. Specifies trace expectations
3. Creates module-level verification entries
4. Defines phase gates
5. Establishes log marker requirements

## Input

- `docs/development-plan.xml` — modules and contracts

## Output

- `docs/verification-plan.xml` — complete verification strategy

---

## Execution Flow

```
[SKILL:grace-verification] Defining verification strategy...
```

---

## Step 1: Analyze Modules

```
[SKILL:grace-verification] Step 1/5: Analyzing modules...
[STANDARD:grace] Reading docs/development-plan.xml...
```

### Extract Module Contracts

```
Found modules:
  • M-001: Config (UTILITY, LAYER=0)
  • M-002: Logger (UTILITY, LAYER=0)
  • M-003: Database (DATA_LAYER, LAYER=0)
  • M-004: Auth (CORE_LOGIC, LAYER=1)
  ...
```

---

## Step 2: Define Test Strategy Per Module

```
[SKILL:grace-verification] Step 2/5: Defining test strategies...
[STANDARD:verification] Creating verification entries...
```

### Verification Entry Template

```xml
<V-M-XXX MODULE="M-XXX">
  <contract>
    <purpose>Verify module behavior matches contract</purpose>
  </contract>
  <strategy>
    <approach>unit | integration | e2e</approach>
    <mocking>fakes | stubs | mocks | none</mocking>
  </strategy>
  <test-files>
    <file>path/to/module.test.ts</file>
  </test-files>
  <scenarios>
    <scenario-1>Happy path description</scenario-1>
    <scenario-2>Error case description</scenario-2>
    <scenario-3>Edge case description</scenario-3>
  </scenarios>
  <traces>
    <trace-1>Expected log marker or trace</trace-1>
  </traces>
  <commands>
    <test-command>npm test -- path/to/module.test.ts</test-command>
  </commands>
  <critical-blocks>
    <block>BLOCK_NAME</block>
  </critical-blocks>
</V-M-XXX>
```

### Test Strategy by Module Type

| Module Type | Test Approach | Mocking |
|------------|---------------|---------|
| UTILITY | Unit | Fakes |
| CORE_LOGIC | Unit + Integration | Fakes, Stubs |
| DATA_LAYER | Integration | Test database |
| DOMAIN | Unit + Integration | Fakes |
| ENTRY_POINT | Integration + E2E | Stubs |
| UI_COMPONENT | Unit + E2E | Mocks |
| INTEGRATION | Integration | Stubs |

---

## Step 3: Define Trace Expectations

```
[SKILL:grace-verification] Step 3/5: Defining trace expectations...
[STANDARD:verification] Adding log marker requirements...
```

### Trace Requirements

For each module, specify:
1. **Required log markers** — critical blocks must log
2. **Log format** — structured fields expected
3. **Trace assertions** — what tests should verify in logs

### Example Trace Requirements

```
M-001: Config
  Required log markers:
    • [Config][validateEnv][BLOCK_VALIDATE_ENV]
    • [Config][getConfig][BLOCK_SINGLETON]
  
  Expected log format:
    {
      "level": "info|error",
      "message": "...",
      "correlationId": "uuid",
      "module": "Config",
      "block": "BLOCK_NAME"
    }
  
  Trace assertions:
    • On valid config: info log with correlationId
    • On invalid config: error log with error details
```

---

## Step 4: Define Phase Gates

```
[SKILL:grace-verification] Step 4/5: Defining phase gates...
[STANDARD:verification] Creating phase gate criteria...
```

### Phase Gate Template

```xml
<Phase-Gate-N>
  <name>Phase N Name</name>
  <criteria>
    <criterion-1>All modules in phase have STATUS="done"</criterion-1>
    <criterion-2>All verification tests pass</criterion-2>
    <criterion-3>Performance targets met</criterion-3>
    <criterion-4>Security scan clean</criterion-4>
  </criteria>
  <commands>
    <verify-command>npm test</verify-command>
    <lint-command>npm run lint</lint-command>
  </commands>
  <sign-off required="true|false" />
</Phase-Gate-N>
```

### Example Phase Gate

```
Phase-Gate-1: Foundation
  Criteria:
    ✓ M-001 Config: STATUS="done"
    ✓ M-002 Logger: STATUS="done"
    ✓ M-003 Database: STATUS="done"
    ✓ M-004 Auth: STATUS="done"
    ✓ All tests pass
    ✓ No TypeScript errors
  
  Commands:
    • npm test
    • npm run lint
    • npm run typecheck
  
  Sign-off required: true
```

---

## Step 5: Update Verification Plan

```
[SKILL:grace-verification] Step 5/5: Updating verification plan...
[STANDARD:grace] Writing docs/verification-plan.xml...
  ✓ Module checks: 15
  ✓ Phase gates: 4
  ✓ Trace requirements: 15
```

---

## Summary

```
╔═══════════════════════════════════════════════════════════════════════╗
║                    GRACE VERIFICATION COMPLETE                        ║
╠═══════════════════════════════════════════════════════════════════════╣
║                                                                        ║
║  Verification entries created: 15                                     ║
║  Phase gates defined: 4                                               ║
║  Trace requirements specified: 15                                     ║
║                                                                        ║
║  Test coverage:                                                       ║
║    • Unit tests: 12 modules                                           ║
║    • Integration tests: 8 modules                                     ║
║    • E2E tests: 3 flows                                               ║
║                                                                        ║
║  Critical blocks requiring logs: 12                                   ║
║                                                                        ║
║  ✅ Done: Verification strategy defined                               ║
║  ⏳ Next: Run /grace-execute to implement modules                     ║
║                                                                        ║
╚═══════════════════════════════════════════════════════════════════════╝
```

---

## Verification Levels

### Level 1: Contract Verification

- Inputs/outputs match contract
- Error codes raised correctly
- Side effects documented

### Level 2: Behavior Verification

- Happy path works
- Error cases handled
- Edge cases covered

### Level 3: Integration Verification

- Dependencies work correctly
- Data flows as expected
- Cross-module communication

### Level 4: Trace Verification

- Log markers present
- Structured fields correct
- Correlation IDs propagated

---

## Next Steps

After verification definition:
1. **Review** — Check verification entries are complete
2. **Execute** — Run /grace-execute to implement with verification
