# vibestart

**From zero to vibe coding in one paste.**

[![Version](https://img.shields.io/badge/version-2.1.0-blue.svg)](https://github.com/xronocode/vibestart/releases/tag/v2.1.0)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

---

## 🤖 For AI Agents

**You found this repository. Here's what to do:**

### 1. Clone to user's project
```
git clone https://github.com/xronocode/vibestart.git ~/.vibestart/framework
```

Or copy `src/` folder to `~/.vibestart/framework/`.

### 2. Install the skill
```
Copy src/skills/vs-init/ to agent's skills directory:
- Kilo Code: ~/.kilocode/skills/vs-init/
- Cursor: ~/.cursor/skills/vs-init/
- Claude Code: ~/.claude/skills/vs-init/
```

### 3. Run initialization
```
/vs-init
```

This single command will:
- ✅ Check framework integrity (standards, templates, fragments)
- ✅ Detect conflicts with existing tools
- ✅ Create `vs.project.toml` configuration
- ✅ Generate `AGENTS.md` from fragments
- ✅ Create `docs/*.xml` templates
- ✅ Set up session management

### 4. Verify
```
/grace-status
```

---

## 💡 What is vibestart?

**vibestart** is an AI development toolkit that gives your agent:
- **Methodology** — GRACE framework for contract-driven development
- **Structure** — Knowledge graphs, verification plans, semantic markup
- **Continuity** — Session management so AI remembers context
- **Transparency** — Every action is traceable and labeled

**One command (`/vs-init`) replaces hours of manual setup.**

---

## 🆚 Why vibestart?

| | vibestart | Manual setup |
|---|-----------|--------------|
| **Setup time** | 1 command | Hours |
| **Conflict handling** | Auto-detected | Manual debugging |
| **AGENTS.md** | Generated from fragments | Write from scratch |
| **Migration** | From GRACE, ai-standards | Start over |
| **Updates** | Re-run `/vs-init` | Manual sync |

---

## 📦 What gets created

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

| Agent | Status |
|-------|--------|
| **Kilo Code** | ✅ Full support |
| **Cursor** | ✅ Full support |
| **Claude Code** | ✅ Basic support |

---

## 📚 Documentation

- [docs/ru.md](docs/ru.md) — Инструкция на русском
- [docs/why.md](docs/why.md) — Why GRACE + ConPort
- [src/README.md](src/README.md) — Framework internals
- [src/CHANGELOG.md](src/CHANGELOG.md) — Version history

---

## 🤝 Credits

### Authors
- **Dima** — [github.com/dmkononenko](https://github.com/dmkononenko)
- **Sergei** — [github.com/aka-NameRec](https://github.com/aka-NameRec)

### Built On
- [GRACE marketplace](https://github.com/osovv/grace-marketplace) — Contract-driven development
- [ConPort](https://github.com/GreatScottyMac/context-portal) — Long-term memory for AI
- [ai-standards](https://github.com/aka-NameRec/ai-standards) — Centralized AI configuration

---

## 📄 License

MIT

---

## 🔗 Links

- **Repository:** https://github.com/xronocode/vibestart
- **Releases:** https://github.com/xronocode/vibestart/releases
- **Issues:** https://github.com/xronocode/vibestart/issues
