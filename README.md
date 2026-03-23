# vibestart

**From zero to vibe coding in one paste.**

[![Version](https://img.shields.io/badge/version-2.1.0-blue.svg)](https://github.com/xronocode/vibestart/releases/tag/v2.1.0)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

---

## 🤖 For AI Agents

**You found this repository. Here's what to do:**

### Step 1: Clone Framework

Clone this repository to the framework location:

```bash
git clone https://github.com/xronocode/vibestart.git ~/.vibestart/framework
```

Or copy the `src/` folder manually to `~/.vibestart/framework/`.

### Step 2: Install vs-init Skill

Copy the skill to your agent's skills directory:

**Kilo Code:**
```bash
cp -r ~/.vibestart/framework/src/skills/vs-init ~/.kilocode/skills/vs-init
```

**Cursor:**
```bash
cp -r ~/.vibestart/framework/src/skills/vs-init ~/.cursor/skills/vs-init
```

**Claude Code:**
```bash
cp -r ~/.vibestart/framework/src/skills/vs-init ~/.claude/skills/vs-init
```

### Step 3: Run Initialization

In your project directory, run:

```
/vs-init
```

**What `/vs-init` does:**
- Checks framework integrity (standards, templates, fragments)
- Detects and resolves conflicts with existing tools
- Creates `vs.project.toml` (project configuration)
- Generates `AGENTS.md` (agent instructions)
- Creates `docs/*.xml` templates (GRACE artifacts)

### Step 4: Verify

```
/grace-status
```

Check that everything is configured correctly.

---

## 💡 What is vibestart?

**vibestart** is an AI development framework that gives your agent:

| What | Description |
|------|-------------|
| **Methodology** | GRACE — contract-driven development with knowledge graphs |
| **Structure** | Knowledge graphs, verification plans. semantic markup |
| **Continuity** | Session management — AI remembers context between sessions |
| **Transparency** | Every action is traceable and labeled |
| **Automation** | One command (`/vs-init`) replaces hours of manual setup |

---

## 🆚 Why vibestart?

| | vibestart | Manual setup |
|---|-----------|--------------|
| **Setup time** | 1 command | Hours |
| **Conflict handling** | Auto-detected (6 types) | Manual debugging |
| **AGENTS.md** | Generated from fragments | Write from scratch |
| **Migration** | From GRACE. ai-standards | Start over |
| **Updates** | Re-run `/vs-init` | Manual sync |

---

## 📦 What Gets Created

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
| `/vs-init` | Initialize project. detect conflicts. generate AGENTS.md |

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

| Agent | Status | Notes |
|-------|--------|-------|
| **Kilo Code** | ✅ Full | Primary target. all features tested |
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
