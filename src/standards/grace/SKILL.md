---
name: grace
description: "Core GRACE methodology standard - contract-first development, semantic markup, layered architecture, and knowledge graph navigation."
---

# GRACE Standard

Core methodology for contract-first development.

## Purpose

GRACE (Guided Rapid Architecture with Contract-First Execution) provides:
- **Structure** — Clear project organization
- **Contracts** — Explicit module interfaces
- **Verification** — Test-driven development
- **Traceability** — Knowledge graph navigation

## Core Principles

### 1. Contract-First

Every module has a contract before implementation:

```xml
<Module id="M-XXX" name="ModuleName">
  <Contract>
    <Purpose>One-line description</Purpose>
    <Input>inputType</Input>
    <Output>outputType</Output>
  </Contract>
</Module>
```

### 2. Semantic Markup

Code is annotated with semantic blocks:

```typescript
// BLOCK: functionName
async functionName(input: Input): Promise<Output> {
  // BLOCK_VALIDATE_INPUT
  // BLOCK_PROCESS
  // BLOCK_RETURN
}
```

### 3. Layered Architecture

Modules are organized in dependency layers:

| Layer | Types | Dependencies |
|-------|-------|--------------|
| 0 | UTILITY, DATA_LAYER | None |
| 1 | CORE_LOGIC, DOMAIN | Layer 0 |
| 2 | INTEGRATION | Layer 1 |
| 3 | ENTRY_POINT, UI_COMPONENT | Layer 2 |

### 4. Knowledge Graph

Modules and relationships form a navigable graph:

```xml
<Node id="M-Auth" />
<Edge from="M-Auth" to="M-Database" type="depends" />
```

## Rules

### GR-001: Define Contract Before Implementation

**Severity:** MANDATORY

Before writing implementation:
1. Define module in development-plan.xml
2. Specify contract (purpose, input, output, errors)
3. Add to knowledge graph
4. Define verification strategy

### GR-002: Use Semantic Blocks

**Severity:** MANDATORY

All functions must have semantic blocks:
- `BLOCK_VALIDATE_*` for input validation
- `BLOCK_PROCESS_*` for processing logic
- `BLOCK_DB_*` for database operations
- `BLOCK_RETURN` for return statements
- `BLOCK_ERROR_*` for error handling

### GR-003: Respect Layer Dependencies

**Severity:** MANDATORY

Modules can only depend on same or lower layers:
- Layer 0 → no dependencies
- Layer 1 → Layer 0 only
- Layer 2 → Layer 0, 1
- Layer 3 → Layer 0, 1, 2

### GR-004: Maintain Knowledge Graph

**Severity:** MANDATORY

Keep knowledge graph synchronized:
- Add new modules as nodes
- Record dependencies as edges
- Update on refactoring
- Remove deleted modules

### GR-005: Log with Context

**Severity:** MANDATORY

All logs must reference semantic blocks:

```
[Module][function][BLOCK_NAME] message
```

## Artifacts

| Artifact | Purpose |
|----------|---------|
| requirements.xml | What to build |
| technology.xml | How to build |
| development-plan.xml | Module structure |
| knowledge-graph.xml | Relationships |
| verification-plan.xml | Test strategy |
| decisions.xml | Architectural decisions |

## Workflow

```
1. Define requirements
2. Design modules (grace-plan)
3. Define tests (grace-verification)
4. Implement (grace-execute)
5. Review (grace-reviewer)
6. Sync artifacts (grace-refresh)
```

## Quick Reference

| Action | Command |
|--------|---------|
| Start project | /grace-init |
| Design modules | /grace-plan |
| Define tests | /grace-verification |
| Implement | /grace-execute |
| Check status | /grace-status |
| Sync artifacts | /grace-refresh |
| Debug issue | /grace-fix |
| Ask question | /grace-ask |
