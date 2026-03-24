# vibestart Verification Checklist

This checklist helps agents verify framework integrity before autonomous execution.

## Prerequisites
- [ ] docs/requirements.xml exists
- [ ] docs/technology.xml exists
- [ ] docs/verification-plan.xml exists
- [ ] docs/development-plan.xml exists

## Verification Levels

### Module Level (Deterministic Checks)
- [ ] File existence
- [ ] File validity (XML, TOML, Markdown)
- [ ] Content patterns
- [ ] Directory structure

### Wave Level (Integration)
- [ ] Cross-module compatibility
- [ ] Data flow verification
- [ ] Integration tests for merged surfaces

### Phase Level (Full suite)
- [ ] Complete workflow verification
- [ ] End-to-end scenario tests
- [ ] Final confidence checks
- [ ] Phase gate validation

## Verification Commands

### Module Level
```bash
# Foundation (Layer 0)
ls -la src/framework.toml
ls -la src/standards/*/ | wc -l
ls -la src/templates/*.xml.template | wc -l
ls -la src/fragments/*/*.md | wc -l
```

### Wave Level
```bash
# Core Skills (Layer 1)
find src/skills -name "*.md" | wc -l
ls -la src/skills/vs-init/SKILL.md
ls -la src/skills/grace/*/SKILL.md | wc -l
```

### Phase Level
```bash
# All modules
find . -name "*.md" -o - name "*.xml" | wc -l
find . -name "*.toml" | wc -l
# Verify XML templates
grep -l '$' src/templates/*.xml.template | wc -l
# Verify GRACE artifacts
ls -la docs/*.xml | wc -l
```

## Expected Results

### ✅ All Files Present
```
M-CONFIG:
  ✓ src/framework.toml

M-STANDARDS:
  ✓ src/standards/agent-transparency/SKILL.md
  ✓ src/standards/agent-transparency/rules.xml
  ✓ src/standards/compatibility/SKILL.md
  ✓ src/standards/compatibility/rules.xml

M-TEMPLATES:
  ✓ src/templates/development-plan.xml.template
  ✓ src/templates/requirements.xml.template
  ✓ src/templates/knowledge-graph.xml.template
  ✓ src/templates/verification-plan.xml.template
  ✓ src/templates/technology.xml.template
  ✓ src/templates/decisions.xml.template

M-FRAGMENTS:
  ✓ src/fragments/core/architecture.md
  ✓ src/fragments/core/error-handling.md
  ✓ src/fragments/core/git-workflow.md
  ✓ src/fragments/core/agent-transparency.md
  ✓ src/fragments/process/design-first.md
  ✓ src/fragments/process/batch-mode.md
  ✓ src/fragments/process/session-management.md
  ✓ src/fragments/knowledge/grace-activation.md
```

## Trace Requirements

### M-VSINIT
```
[SKILL:vs-init] Phase 1/6: Framework Integrity Check
[SKILL:vs-init] Phase 2/6: Conflict Detection
[SKILL:vs-init] Phase 3/6: Resolution Summary
[SKILL:vs-init] Phase 4/6: Execute Resolution
[SKILL:vs-init] Phase 5/6: Render AGENTS.md
[SKILL:vs-init] Phase 6/6: Project Integrity Verification
```

### M-GRACEINIT
```
[SKILL:grace-init] Gathering project information...
[SKILL:grace-init] Step 2/5: Creating docs/ directory...
[SKILL:grace-init] Step 3/5: Populating documents...
[SKILL:grace-init] Step 4/5: Creating AGENTS.md
[SKILL:grace-init] Step 5/5: Summary
```

## Failure Triage

When verification fails, produce a failure packet:

```
FAILURE PACKET:
- Contract: [which contract or scenario failed]
- Expected: [what should have happened]
- Observed: [what actually happened]
- Divergent: [where did it go wrong]
- Next Action: [how to fix]
```

## Autonomous Execution Safety

**Safe for Autonomous Execution:**
- ✅ M-CONFIG (deterministic only)
- ✅ M-STANDARDS (deterministic only)
- ✅ M-TEMPLATES (deterministic only)
- ✅ M-FRAGMENTS (deterministic only)
- ✅ M-GRACEEXEC (deterministic)
- ✅ M-GRACEVERIFY (deterministic only)

**Requires Human Oversight:**
- ⚠️ M-VSINIT (conflict resolution needs user decision)
- ⚠️ M-GRACEINIT (project info gathering needs user input)
- ⚠️ M-GRACEPLAN (architecture approval needs user confirmation)

## Next Steps

1. Run verification: `./verify-vibestart.sh --level module`
2. Fix any failures
3. Run verification again: `./verify-vibestart.sh --level wave`
4. Run final verification: `./verify-vibestart.sh --level phase`
5. All tests pass → ready for autonomous execution
