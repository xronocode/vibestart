---
name: agent-transparency
description: "Every agent action MUST declare its execution context. No action may exist outside of a defined skill, standard, framework, or tool."
---

# Agent Transparency Protocol

## Purpose

Every agent action MUST declare its execution context.
No action may exist outside of a defined skill, standard, framework, or tool.

## Why This Matters

Transparency enables:
- **Traceability** — know why agent did X
- **Auditability** — verify agent followed rules
- **Learning** — user understands agent behavior
- **Debugging** — identify which layer caused issue

## Categories

### 1. SKILL

**Prefix:** `[SKILL:name]`

**When:** Executing a defined skill from skills/ directory

**Examples:**
- vs-init
- grace-init, grace-plan, grace-execute, grace-status, grace-refresh

**Format:**
```
[SKILL:vs-init] Reading vs.project.toml...
```

### 2. STANDARD

**Prefix:** `[STANDARD:name]`

**When:** Following a rule from standards/ directory

**Examples:**
- grace — contract-driven development
- architecture — layer dependencies
- error-handling — logging rules
- git-workflow — commit format

**Format:**
```
[STANDARD:grace] Updating MODULE_CONTRACT in M-001...
```

### 3. FRAMEWORK

**Prefix:** `[FRAMEWORK:name]`

**When:** Operating within framework scope

**Examples:**
- vibestart — meta-level framework operations

**Format:**
```
[FRAMEWORK:vibestart] Rendering AGENTS.md from fragments...
```

### 4. TOOL

**Prefix:** `[TOOL:name]`

**When:** Using external tool or MCP server

**Examples:**
- git — version control
- npm/pip — package manager
- docker — containerization
- mcp:conport — MCP server
- mcp:filesystem — MCP server

**Format:**
```
[TOOL:git] Committing changes...
[TOOL:mcp:conport] get_active_context → loading session...
```

### 5. SYSTEM

**Prefix:** `[SYSTEM]`

**When:** Environment and infrastructure checks

**Examples:**
- OS detection, path validation, tool availability

**Format:**
```
[SYSTEM] Checking framework installation...
```

## Rules

### Rule AT-001: Announce Before Action (MANDATORY)

**Text:** Before ANY action, agent MUST announce context.

**Valid:**
```
[SKILL:vs-init] Reading vs.project.toml...
[STANDARD:grace] Updating MODULE_CONTRACT in M-001...
[TOOL:git] Committing changes...
```

**Invalid:**
```
Reading vs.project.toml...  # No context prefix
```

**Violation:** Action without context prefix is a protocol violation.

### Rule AT-002: One Category Per Action (MANDATORY)

**Text:** Every action MUST belong to exactly ONE category.

**Valid:**
```
[SKILL:grace-status] Checking project health...
[STANDARD:architecture] Validating layer dependencies...
```

**Invalid:**
```
[SKILL:grace-status][STANDARD:grace] Checking...  # Multiple contexts
```

### Rule AT-003: Report Status After Action (MANDATORY)

**Text:** After completing action, report status.

**Format:**
```
✅ Done: [what was completed]
⏳ Next: [what comes next]
🔴 Blocked: [blocker] → [resolution needed]
```

### Rule AT-004: Chain Context for Complex Operations (RECOMMENDED)

**Text:** For complex operations, chain context with action.

**Example:**
```
[SKILL:vs-init] Step 3/5: Creating docs/ directory...
  └─→ [STANDARD:grace] Using development-plan.xml.template
  └─→ [TOOL:filesystem] Writing file
```

### Rule AT-005: MCP Tools Prefix (MANDATORY)

**Text:** When using MCP tools, prefix with mcp:

**Example:**
```
[TOOL:mcp:conport] get_active_context → loading session...
[TOOL:mcp:filesystem] read_file → loading config...
```

## Quick Reference

| Action | Context |
|--------|---------|
| Read/write docs/*.xml | `[STANDARD:grace]` |
| Run /vs-* command | `[SKILL:vs-*]` |
| Run /grace:* command | `[SKILL:grace-*]` |
| Write source code | `[STANDARD:grace]` or `[SKILL:*]` |
| Run tests | `[STANDARD:verification]` or `[SKILL:*]` |
| Git operations | `[TOOL:git]` |
| ConPort operations | `[TOOL:mcp:conport]` |
| Package manager | `[TOOL:npm]` or `[TOOL:uv]` |
| Environment check | `[SYSTEM]` |
| Framework meta | `[FRAMEWORK:vibestart]` |

## Examples

### Good Session

```
[SKILL:vs-init] Phase 1/5: Framework Integrity Check
[SYSTEM] Checking framework installation...
  ✓ ~/.vibestart/framework/ exists
  ✓ standards/ directory exists
  ✓ templates/ directory exists
✅ Done: Framework integrity verified
⏳ Next: Conflict detection

[SKILL:vs-init] Phase 2/5: Conflict Detection
[SYSTEM] Scanning for skill conflicts...
  Found: grace-init (grace-marketplace v1.0.0)
  [CONF-001] CONFLICT DETECTED: Duplicate skills
✅ Done: 1 conflict found
⏳ Next: Resolution

[SKILL:vs-init] Resolving conflict...
  Resolution: vibestart-override
  [TOOL:filesystem] Backing up original...
  [TOOL:filesystem] Installing vibestart v2.0...
✅ Done: Conflict resolved
⏳ Next: Project initialization
```

### Bad Session (Violations)

```
Reading vs.project.toml...  # ❌ No context prefix

[SKILL:vs-init][STANDARD:grace] Checking...  # ❌ Multiple contexts

Checking project health...  # ❌ No context prefix
```
