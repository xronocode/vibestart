---
name: grace-setup-subagents
description: "Create GRACE subagent presets for the current agent shell. Use when you want GRACE worker and reviewer agent files scaffolded for Claude Code, OpenCode, Codex, or another shell."
---

# grace-setup-subagents Skill

Create GRACE subagent presets for your agent shell.

## Purpose

Sets up specialized subagents for GRACE workflow:
1. Worker agents — Execute modules
2. Reviewer agents — Verify quality
3. Coordinator presets — Manage waves

## Execution Flow

```
[SKILL:grace-setup-subagents] Setting up GRACE subagents...
```

---

## Step 1: Detect Agent Shell

```
[SKILL:grace-setup-subagents] Step 1/4: Detecting agent shell...
[SYSTEM] Checking environment...
```

### Supported Shells

| Shell | Config Directory | File Format |
|-------|------------------|-------------|
| Claude Code | `.claude/` | Markdown |
| OpenCode | `.opencode/` | YAML |
| Codex | `.codex/` | JSON |
| Cursor | `.cursor/` | Markdown |
| Generic | `.agents/` | Markdown |

### Detection

```
Detected shell: Claude Code
Config directory: .claude/
```

---

## Step 2: Create Worker Preset

```
[SKILL:grace-setup-subagents] Step 2/4: Creating worker preset...
[TOOL:filesystem] Writing .claude/agents/grace-worker.md...
```

### Worker Preset Template

```markdown
# GRACE Worker Agent

## Role
Execute module implementation following GRACE methodology.

## Instructions
1. Read module contract from docs/development-plan.xml
2. Implement following semantic block conventions
3. Add trace logs for critical blocks
4. Write tests per docs/verification-plan.xml
5. Update module status when complete

## Context Files
- docs/development-plan.xml
- docs/knowledge-graph.xml
- docs/verification-plan.xml
- src/fragments/core/*.md

## Output
- Implementation in src/modules/{module}/
- Tests in src/modules/{module}/*.test.ts
- Status update in docs/development-plan.xml
```

---

## Step 3: Create Reviewer Preset

```
[SKILL:grace-setup-subagents] Step 3/4: Creating reviewer preset...
[TOOL:filesystem] Writing .claude/agents/grace-reviewer.md...
```

### Reviewer Preset Template

```markdown
# GRACE Reviewer Agent

## Role
Review module implementation for GRACE compliance.

## Instructions
1. Check contract compliance
2. Verify semantic blocks present
3. Validate trace logs format
4. Confirm tests pass
5. Report issues and recommendations

## Checklist
- [ ] Interface matches contract
- [ ] All inputs validated
- [ ] Returns match contract
- [ ] Semantic blocks present
- [ ] Trace logs follow ATP
- [ ] Tests exist and pass

## Output
- Review report with pass/fail
- List of issues (if any)
- Recommendations for fixes
```

---

## Step 4: Create Coordinator Preset

```
[SKILL:grace-setup-subagents] Step 4/4: Creating coordinator preset...
[TOOL:filesystem] Writing .claude/agents/grace-coordinator.md...
```

### Coordinator Preset Template

```markdown
# GRACE Coordinator Agent

## Role
Coordinate multi-agent execution waves.

## Instructions
1. Read docs/development-plan.xml for module order
2. Group independent modules into waves
3. Dispatch worker agents in parallel
4. Collect results and run reviewer
5. Proceed to next wave on success

## Wave Strategy
- Wave 1: Layer 0 modules (no dependencies)
- Wave 2: Layer 1 modules (depend on Wave 1)
- Wave 3: Layer 2 modules (depend on Wave 2)
- Wave 4: Layer 3 modules (depend on all)

## Output
- Wave execution status
- Module completion status
- Error reports (if any)
```

---

## Summary

```
╔═══════════════════════════════════════════════════════════════════════╗
║                    GRACE SUBAGENTS SETUP COMPLETE                      ║
╠═══════════════════════════════════════════════════════════════════════╣
║                                                                        ║
║  Shell: Claude Code                                                    ║
║  Directory: .claude/agents/                                            ║
║                                                                        ║
║  Created presets:                                                      ║
║    ✓ grace-worker.md — Module implementation                           ║
║    ✓ grace-reviewer.md — Quality verification                          ║
║    ✓ grace-coordinator.md — Wave management                            ║
║                                                                        ║
║  Usage:                                                                ║
║    • Use worker for /grace-execute                                     ║
║    • Use reviewer for /grace-reviewer                                  ║
║    • Use coordinator for /grace-multiagent-execute                     ║
║                                                                        ║
║  ✅ Done: Subagents ready for use                                      ║
║  ⏳ Next: Run /grace-multiagent-execute for parallel execution         ║
║                                                                        ║
╚═══════════════════════════════════════════════════════════════════════╝
```

---

## Usage

```bash
# Auto-detect and setup
/grace-setup-subagents

# Specify shell
/grace-setup-subagents --shell=claude
/grace-setup-subagents --shell=opencode
/grace-setup-subagents --shell=codex

# Custom output directory
/grace-setup-subagents --output=.agents/
```

---

## Preset Customization

After creation, presets can be customized:

1. Add project-specific instructions
2. Include additional context files
3. Modify output format
4. Add custom checklists
