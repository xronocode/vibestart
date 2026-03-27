# vibestart v3.0.0

**From zero to vibe coding in one paste.**

[![Version](https://img.shields.io/badge/version-3.0.0-blue.svg)](https://github.com/xronocode/vibestart/releases/tag/v3.0.0)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Tests](https://img.shields.io/badge/tests-72%2F76%20passing-brightgreen)](https://github.com/xronocode/vibestart/tree/main/tests)

---

## 🤖 For AI Agents

You found this repository. The user wants to set up vibestart in their project.

### What is vibestart?

vibestart is a **framework** for AI-assisted development that includes:
- **GRACE methodology** — contract-driven development with knowledge graphs
- **Skills** — AI agent instructions (vs-init, grace-*)
- **Standards** — development rules (architecture, error-handling, git-workflow)
- **Templates** — XML templates for project artifacts
- **Fragments** — modular components for AGENTS.md generation
- **Integrations** — Entire.io (session audit), ConPort (long-term memory)

**Note:** vibestart uses GRACE methodology for its own development (dogfooding). This validates the templates work correctly and provides a real-world example for users.

### Installation Modes

| Mode | Description | Time | Includes |
|------|-------------|------|----------|
| **LITE** | Quick start | 1-2 min | GRACE + XML artifacts + vs-init |
| **ADVANCED** | Full platform | 10-15 min | LITE + Entire.io + ConPort |

### vs-init Modes

| Mode | When | What |
|------|------|------|
| **INSTALL** | New project | Full setup from scratch |
| **UPDATE** | Existing vibestart | Update to latest version |
| **REPAIR** | Broken installation | Fix problems |
| **MIGRATE** | v1.x/v2.x project | Migrate to v3.0.0 |
| **REFRESH** | Regenerate artifacts | Refresh AGENTS.md |

### What You Need To Do

**Follow these steps in order:**

---

## Step 1: Clone vibestart into the project

Clone this repository into a subfolder of the user's project:

```bash
# In the user's project directory, create .vibestart folder and clone there
git clone https://github.com/xronocode/vibestart.git .vibestart
```

**What this does:**
- Creates `.vibestart/` folder in the user's project
- Downloads the complete vibestart framework
- The framework includes: skills, standards, templates, fragments

**Result:** You now have `.vibestart/src/skills/vs-init/` in the project.

---

## Step 2: Read the vs-init skill

The vs-init skill contains all initialization instructions. Read it now:

```
.vibestart/src/skills/vs-init/SKILL.md
```

**This skill will tell you:**
- How to check framework integrity
- How to detect and resolve conflicts
- How to create project configuration
- How to generate AGENTS.md
- How to create GRACE artifacts

---

## Step 3: Follow vs-init instructions

Open and read `.vibestart/src/skills/vs-init/SKILL.md`, then follow its instructions.

The skill will guide you through:

**INSTALL mode:**
1. Framework integrity check (7 checks)
2. Conflict detection (6 types)
3. Conflict resolution
4. LITE or ADVANCED mode selection
5. AGENTS.md generation
6. GRACE artifacts creation

**UPDATE/REPAIR/MIGRATE/REFRESH modes:**
- Automatic detection of existing installation
- Backup creation before changes
- Migration from v1.x/v2.x to v3.0.0
- Integration setup (Entire.io, ConPort)

---

## Quick Reference

| What | Where |
|------|-------|
| **Framework** | `.vibestart/` |
| **Skills** | `.vibestart/src/skills/` |
| **Standards** | `.vibestart/src/standards/` |
| **Templates** | `.vibestart/src/templates/` |
| **Fragments** | `.vibestart/src/fragments/` |
| **vs-init skill** | `.vibestart/src/skills/vs-init/SKILL.md` |

---

## What Gets Created

After following vs-init instructions:

```
user-project/
├── .vibestart/              # Framework (you just cloned this)
│   └── src/
│       ├── skills/
│       ├── standards/
│       ├── templates/
│       └── fragments/
├── vs.project.toml          # Project configuration (you will create)
├── AGENTS.md                # Agent instructions (you will generate)
└── docs/                    # GRACE artifacts (you will create)
    ├── development-plan.xml
    ├── requirements.xml
    ├── knowledge-graph.xml
    ├── verification-plan.xml
    ├── technology.xml
    └── decisions.xml

# If ADVANCED mode with integrations:
├── .conport/                # ConPort Memory Bank (if enabled)
└── .git/hooks/              # Entire.io hooks (if enabled)
```

## Integrations (ADVANCED mode)

### Entire.io — Session Audit

**What it does:**
- Captures AI agent sessions automatically
- Links sessions to Git commits
- Searchable history of how code was written
- Checkpoints with full context

**Requirements:**
- entire CLI (`npm install -g @entire/cli`)
- Git repository

**Storage:** Git branch (`entire/checkpoints/v1`)

**Cost:** Free (MIT license)

### ConPort — Long-term Memory

**What it does:**
- Persistent memory between sessions
- Semantic search
- Context carry-over
- Decision migration to GRACE

**Requirements:**
- ConPort MCP server
- Agent with MCP support (Claude Code, Kilo Code, Cursor)

**Storage:** Local file (`.conport/memory.db`)

**Cost:** Free (open source)

---

## 💡 Why vibestart?

### The Problem

The user is new to AI-assisted development. They have:
- ❌ No idea how to structure AI instructions
- ❌ No methodology for AI to follow
- ❌ No way to track decisions across sessions
- ❌ No standards for code quality

### The Solution

vibestart provides:
- ✅ **One-command setup** — vs-init does everything
- ✅ **GRACE methodology** — contract-driven development with knowledge graphs
- ✅ **Session continuity** — AI remembers what it did yesterday
- ✅ **Agent transparency** — every action is traceable
- ✅ **Conflict detection** — handles existing tools gracefully

---

## 🆚 vibestart vs Alternatives

| Feature | vibestart | GRACE marketplace | ai-standards | Manual setup |
|---------|-----------|-------------------|--------------|--------------|
| **One-command init** | ✅ vs-init | ❌ Multiple steps | ❌ Manual copy | ❌ Hours of work |
| **Conflict detection** | ✅ 6 types | ❌ None | ❌ None | ❌ None |
| **AGENTS.md generation** | ✅ Auto from fragments | ❌ Manual | ❌ Manual | ❌ Manual |
| **Migration support** | ✅ v1.0, grace-marketplace | ❌ None | ❌ None | ❌ None |
| **Session management** | ✅ Built-in | ❌ Separate setup | ❌ None | ❌ None |
| **Agent transparency** | ✅ Protocol built-in | ⚠️ Optional | ❌ None | ❌ None |
| **Template system** | ✅ 6 XML templates | ❌ None | ❌ None | ❌ None |
| **Macro workflows** | ✅ 5 GRACE macros | ⚠️ Basic | ❌ None | ❌ None |

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
| [docs/grace-explainer.md](docs/grace-explainer.md) | GRACE methodology reference |
| [docs/INTEGRATIONS.md](docs/INTEGRATIONS.md) | Entire.io & ConPort setup |
| [RUNNING_TESTS.md](RUNNING_TESTS.md) | How to run tests |
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
