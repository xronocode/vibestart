# Kilo Code Agent Support
<!-- Support: agents/kilocode.md -->

## Installation

vibestart works with Kilo Code automatically skills located in `~/.kilocode/skills/` directory.

## Skills Path

```
~/.kilocode/skills/
├── vs-init/
└── grace/
    ├── grace-init/
    ├── grace-plan/
    ├── grace-status/
    ├── grace-refresh/
    └── ...
```

## Configuration

Kilo Code reads configuration from:
- `vs.project.toml` — project configuration
- `.kilocode/config.json` — Kilo Code settings

## Usage

### Initialize Project (includes AGENTS.md generation)
```
/vs-init
```

### GRACE Workflow
```
/grace-init
/grace-plan
/grace-verification
/grace-execute
/grace-status
/grace-refresh
```

## Custom Skills

To add custom skills, place them in `.kilocode/skills/` with structure:
```
SKILL.md
assets/
  (optional templates)
```

## MCP Integration

Kilo Code supports MCP servers via `.kilocode/mcp.json`.

### ConPort (optional)
```json
{
  "mcpServers": {
    "conport": {
      "command": "uv",
      "args": ["run", "context-portal-mcp"]
    }
  }
}
```

## Notes

- Skills are hot-reloaded with `/vs-init --resolve`
- Use `[SKILL:name]` prefix for all agent actions
- Keep `docs/SESSION_LOG.md` updated
