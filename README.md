# vibestart

**From zero to vibe coding in one paste.**

[![Version](https://img.shields.io/badge/version-2.1.0-blue.svg)](https://github.com/xronocode/vibestart/releases/tag/v2.1.0)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

---

## 🤖 For AI Agents

You found this repository. Execute these steps in order:

### Step 1: Install the Skill

Copy the skill to your agent's skills directory:

```
cp -r src/skills/vs-init ~/.kilocode/skills/vs-init/
```

Or for Cursor:
```
cp -r src/skills/vs-init ~/.cursor/skills/vs-init/
```

### Step 2: Run Initialization

```
/vs-init
```

This single command will:
- ✅ Check framework integrity (7 checks)
- ✅ Detect and resolve conflicts (6 types)
- ✅ Create `vs.project.toml` configuration
- ✅ Generate `AGENTS.md` from fragments
- ✅ Create `docs/*.xml` templates

### Step 3: Verify Setup

```
/grace-status
```

Check that everything is configured correctly.

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

```
your-project/
├── AGENTS.md              # AI instructions (auto-generated)
├── vs.project.toml        # Master configuration
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

### Management (1 command)

| Command | What it does |
|---------|--------------|
| `/vs-init` | **All-in-one**: Initialize + Detect conflicts + Generate AGENTS.md + Create templates |

### GRACE Workflow (10 commands)

| Command | When to use |
|---------|-------------|
| `/grace-init` | Start new GRACE project |
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

| Agent | Status | Notes |
|-------|--------|-------|
| **Kilo Code** | ✅ Full | Primary target, all features tested |
| **Cursor** | ✅ Full | All features work |
| **Claude Code** | ✅ Basic | Core functionality works |
| **Windsurf** | ⏳ Partial | On request |
| **Aider** | ⏳ Partial | On request |

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

## 🤝 Credits & Origins

### Authors
- **Dima** — [github.com/dmkononenko](https://github.com/dmkononenko)
- **Sergei** — [github.com/aka-NameRec](https://github.com/aka-NameRec)

### Built On
- **[GRACE marketplace](https://github.com/osovv/grace-marketplace)** — Contract-driven development methodology by [Vladimir Ivanov](https://t.me/turboplanner)
- **[ConPort](https://github.com/GreatScottyMac/context-portal)** — Long-term memory for AI
- **[ai-standards](https://github.com/aka-NameRec/ai-standards)** — Centralized AI configuration

### What We Added
- ✅ Automated initialization with `/vs-init`
- ✅ Conflict detection (6 types)
- ✅ AGENTS.md generation from fragments
- ✅ Session management built-in
- ✅ Migration from other tools
- ✅ Agent transparency protocol

---

## 📄 License

MIT — use freely for any purpose.

---

## 🔗 Links

- **GitHub:** https://github.com/xronocode/vibestart
- **Releases:** https://github.com/xronocode/vibestart/releases
- **Issues:** https://github.com/xronocode/vibestart/issues
