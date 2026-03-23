# GRACE Framework - Project Engineering Protocol

## Keywords
vibe coding, ai agent, kilo code, developer tools, onboarding, grace, conport, beginner-friendly

## Annotation
From zero to vibe coding in one paste.

## Configuration

This project uses **vs.project.toml** as master configuration for AI tooling:
- Enabled features (grace, session_log, conport, batch_mode)
- Tool configuration (testing, observability)
- Policies (secrets, RLS, system prompts)

**Technology stack** is defined in **docs/technology.xml** (GRACE artifact).

**To reconfigure:** Edit `vs.project.toml` or run `$vs-init` wizard.

## Core Principles

### 1. Never Write Code Without a Contract
Before generating or editing any module, create or update its MODULE_CONTRACT with PURPOSE, SCOPE, INPUTS, and OUTPUTS. The contract is the source of truth. Code implements the contract, not the other way around.

### 2. Semantic Markup Is Load-Bearing Structure
Markers like `// START_BLOCK_<NAME>` and `// END_BLOCK_<NAME>` are navigation anchors, not documentation. They must be:
- uniquely named
- paired
- proportionally sized so one block fits inside an LLM working window

### 3. Knowledge Graph Is Always Current
`docs/knowledge-graph.xml` is the project map. When you add a module, move a module, rename exports, or add dependencies, update the graph so future agents can navigate deterministically.

### 4. Verification Is a First-Class Artifact
Testing, traces, and log anchors are designed before large execution waves. `docs/verification-plan.xml` is part of the architecture, not an afterthought. Logs are evidence. Tests are executable contracts.

### 5. Top-Down Synthesis
Code generation follows:
`RequirementsAnalysis -> TechnologyStack -> DevelopmentPlan -> VerificationPlan -> Code + Tests`

Never jump straight to code when requirements, architecture, or verification intent are still unclear.

### 6. Governed Autonomy
Agents have freedom in HOW to implement, but not in WHAT to build. Contracts, plans, graph references, and verification requirements define the allowed space.

## Semantic Markup Reference

### Module Level
```
// FILE: path/to/file.ext
// VERSION: 1.0.0
// START_MODULE_CONTRACT
//   PURPOSE: [What this module does - one sentence]
//   SCOPE: [What operations are included]
//   DEPENDS: [List of module dependencies]
//   LINKS: [Knowledge graph references]
// END_MODULE_CONTRACT
//
// START_MODULE_MAP
//   exportedSymbol - one-line description
// END_MODULE_MAP
```

### Function or Component Level
```
// START_CONTRACT: functionName
//   PURPOSE: [What it does]
//   INPUTS: { paramName: Type - description }
//   OUTPUTS: { ReturnType - description }
//   SIDE_EFFECTS: [External state changes or "none"]
//   LINKS: [Related modules/functions]
// END_CONTRACT: functionName
```

### Code Block Level
```
// START_BLOCK_VALIDATE_INPUT
// ... code ...
// END_BLOCK_VALIDATE_INPUT
```

### Change Tracking
```
// START_CHANGE_SUMMARY
//   LAST_CHANGE: [v1.2.0 - What changed and why]
// END_CHANGE_SUMMARY
```

## Logging and Trace Convention

All important logs must point back to semantic blocks:
```
logger.info(`[ModuleName][functionName][BLOCK_NAME] message`, {
  correlationId,
  stableField: value,
});
```

Rules:
- prefer structured fields over prose-heavy log lines
- redact secrets and high-risk payloads
- treat missing log anchors on critical branches as a verification defect
- update tests when log markers change intentionally

## Verification Conventions

`docs/verification-plan.xml` is the project-wide verification contract. Keep it current when module scope, test files, commands, critical log markers, or gate expectations change.

Testing rules:
- deterministic assertions first
- trace or log assertions when trajectory matters
- test files may also carry MODULE_CONTRACT, MODULE_MAP, semantic blocks, and CHANGE_SUMMARY when they are substantial
- module-local tests should stay close to the module they verify
- wave-level and phase-level checks should be explicit in the verification plan

## File Structure
```
docs/
  requirements.xml       - Product requirements and use cases
  technology.xml         - Stack decisions, tooling, observability, testing
  development-plan.xml   - Modules, phases, data flows, ownership, write scopes
  verification-plan.xml  - Test strategy, trace expectations, module and phase gates
  knowledge-graph.xml    - Project-wide navigation graph
src/
  ... code with GRACE markup ...
tests/
  ... tests with GRACE-aware evidence where appropriate ...
```

## Documentation Artifacts - Unique Tag Convention

In `docs/*.xml`, repeated entities must use their unique ID as the XML tag name instead of a generic tag with an `ID` attribute. This reduces closing-tag ambiguity and gives LLMs stronger anchors.

### Tag naming conventions

