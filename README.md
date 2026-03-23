# vibestart

**From zero to vibe coding in one paste.**

[![Version](https://img.shields.io/badge/version-2.1.0-blue.svg)](https://github.com/xronocode/vibestart/releases/tag/v2.1.0)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

---

## 🤖 For AI Agents

You found this repository. The user wants to use vibestart in their project.

### What is vibestart?

vibestart is a **skill** for AI agents that provides:
- GRACE methodology (contract-driven development)
- Knowledge graphs for project navigation
- Session management (AI remembers context)
- Agent transparency (every action is traceable)

### How to Install

**Option 1: Copy to project (Recommended)**

Copy `src/skills/vs-init/` folder to your agent's skills directory in the **current project**:

| Agent | Skills Directory |
|-------|-----------------|
| Kilo Code | `.kilocode/skills/vs-init/` |
| Cursor | `.cursor/skills/vs-init/` |
| Claude Code | `.claude/skills/vs-init/` |

Example for Kilo Code:
```
# Create skills directory if not exists
mkdir -p .kilocode/skills

# Copy the skill
cp -r src/skills/vs-init .kilocode/skills/
```

**Option 2: Global installation**

Copy to user-level skills directory:

| OS | Path |
|----|------|
| Windows | `%USERPROFILE%\.kilocode\skills\vs-init\` |
| macOS/Linux | `~/.kilocode/skills/vs-init/` |

### How to Use

After copying the skill, run in your project:

```
/vs-init
```

This single command will:
1. Check framework integrity
2. Detect and resolve conflicts
3. Create `vs.project.toml` (project configuration)
4. Generate `AGENTS.md` (agent instructions)
5. Create `docs/*.xml` templates (GRACE artifacts)

### Verify

```
/grace-status
```

---

## 💡 Why vibestart?

### The Problem

You're new to AI-assisted development. You have:
- ❌ No idea how to structure AI instructions
- ❌ No methodology for AI to follow
- ❌ No way to track decisions across sessions
- ❌ No standards for code quality

### The Solution

vibestart gives you:
- ✅ **One-command setup** — `/vs-init` does everything
- ✅ **GRACE methodology** — contract-driven development with knowledge graphs
- ✅ **Session continuity** — AI remembers what it did yesterday
- ✅ **Agent transparency** — every action is traceable
- ✅ **Conflict detection** — handles existing tools gracefully

---

## 🆚 vibestart vs Alternatives

| Feature | vibestart | GRACE marketplace | ai-standards | Manual setup |
|---------|-----------|-------------------|--------------|--------------|
| **One-command init** | ✅ `/vs-init` | ❌ Multiple steps | ❌ Manual copy | ❌ Hours of work |
| **Conflict detection** | ✅ 6 types | ❌ None | ❌ None | ❌ None |
| **AGENTS.md generation** | ✅ Auto from fragments | ❌ Manual | ❌ Manual | ❌ Manual |
| **Migration support** | ✅ v1.0, grace-marketplace | ❌ None | ❌ None | ❌ None |
| **Session management** | ✅ Built-in | ❌ Separate setup | ❌ None | ❌ None |
| **Agent transparency** | ✅ Protocol built-in | ⚠️ Optional | ❌ None | ❌ None |
| **Template system** | ✅ 6 XML templates | ❌ None | ❌ None | ❌ None |
| **Macro workflows** | ✅ 5 GRACE macros | ⚠️ Basic | ❌ None | ❌ None |

### What vibestart Adds

**On top of GRACE marketplace:**
- Automated initialization with conflict detection
- AGENTS.md generation from modular fragments
- Session management (SESSION_LOG.md + TASK_LOG.md)
- Agent transparency protocol
- Migration from v1.0 and grace-marketplace

**On top of ai-standards:**
- Full GRACE methodology implementation
- Knowledge graphs for project navigation
- Verification plans for testing strategy
- Macro-based workflows

---

## 📦 What Gets Created

After running `/vs-init`:

```
your-project/
├── vs.project.toml        # Master configuration
├── AGENTS.md              # Agent instructions (generated)
└── docs/
    ├── development-plan.xml   # Module definitions
    ├── requirements.xml       # Product requirements
    ├── knowledge-graph.xml    # Project navigation
    ├── verification-plan.xml  # Test strategy
    ├── technology.xml         # Stack decisions
    ├── SESSION_LOG.md         # Session tracking
    └── TASK_LOG.md            # Task checklist
```

---

## 🎯 Available Commands

### Management

| Command | Description |
|---------|-------------|
| `/vs-init` | Initialize project, detect conflicts, generate AGENTS.md |

### GRACE Workflow

| Command | When to use |
|---------|-------------|
| `/grace-init` | Bootstrap GRACE structure |
| `/grace-plan` | Design modules and contracts |
| `/grace-execute` | Implement modules |
| `/grace-verification` | Define test strategy |
| `/grace-reviewer` | Review code before commit |
| `/grace-refresh` | Sync code ↔ docs after changes |
| `/grace-status` | Check project health |
| `/grace-fix` | Debug with GRACE navigation |
| `/grace-ask` | Ask questions about project |
| `/grace-explainer` | Learn GRACE methodology |

---

## 🌐 Supported Agents

| Agent | Status | Skills Directory |
|-------|--------|-----------------|
| **Kilo Code** | ✅ Full | `.kilocode/skills/` |
| **Cursor** | ✅ Full | `.cursor/skills/` |
| **Claude Code** | ✅ Basic | `.claude/skills/` |
| **Windsurf** | ⏳ Partial | `.windsurf/skills/` |
| **Aider** | ⏳ Partial | `.aider/skills/` |

---

## 📚 Documentation

| Document | Description |
|----------|-------------|
| [docs/ru.md](docs/ru.md) | Инструкция на русском |
| [docs/why.md](docs/why.md) | Why GRACE + ConPort |
| [docs/grace-macros.md](docs/grace-macros.md) | GRACE macros reference |
| [src/README.md](src/README.md) | Framework internals (Russian) |
| [src/CHANGELOG.md](src/CHANGELOG.md) | Version history |

---

## 🤝 Credits

### Authors
- **Dima** — [github.com/dmkononenko](https://github.com/dmkononenko)
- **Sergei** — [github.com/aka-NameRec](https://github.com/aka-NameRec)

### Based On
- **[GRACE marketplace](https://github.com/osovv/grace-marketplace)** — Contract-driven development methodology by [Vladimir Ivanov](https://t.me/turboplanner)
- **[ConPort](https://github.com/GreatScottyMac/context-portal)** — Long-term memory for AI
- **[ai-standards](https://github.com/aka-NameRec/ai-standards)** — Centralized AI configuration

---

## 📄 License

MIT — use freely for any purpose.

---

## 🔗 Links

- **GitHub:** https://github.com/xronocode/vibestart
- **Releases:** https://github.com/xronocode/vibestart/releases
- **Issues:** https://github.com/xronocode/vibestart/issues
