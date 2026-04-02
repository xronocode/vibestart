---
name: grace-plan
description: "Design module architecture, create contracts, map data flows, and establish verification references. Produces development-plan.xml, verification-plan.xml, and knowledge-graph.xml."
---

# grace-plan Skill

Design module architecture for the project.

## Purpose

After requirements are defined in `docs/requirements.xml`, grace-plan:
1. Identifies modules needed to fulfill requirements
2. Defines contracts for each module
3. Maps dependencies between modules
4. Creates data flow descriptions
5. Establishes verification references
6. Updates all GRACE artifacts

## Input

- `docs/requirements.xml` — use cases and decisions
- `docs/technology.xml` — stack decisions

## Output

- `docs/development-plan.xml` — updated with modules
- `docs/knowledge-graph.xml` — updated with dependencies
- `docs/verification-plan.xml` — updated with references

---

## Execution Flow

```
[SKILL:grace-plan] Designing module architecture...
```

---

## Step 1: Analyze Requirements

```
[SKILL:grace-plan] Step 1/5: Analyzing requirements...
[STANDARD:grace] Reading docs/requirements.xml...
```

### Extract Use Cases

```
Found use cases:
  • UC-001: User authentication
  • UC-002: Task management
  • UC-003: Project management
  • UC-004: Team collaboration
```

### Extract Decisions

```
Found decisions:
  • D-001: Use JWT for authentication
  • D-002: PostgreSQL as database
  • D-003: REST API architecture
```

---

## Step 2: Identify Modules

```
[SKILL:grace-plan] Step 2/5: Identifying modules...
[STANDARD:grace] Mapping use cases to modules...
```

### Module Identification Process

For each use case:
1. Identify required functionality
2. Break into layers (0-5)
3. Determine dependencies
4. Assign unique ID (M-XXX)

### Module Classification

| Layer | Type | Description |
|-------|------|-------------|
| 0 | UTILITY | No dependencies (config, logger) |
| 1 | CORE_LOGIC | Depends on layer 0 only |
| 2 | DOMAIN | Business logic, depends on layers 0-1 |
| 3 | ENTRY_POINT | API routes, UI components |
| 4 | UI_COMPONENT | Frontend components |
| 5 | INTEGRATION | External services, MCP |

### Module Template

```xml
<M-XXX NAME="ModuleName" TYPE="UTILITY|CORE_LOGIC|DOMAIN|ENTRY_POINT|UI_COMPONENT|INTEGRATION" 
     LAYER="N" ORDER="N" STATUS="planned">
  <contract>
    <purpose>What this module does - one sentence</purpose>
    <inputs>
      <param name="paramName" type="Type" />
    </inputs>
    <outputs>
      <param name="returnName" type="Type" />
    </outputs>
    <errors>
      <error code="ERROR_CODE" />
    </errors>
  </contract>
  <interface>
    <export-functionName PURPOSE="What it does" />
  </interface>
  <depends>M-XXX, M-YYY</depends>
  <target>
    <source>path/to/module.ts</source>
    <tests>path/to/module.test.ts</tests>
  </target>
  <observability>
    <log-prefix>[ModuleName]</log-prefix>
    <critical-block>BLOCK_NAME</critical-block>
  </observability>
  <verification-ref>V-M-XXX</verification-ref>
</M-XXX>
```

---

## Step 3: Define Contracts

```
[SKILL:grace-plan] Step 3/5: Defining contracts...
[STANDARD:grace] Creating contracts for each module...
```

### Contract Elements

For each module, define:

1. **PURPOSE** — One sentence describing what module does
2. **SCOPE** — What operations are included
3. **INPUTS** — Parameters and their types
4. **OUTPUTS** — Return types
5. **ERRORS** — Error codes and conditions
6. **SIDE_EFFECTS** — External state changes (if any)

### Example Contract

```
M-001: Config
  PURPOSE: Load and validate all environment variables at startup
  SCOPE: Configuration loading, validation, singleton access
  INPUTS: 
    - env: NodeJS.ProcessEnv
  OUTPUTS:
    - config: AppConfig
  ERRORS:
    - CONFIG_MISSING_VAR
    - CONFIG_INVALID_VALUE
  SIDE_EFFECTS: None
```

---

## Step 4: Map Data Flows

```
[SKILL:grace-plan] Step 4/5: Mapping data flows...
[STANDARD:grace] Creating data flow descriptions...
```

### Data Flow Template

```xml
<DF-XXX NAME="Flow Name" TRIGGER="What starts this flow">
  <step-1>Description of first step</step-1>
  <step-2>Description of second step</step-2>
  <step-3>Description of third step</step-3>
  <evidence>Which module, trace, or log markers prove the flow worked</evidence>
</DF-XXX>
```

### Flow Identification

For each use case:
1. Identify the trigger (user action, event, schedule)
2. Map the steps through modules
3. Identify evidence points (logs, database changes, API responses)

---

## Step 5: Update Artifacts

```
[SKILL:grace-plan] Step 5/5: Updating GRACE artifacts...
[STANDARD:grace] Updating docs/development-plan.xml...
[STANDARD:grace] Updating docs/knowledge-graph.xml...
[STANDARD:grace] Updating docs/verification-plan.xml...
```

### Update development-plan.xml

Add:
- All identified modules
- Module contracts
- Dependencies
- Target paths
- Observability specs

### Update knowledge-graph.xml

Add:
- Module nodes
- Dependency edges
- Cross-links to requirements

### Update verification-plan.xml

Add:
- Verification references for each module
- Test file locations
- Critical scenarios

---

## Summary

```
╔═══════════════════════════════════════════════════════════════════════╗
║                    GRACE PLAN COMPLETE                                ║
╠═══════════════════════════════════════════════════════════════════════╣
║                                                                        ║
║  Modules identified: 15                                               ║
║    • Layer 0 (UTILITY): 3                                             ║
║    • Layer 1 (CORE_LOGIC): 4                                          ║
║    • Layer 2 (DOMAIN): 5                                              ║
║    • Layer 3 (ENTRY_POINT): 3                                         ║
║                                                                        ║
║  Data flows mapped: 8                                                 ║
║                                                                        ║
║  Artifacts updated:                                                   ║
║    ✓ docs/development-plan.xml                                        ║
║    ✓ docs/knowledge-graph.xml                                         ║
║    ✓ docs/verification-plan.xml                                       ║
║                                                                        ║
║  ✅ Done: Module architecture designed                                ║
║  ⏳ Next: Run /grace-verification to define tests                      ║
║           Run /grace-execute to start implementation                  ║
║                                                                        ║
╚═══════════════════════════════════════════════════════════════════════╝
```

---

## Next Steps

After planning:
1. **Review** — Check generated modules make sense
2. **Verify** — Run /grace-verification to define tests
3. **Execute** — Run /grace-execute to implement modules
