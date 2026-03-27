# ConPort Memory

## Overview

This project uses **ConPort** for long-term AI agent memory.

ConPort is an MCP server that provides persistent memory between AI sessions, enabling context carry-over and semantic search.

## Features

- **Persistent Memory**: Store memories between sessions
- **Semantic Search**: Find relevant memories by query
- **Context Carry-over**: Continue sessions with full context
- **Decision Migration**: Migrate memories to GRACE decisions

## Setup

ConPort is already configured for this project.

**Verify installation:**
```bash
conport status
```

## Usage

### Storing Memories

```bash
# Store a memory
conport store "Decided to use FastAPI for REST API"

# Store with type
conport store "User authentication uses JWT" --type decision
```

### Recalling Memories

```bash
# Search memories
conport recall "API architecture"

# List all memories
conport list
```

### Session Context

At session start, ConPort automatically loads relevant context:

```
[ConPort] Loaded 5 memories for context
[ConPort] Session started: sess_20260327_143022
```

## Integration with GRACE

### Migrating Decisions to GRACE

When a memory becomes an architectural decision, migrate it to GRACE:

```bash
# Migrate memory to decisions.xml
conport migrate mem_abc123
```

This creates:
- Entry in `docs/decisions.xml`
- Node in `docs/knowledge-graph.xml`

### Migration Flow

```
AI Session → ConPort Memory → migrate_to_grace() → GRACE XML
     ↓              ↓                    ↓              ↓
  Transcript   Persistent store   Decision XML   Knowledge Graph
```

## Best Practices

1. **Store important decisions**: Capture architectural choices
2. **Use types**: Categorize memories (decision, note, task, blocker)
3. **Migrate to GRACE**: Move architectural decisions to XML
4. **Search before implementing**: Check existing memories first

## Memory Types

| Type | Description | Example |
|------|-------------|---------|
| **decision** | Architectural decisions | "Using PostgreSQL for database" |
| **note** | General notes | "API rate limit is 100 req/min" |
| **task** | Tasks to complete | "Implement user authentication" |
| **blocker** | Blocking issues | "Waiting for API key from client" |

## Troubleshooting

**Issue: ConPort not connecting**
```bash
# Check MCP config
# Claude Code: ~/.claude/claude_desktop_config.json
# Kilo Code: .kilocode/mcp_settings.json
# Cursor: .cursor/mcp.json

# Restart agent
```

**Issue: Memory Bank not found**
```bash
# Initialize Memory Bank
conport init --project .
```

## Links

- Documentation: https://github.com/GreatScottyMac/context-portal
- GitHub: https://github.com/GreatScottyMac/context-portal
