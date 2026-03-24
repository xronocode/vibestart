---
name: grace-explainer
description: "Complete GRACE methodology reference. Use when explaining GRACE to users, onboarding new projects, or when you need to understand the GRACE framework - its principles, semantic markup, knowledge graphs, contracts, testing, and unique tag conventions."
---

# grace-explainer Skill

Explain GRACE methodology and framework.

## Purpose

When you need to understand or explain GRACE:
1. Methodology principles
2. Semantic markup conventions
3. Knowledge graph structure
4. Contract definitions
5. Verification approach
6. Unique tag conventions

## Execution Flow

```
[SKILL:grace-explainer] Loading GRACE reference...
```

---

## GRACE Overview

GRACE (Guided Rapid Architecture with Contract-First Execution) is a methodology for AI-assisted development that provides:

1. **Structure** — Clear project organization
2. **Contracts** — Explicit module interfaces
3. **Verification** — Test-driven development
4. **Traceability** — Knowledge graph navigation

---

## Core Principles

### 1. Contract-First Development

Every module has a contract before implementation:

```xml
<Module id="M-XXX" name="ModuleName" type="CORE_LOGIC" layer="1">
  <Contract>
    <Purpose>One-line description</Purpose>
    <Input>inputType</Input>
    <Output>outputType</Output>
    <ErrorCodes>
      <Error code="ERR_001">Description</Error>
    </ErrorCodes>
  </Contract>
</Module>
```

### 2. Semantic Markup

Code is annotated with semantic blocks:

```typescript
// BLOCK: functionName
async functionName(input: InputType): Promise<OutputType> {
  // BLOCK_VALIDATE_INPUT
  if (!input) throw new Error('ERR_INVALID_INPUT');

  // BLOCK_PROCESS
  const result = await this.process(input);

  // BLOCK_RETURN
  return result;
}
```

### 3. Layered Architecture

Modules are organized in layers:

| Layer | Type | Description |
|-------|------|-------------|
| 0 | UTILITY, DATA_LAYER | Foundation, no dependencies |
| 1 | CORE_LOGIC, DOMAIN | Business logic, depends on Layer 0 |
| 2 | INTEGRATION | External services, depends on Layer 1 |
| 3 | ENTRY_POINT, UI_COMPONENT | User-facing, depends on all |

### 4. Knowledge Graph

Modules and their relationships form a graph:

```xml
<Node id="M-Auth" type="CORE_LOGIC" layer="1" />
<Edge from="M-Auth" to="M-Database" type="depends" />
<Edge from="M-Auth" to="M-Logger" type="uses" />
```

---

## GRACE Artifacts

### requirements.xml

Defines what the system should do:

```xml
<Requirements>
  <UseCase id="UC-001">
    <Name>User login</Name>
    <Actor>User</Actor>
    <Flow>1. Enter credentials 2. Validate 3. Create session</Flow>
  </UseCase>
</Requirements>
```

### technology.xml

Defines the technical stack:

```xml
<Technology>
  <Stack>
    <Language>typescript</Language>
    <Runtime>node</Runtime>
    <Framework>fastify</Framework>
  </Stack>
  <Testing>vitest</Testing>
  <Observability>pino</Observability>
</Technology>
```

### development-plan.xml

Defines modules and phases:

```xml
<DevelopmentPlan>
  <Phase id="1" name="Foundation">
    <Module id="M-001" name="Config" type="UTILITY" layer="0">
      <Contract>
        <Purpose>Load and validate configuration</Purpose>
      </Contract>
    </Module>
  </Phase>
</DevelopmentPlan>
```

### knowledge-graph.xml

Defines relationships:

```xml
<KnowledgeGraph>
  <Nodes>
    <Node id="M-001" module="Config" />
  </Nodes>
  <Edges>
    <Edge from="M-002" to="M-001" type="depends" />
  </Edges>
</KnowledgeGraph>
```

### verification-plan.xml

Defines test strategy:

```xml
<VerificationPlan>
  <V-M-001 MODULE="M-001">
    <strategy>
      <approach>unit</approach>
    </strategy>
    <test-files>
      <file>src/config.test.ts</file>
    </test-files>
  </V-M-001>
</VerificationPlan>
```

