# Entire.io Session Capture

## Overview

This project uses **Entire.io** for AI session audit and checkpointing.

Entire.io captures your AI agent sessions and links them to Git commits, creating a searchable history of how code was written.

## Features

- **Session Capture**: Automatic recording of AI agent interactions
- **Checkpoints**: Versioned snapshots linked to commits
- **Search**: Find sessions by prompt, file, or commit
- **Rewind**: Rollback to previous checkpoints
- **Resume**: Continue sessions from checkpoints

## Setup

Entire.io is already configured for this project.

**Verify installation:**
```bash
entire status
```

## Usage

### During AI Sessions

Entire.io automatically captures sessions when you work with AI agents:
- Claude Code
- Cursor
- Gemini CLI
- OpenCode

### Creating Checkpoints

When you commit code, Entire.io creates a checkpoint:

```bash
git add .
git commit -m "feat: add new feature"
```

Checkpoint metadata is stored in the `entire/checkpoints/v1` branch.

### Viewing Sessions

```bash
# List all checkpoints
entire list

# View session details
entire show <checkpoint-id>

# Search sessions
entire search "keyword"
```

### Rewind and Resume

```bash
# Rewind to a previous checkpoint
entire rewind <checkpoint-id>

# Resume a session
entire resume <checkpoint-id>
```

## Best Practices

1. **Commit frequently**: Each commit creates a checkpoint
2. **Add AI-Checkpoint trailer**: Include checkpoint ID in commit message
   ```
   feat: add new feature
   
   AI-Checkpoint: chk_abc123
   ```
3. **Review before migrating**: Check session history before major refactors
4. **Use search**: Find how similar features were implemented before

## Integration with GRACE

Entire.io sessions complement GRACE artifacts:

| Entire.io | GRACE |
|-----------|-------|
| Session transcripts | Final decisions |
| Tool calls | Module contracts |
| File changes | Knowledge graph |
| Checkpoints | XML artifacts |

**Migration flow:**
1. AI session captured by Entire.io
2. Important decisions identified
3. Migrated to `docs/decisions.xml` via `migrate_to_grace()`
4. Linked in knowledge-graph.xml

## Troubleshooting

**Issue: Checkpoints not created**
```bash
# Verify hooks are installed
entire enable

# Check git hooks
ls -la .git/hooks/post-commit
```

**Issue: Branch not found**
```bash
# Create branch with first commit
git add .
git commit -m "chore: initial commit"
```

## Links

- Documentation: https://docs.entire.io
- GitHub: https://github.com/entireio/cli
