## GRACE Activation
<!-- Fragment: knowledge/grace-activation.md -->

When to use GRACE methodology for complex tasks that require:
  - New subsystems
  - Cross-module refactors
  - Contract changes
  - High-risk migrations
  - Multi-agent execution
  - Need for knowledge handoff

## When to Activate GRACE

If task complexity exceeds threshold, switch to GRACE-flow:

### GRACE Triggers
- New subsystem or multiple modules
- Cross-module refactor
- Contract between services/layers
- High-risk migration
- Complex multi-step implementation
- Need for multi-agent execution
- Weak observability

### GRACE Flow
1. `/grace-init` — Bootstrap structure
2. Fill `requirements.xml` and `technology.xml`
3. `/grace-plan` — Design modules
4. `/grace-verification` — Define tests
5. `/grace-execute` — Implement
6. `/grace-reviewer` — Review

7. `/grace-refresh` — Update graph

## GRACE Artifacts
- `docs/development-plan.xml` — Modules, phases, contracts
- `docs/requirements.xml` — Use cases
 decisions
- `docs/technology.xml` — Stack, tooling
- `docs/verification-plan.xml` — Tests, traces
- `docs/knowledge-graph.xml` — Module dependencies
- `docs/decisions.xml` — Architectural decisions