| Entity type | Anti-pattern | Correct (unique tags) |
|---|---|---|
| Module | `<Module ID="M-CONFIG">...</Module>` | `<M-CONFIG NAME="Config" TYPE="UTILITY">...</M-CONFIG>` |
| Verification module | `<Verification ID="V-M-AUTH">...</Verification>` | `<V-M-AUTH MODULE="M-AUTH">...</V-M-AUTH>` |
| Phase | `<Phase number="1">...</Phase>` | `<Phase-1 name="Foundation">...</Phase-1>` |
| Flow | `<Flow ID="DF-SEARCH">...</Flow>` | `<DF-SEARCH NAME="...">...</DF-SEARCH>` |
| Use case | `<UseCase ID="UC-001">...</UseCase>` | `<UC-001>...</UC-001>` |
| Step | `<step order="1">...</step>` | `<step-1>...</step-1>` |
| Export | `<export name="config" .../>` | `<export-config .../>` |
| Function | `<function name="search" .../>` | `<fn-search .../>` |
| Type | `<type name="SearchResult" .../>` | `<type-SearchResult .../>` |
| Class | `<class name="Error" .../>` | `<class-Error .../>` |

### What NOT to change
- `CrossLink` tags stay self-closing
- single-use structural wrappers like `<contract>`, `<inputs>`, `<outputs>`, `<annotations>`, `<test-files>`, `<module-checks>`, and `<phase-gates>` stay generic
- code-level markup already uses unique names and stays as-is

## Session Continuity

This project uses `docs/SESSION_LOG.md` and `docs/TASK_LOG.md` for session context persistence.

### Session Management

**Files:**
- `docs/TASK_LOG.md` — Structured task tracking with checkboxes
- `docs/SESSION_LOG.md` — Machine-readable session log

**Rules:**
1. At session start — FIRST read `docs/TASK_LOG.md`
2. After EACH completed step — append to TASK_LOG.md
3. At session end — write SESSION_END to SESSION_LOG.md
4. If task interrupted — mark "INTERRUPTED at: [step]"
5. On "continue" / "resume" — find last unclosed step and continue

### Diagnostic Sequence

**Run at the START of every session:**

```
=== VIBESTART SESSION DIAGNOSTIC ===

[GRACE] Read docs/development-plan.xml → find first non-done step...
  Report: "Current position: Phase X | Step Y | Module M-XXX | Status: ..."

[GRACE] Read docs/TASK_LOG.md → check open tasks...
  Report: Last task and next step

[GRACE] Read docs/session-log.md → last session summary...
  Report: Last session status and next action

=== DIAGNOSTIC COMPLETE ===
Reporting:
- ✅ GRACE: Current position [Phase X / Step Y / Module M-XXX]
- ✅ Tasks: [N open tasks]
- ✅ Last session: [status and summary]

Awaiting instruction to proceed.
```

### Tool Context Transparency

**Every action must be announced BEFORE execution:**

```
[GRACE] Reading docs/development-plan.xml...
[Setup] Creating docs/session-log.md...
[Code] Writing src/config/index.ts...
[Test] Running verification checklist...
[Git] Committing: grace(M-001): Config module
```

**Prefixes:**
- `[System]` — checking OS, paths, tools
- `[GRACE]` — reading/writing docs/*.xml or running /grace:* commands
- `[GRACE-CODEGEN]` — planning module architecture
- `[Setup]` — configuring files and directories
- `[Code]` — writing or editing source files
- `[Test]` — running verification / tests
- `[Git]` — git operations
- `[Batch]` — batch mode autonomous execution

After completing any step, print:
```
✅ Done: [what was completed]
⏳ Next: [what comes next]
🔴 Blocked: [what is blocking] → [FOUNDER] needed
```

### GRACE Macros

Common workflows are defined in `docs/grace-macros.md`:
- `g-init` — init → plan → verification
- `g-feature` — requirements → plan → verification → execute → reviewer
- `g-drift` — status → refresh → verification
- `g-fix` — fix → verification → refresh
- `g-commit` — status → reviewer → verification → commit → refresh

**Usage:** "Run macro g-feature for [feature]"

### Batch Mode — Autonomous Work

User fills `docs/BATCH_TASKS.md` and writes "run batch". Agent executes autonomously.

**Trigger:** "batch" | "run batch" | "autonomous mode"

**Rules:**
- Read BATCH_TASKS.md top to bottom, strictly in order
- After each task: update SESSION_LOG.md and TASK_LOG.md
- Mark task: [x] DONE or [!] BLOCKED
- If blocked — record reason and proceed to next
- Do NOT ask questions — write "QUESTION: ..." under task in file

**Task Format:**
```markdown
- [ ] TASK-N | M-XXX | /grace:COMMAND | What exactly to do
```

**Limits — NEVER without explicit instruction:**
- do not touch system prompts
- do not deploy to production
- do not modify .env files
- do not delete files

## Rules for Modifications

1. Read the MODULE_CONTRACT before editing any file.
2. After editing source or test files, update MODULE_MAP if exports or helper surfaces changed.
3. After adding or removing modules, update `docs/knowledge-graph.xml`.
4. After changing test files, commands, critical scenarios, or log markers, update `docs/verification-plan.xml`.
5. After fixing bugs, add a CHANGE_SUMMARY entry and strengthen nearby verification if the old evidence was weak.
6. Never remove semantic markup anchors unless the structure is intentionally replaced with better anchors.
7. **After each session, update `docs/SESSION_LOG.md` and `docs/TASK_LOG.md`** to enable continuity.
