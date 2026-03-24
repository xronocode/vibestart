# vibestart

**From zero to vibe coding in one paste.**

[![Version](https://img.shields.io/badge/version-2.1.0-blue.svg)](https://github.com/xronocode/vibestart/releases/tag/v2.1.0)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

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

**Note:** vibestart uses GRACE methodology for its own development (dogfooding). This validates the templates work correctly and provides a real-world example for users.

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
1. Framework integrity check (7 checks)
2. Conflict detection (6 types)
3. Conflict resolution
4. AGENTS.md generation
5. GRACE artifacts creation

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
    ├── SESSION_LOG.md
    └── TASK_LOG.md
```

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
