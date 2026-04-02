## Agent Transparency Protocol

<!-- Fragment: core/agent-transparency.md -->

Every agent action MUST declare its execution context. No action may exist outside of a defined skill, standard, or tool.

---

## Context Categories

| Prefix | When |
|-------|------|
| `[SKILL:name]` | Executing a defined skill from skills/ directory |
| `[STANDARD:name]`    Following a rule from standards/ directory |
| `[FRAMEWORK:name]` | Operating within framework scope |
| `[TOOL:name]`    Using external tool or MCP server |
| `[SYSTEM]` | Environment and infrastructure checks |

## Rules

### Rule AT-001: Announce Before Action (MANDATORY)
**Valid:**
```
[SKILL:vs-init] Reading vs.project.toml...
[STANDARD:grace] Updating MODULE contract...
```

**Invalid:**
```
Reading vs.project.toml...  # No context
```

Format:
✅ Done: [what was completed]
⏳ Next: [what comes next]
🔴 Blocked: [blocker] → [resolution needed]
```
**Format:**
```
✅ Done: [completed]
⏳ Next: [what comes next]
🔴 Blocked: [blocker] → [resolution needed]
```

### Rule AT-004: Chain for complex operations (REcommended)
**Example:**
```
[SKILL:vs-init] Step 3/5: Creating docs/ directory...
  └─→ [STANDARD:grace] Using development-plan.xml.template
  └─→ [TOOL:filesystem] Writing file
```

### Rule AT-005: MCP prefix (mandatory)
**Example:**
```
[TOOL:mcp:conport] get_active_context...
[TOOL:mcp:filesystem] read_file...
```

## Quick Reference
| Action | Context |
|--------|---------|
| Read/write docs/*.xml | `[STANDARD:grace]` |
| Run /vs-* command | `[SKILL:vs-*]` |
| Write source code | `[STANDARD:grace]` or `[SKILL:*]` |
| Run tests | `[STANDARD:verification]` or `[SKILL:*]` |
| Git operations | `[TOOL:git]` |
| ConPort operations | `[TOOL:mcp:conport]` |
| Package manager | `[TOOL:npm]` or `[TOOL:uv]` |
| Environment check | `[SYSTEM]` |
| Framework meta | `[FRAMEWORK:vibestart]` |
