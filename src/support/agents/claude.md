# Claude Code Agent Support
<!-- Support: agents/claude.md -->

## Installation

vibestart works with Claude Code through skills located in `.claude/skills/` directory.

## Skills Path

```
.claude/skills/
├── vs-init/
└── grace/
    ├── grace-init/
    ├── grace-plan/
    ├── grace-status/
    ├── grace-refresh/
    └── ...
```

## Configuration

Claude Code reads configuration from:
- `vs.project.toml` — project configuration
- `.claude/config.json` — Claude Code settings

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

To add custom skills,place them in `.claude/skills/` with structure:
```
SKILL.md
assets/
  (optional templates)
```

## Configuration File

Claude Code uses `.claude/config.json` for settings:

```json
{
  "skills": {
    "directory": ".claude/skills"
  }
}
```

## Notes

- Skills are hot-reloaded with `/vs-init --resolve`
- Use `[SKILL:name]` prefix for all agent actions
- Keep `docs/SESSION_LOG.md` updated
