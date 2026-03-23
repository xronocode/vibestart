---
name: grace-init
description: "Bootstrap GRACE framework structure for a new project. Use when starting a new project with GRACE methodology - creates docs/ directory, AGENTS.md, and XML templates for requirements, technology, development plan, verification plan, and knowledge graph."
---

# grace-init Skill

Initialize GRACE framework structure for this project.

## Template Files

All documents MUST be created from template files located in this skill's `assets/` directory.
Read each template file, replace the `$PLACEHOLDER` variables with actual values gathered from the user, and write the result to the target project path.

| Template source | Target in project |
|-----------------|-------------------|
| `assets/AGENTS.md.template` | `AGENTS.md` (project root) |
| `assets/docs/knowledge-graph.xml.template` | `docs/knowledge-graph.xml` |
| `assets/docs/requirements.xml.template` | `docs/requirements.xml` |
| `assets/docs/technology.xml.template` | `docs/technology.xml` |
| `assets/docs/development-plan.xml.template` | `docs/development-plan.xml` |
| `assets/docs/verification-plan.xml.template` | `docs/verification-plan.xml` |

> **Important:** Never hardcode template content inline. Always read from the `.template` files — they are the single source of truth for document structure.

## Steps

### Step 1: Gather Project Info

Ask the user for:

```
[SKILL:grace-init] Gathering project information...

Please provide:
  1. Project name: [short name]
  2. Annotation: [one-line description]
  3. Main keywords: [comma-separated, for domain activation]
  4. Primary language: [e.g., TypeScript, Python, Go]
  5. Runtime: [e.g., Node.js, Python runtime, Go]
  6. Framework: [e.g., Fastify, Express, Django, React]
  7. Testing stack: [e.g., Vitest, Jest, pytest]
  8. Observability: [e.g., console, pino, winston]
  9. High-level module list (if known)
  10. Critical flows to verify early (2-5)
```

### Step 2: Create docs/ Directory

```
[SKILL:grace-init] Step 2/5: Creating docs/ directory...
[STANDARD:grace] Creating directory structure...
[TOOL:filesystem] Creating docs/...
  ✓ docs/ created
```

### Step 3: Populate Documents from Templates

For each `assets/docs/*.xml.template` file:

```
[SKILL:grace-init] Step 3/5: Populating documents from templates...
[STANDARD:grace] Reading template: knowledge-graph.xml.template
[STANDARD:grace] Replacing placeholders with project values...
[TOOL:filesystem] Writing docs/knowledge-graph.xml...
  ✓ docs/knowledge-graph.xml created
```

#### Template Processing

For each template:

1. **Read** the template file
2. **Identify** `$PLACEHOLDER` variables
3. **Replace** with user-provided values
4. **Write** to target path

### Step 4: Create AGENTS.md

```
[SKILL:grace-init] Step 4/5: Creating AGENTS.md...
[STANDARD:grace] Reading template: AGENTS.md.template
[STANDARD:grace] Filling with project info...
[TOOL:filesystem] Writing AGENTS.md...
  ✓ AGENTS.md created
```

#### If AGENTS.md Already Exists

```
[SKILL:grace-init] ⚠️ AGENTS.md already exists

Options:
  [1] Overwrite (backup existing first)
  [2] Keep existing (skip this step)
  [3] Merge (preserve custom sections)

Your choice [1/2/3]:
```

### Step 5: Print Summary

```
[SKILL:grace-init] Step 5/5: Summary

╔═══════════════════════════════════════════════════════════════════════╗
║                    GRACE INITIALIZATION COMPLETE                       ║
╠═══════════════════════════════════════════════════════════════════════╣
║                                                                        ║
║  Created files:                                                        ║
║    ✓ AGENTS.md                                                          ║
║    ✓ docs/knowledge-graph.xml                                          ║
║    ✓ docs/requirements.xml                                              ║
║    ✓ docs/technology.xml                                                ║
║    ✓ docs/development-plan.xml                                          ║
║    ✓ docs/verification-plan.xml                                          ║
║                                                                        ║
║  Project: my-project                                                   ║
║  Stack: typescript, node, fastify                                      ║
║  Modules: 0 (add in development-plan.xml)                              ║
║                                                                        ║
║  ✅ Done: GRACE framework initialized                                  ║
║  ⏳ Next: Run /grace-plan to design modules                              ║
║           Run /grace-verification to define tests                         ║
║                                                                        ║
╚═══════════════════════════════════════════════════════════════════════╝
```

---

## Template Variables

When processing templates, replace these placeholders:

| Placeholder | Source | Example |
|------------|--------|---------|
| `$PROJECT_NAME` | User input | "my-project" |
| `$ANNOTATION` | User input | "API for task management" |
| `$KEYWORDS` | User input | "api, tasks, node, typescript" |
| `$LANGUAGE` | User input | "typescript" |
| `$RUNTIME` | User input | "node" |
| `$FRAMEWORK` | User input | "fastify" |
| `$TESTING` | User input | "vitest" |
| `$OBSERVABILITY` | User input | "pino" |
| `$DATE` | System | "2026-03-23" |

---

## Integration with vibestart

When vibestart is installed, grace-init should:

1. **Check for vs.project.toml** — use it as configuration source
2. **Use vibestart templates** — from ~/.vibestart/framework/templates/
3. **Generate AGENTS.md** — via vs-init (integrated rendering)

### With vs.project.toml

```
[SKILL:grace-init] Found vs.project.toml
[STANDARD:grace] Using configuration from vs.project.toml...

Skipping manual input, Using:
  • Project name: my-project (from vs.project.toml)
  • Stack: typescript, node, fastify (from vs.project.toml)
  • Features: grace, session_log, batch_mode

Proceed with initialization? [Y/n]:
```

### Without vs.project.toml

Fall back to manual input mode (original behavior).

---

## Next Steps

After initialization, suggest:

1. **Define requirements** — Edit docs/requirements.xml
2. **Design modules** — Run /grace-plan
3. **Define tests** — Run /grace-verification
4. **Start development** — Run /grace-execute
