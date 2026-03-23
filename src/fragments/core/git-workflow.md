## Git Workflow

<!-- Fragment: core/git-workflow.md -->

## Commit Format

```
grace(M-XXX): short description in imperative mood

Phase N, Step N
Module: ModuleName (src/path/to/file.ts)
Contract: one-line purpose from development-plan.xml
```

## Branching

- `main` — production
- `feature/*` — feature branches
- `bugfix/*` — bug fixes

- `refactor/*` — refactoring

## Commit Message Guidelines
1. **Imperative mood** — do imperative
2. **One-line purpose** — reference contract from development-plan.xml
3. **Scope** — reference module scope
4. **No secrets** — never commit secrets, tokens, credentials

## Pull Requests
1. Create feature branch from main
2. Implement feature
3. Run tests before PR
4. Update documentation after merge
5. Request review

## Before Commit
1. Run `/grace-status` — check project health
2. Run `/grace-reviewer` — code review
3. Run tests
4. Commit
5. Run `/grace-refresh` — update session log and artifacts