### decisions.xml

Records architectural decisions:

```xml
<Decisions>
  <Decision id="DEC-001">
    <Title>Use Fastify over Express</Title>
    <Context>Need high-performance HTTP server</Context>
    <Decision>Fastify for schema validation and performance</Decision>
    <Consequences>Faster development, better validation</Consequences>
  </Decision>
</Decisions>
```

---

## GRACE Skills

| Skill | Purpose | When to Use |
|-------|---------|-------------|
| grace-init | Bootstrap project | Starting new project |
| grace-plan | Design modules | After requirements |
| grace-execute | Implement modules | After planning |
| grace-verification | Define tests | After planning |
| grace-status | Check health | Any time |
| grace-refresh | Sync artifacts | After changes |
| grace-fix | Debug issues | When errors occur |
| grace-ask | Answer questions | Need understanding |
| grace-reviewer | Review code | Before commit |

---

## GRACE Workflow

```
1. /grace-init     → Create project structure
2. Edit requirements.xml
3. /grace-plan     → Design modules
4. /grace-verification → Define tests
5. /grace-execute  → Implement modules
6. /grace-reviewer → Review code
7. /grace-refresh  → Sync artifacts
8. Commit
9. Repeat 5-8 for each module
```

---

## Unique Tag Conventions

### Module Tags

```
M-XXX — Module identifier (M-001, M-002, etc.)
```

### Verification Tags

```
V-M-XXX — Verification entry for module
```

### Decision Tags

```
DEC-XXX — Architectural decision
```

### Use Case Tags

```
UC-XXX — Use case identifier
```

### Block Tags

```
BLOCK_NAME — Semantic block in code
```

---

## Semantic Block Naming

| Pattern | Example |
|---------|---------|
| BLOCK_VALIDATE_* | BLOCK_VALIDATE_INPUT |
| BLOCK_PROCESS_* | BLOCK_PROCESS_DATA |
| BLOCK_DB_* | BLOCK_DB_QUERY |
| BLOCK_RETURN | BLOCK_RETURN |
| BLOCK_ERROR_* | BLOCK_ERROR_HANDLE |

---

## Module Types

| Type | Layer | Description |
|------|-------|-------------|
| UTILITY | 0 | Helper functions, no state |
| DATA_LAYER | 0 | Database, cache, storage |
| CORE_LOGIC | 1 | Business logic |
| DOMAIN | 1 | Domain models |
| INTEGRATION | 2 | External services |
| ENTRY_POINT | 3 | API routes, CLI |
| UI_COMPONENT | 3 | User interface |

---

## Quick Reference

```bash
# Start new project
/grace-init

# Design architecture
/grace-plan

# Implement
/grace-execute

# Check status
/grace-status

# Debug
/grace-fix --error="..."

# Ask question
/grace-ask "How does X work?"

# Full reference
/grace-explainer
```

---

## Summary

```
╔═══════════════════════════════════════════════════════════════════════╗
║                       GRACE METHODOLOGY SUMMARY                        ║
╠═══════════════════════════════════════════════════════════════════════╣
║                                                                        ║
║  Principles:                                                           ║
║    • Contract-first development                                        ║
║    • Semantic markup in code                                           ║
║    • Layered architecture                                              ║
║    • Knowledge graph navigation                                        ║
║                                                                        ║
║  Artifacts:                                                            ║
║    • requirements.xml — What to build                                  ║
║    • technology.xml — How to build                                     ║
║    • development-plan.xml — Module structure                           ║
║    • knowledge-graph.xml — Relationships                               ║
║    • verification-plan.xml — Test strategy                             ║
║    • decisions.xml — Architectural decisions                           ║
║                                                                        ║
║  Workflow:                                                             ║
║    init → plan → verify → execute → review → refresh → commit          ║
║                                                                        ║
║  ✅ GRACE provides structure for AI-assisted development               ║
║                                                                        ║
╚═══════════════════════════════════════════════════════════════════════╝
```
