---
name: git-workflow
description: "Git workflow standard - commit format, branching strategy, and pull request guidelines."
---

# Git Workflow Standard

Version control best practices.

## Purpose

Defines:
- Commit message format
- Branching strategy
- Pull request process
- Code review guidelines

## Commit Format

### GW-001: Use Conventional Commits

**Severity:** MANDATORY

```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

### Types

| Type | Description | Example |
|------|-------------|---------|
| `feat` | New feature | feat(auth): add JWT validation |
| `fix` | Bug fix | fix(user): correct email validation |
| `docs` | Documentation | docs(readme): update installation |
| `style` | Formatting | style: fix indentation |
| `refactor` | Code refactoring | refactor(auth): extract token logic |
| `test` | Adding tests | test(user): add getById tests |
| `chore` | Maintenance | chore: update dependencies |

### GRACE-Specific Format

For GRACE projects, include module reference:

```
grace(M-XXX): short description

Phase N, Step N
Module: ModuleName (src/path/to/file.ts)
Contract: one-line purpose from development-plan.xml
```

Example:
```
grace(M-004): implement token validation

Phase 1, Step 3
Module: Auth (src/modules/auth/impl.ts)
Contract: Validate JWT tokens and create sessions
```

## Branching Strategy

### GW-002: Use Feature Branches

**Severity:** MANDATORY

```
main
├── feature/M-004-auth
├── feature/M-005-cache
├── bugfix/user-validation
└── refactor/auth-module
```

### Branch Naming

| Pattern | Purpose | Example |
|---------|---------|---------|
| `feature/M-XXX-desc` | New feature | feature/M-004-auth |
| `bugfix/desc` | Bug fix | bugfix/user-validation |
| `refactor/desc` | Refactoring | refactor/auth-module |
| `docs/desc` | Documentation | docs/api-reference |

### GW-003: Keep Branches Short-Lived

**Severity:** RECOMMENDED**

- Feature branches should be merged within 2-3 days
- Keep branches focused on single feature/fix

## Pull Request Process

### GW-004: PR Checklist

**Severity:** MANDATORY**

Before creating PR:

- [ ] All tests pass
- [ ] No TypeScript/lint errors
- [ ] Code follows GRACE standards
- [ ] Semantic blocks present
- [ ] Documentation updated
- [ ] Commit messages follow format

### PR Template

```markdown
## Summary
- What changed and why
- Link to related issue

## Changes
- List of changes

## Testing
- How tested
- Test coverage

## Checklist
- [ ] Tests pass
- [ ] No lint errors
- [ ] Documentation updated
```

### GW-005: Require Review

**Severity:** MANDATORY

- At least one approval required
- Reviewer should check GRACE compliance
- Run `/grace-reviewer` before approval

## Merge Strategy

### GW-006: Squash and Merge

**Severity:** RECOMMENDED**

- Squash feature branch commits
- Use conventional commit for merge commit
- Delete branch after merge

## Before Commit

### Pre-Commit Checklist

```bash
# 1. Check project health
/grace-status

# 2. Run review
/grace-reviewer --module=M-XXX

# 3. Run tests
npm test

# 4. Commit
git add .
git commit -m "grace(M-XXX): description"

# 5. Sync artifacts
/grace-refresh
```

## Quick Reference

| Action | Command |
|--------|---------|
| Create branch | `git checkout -b feature/M-XXX-desc` |
| Stage changes | `git add .` |
| Commit | `git commit -m "type(scope): desc"` |
| Push | `git push -u origin branch-name` |
| Create PR | `gh pr create` |
| Merge | Squash and merge via GitHub |

## Anti-Patterns

| Anti-Pattern | Problem | Solution |
|--------------|---------|----------|
| Commit secrets | Security risk | Use environment variables |
| Large commits | Hard to review | Break into smaller commits |
| Unclear messages | Hard to understand | Use conventional commits |
| Direct main commits | Unstable main | Use feature branches |
| Long-lived branches | Merge conflicts | Merge within 2-3 days |
