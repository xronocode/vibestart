# vibestart v3.2.0

**Bootstrap a serious AI coding environment in one installer run.**

[![Version](https://img.shields.io/badge/version-3.2.0-blue.svg)](https://github.com/xronocode/vibestart/releases/tag/v3.2.0)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

---

## About

vibestart is a project-local bootstrap for AI-assisted development. It installs a Bash-based setup flow, GRACE artifacts, agent-specific configuration, marketplace shortcuts, and optional memory/documentation integrations directly into the target repository.

## Value Pitch

- One installer for Kilo Code, Claude Code, Codex, Qwen, and GitHub Copilot
- GRACE methodology, XML artifacts, and shortcuts ready before the first agent session
- Early-bound ConPort and Entire integrations, so project memory and docs can exist from minute one
- Portable repo-local output that stays reviewable, regeneratable, and easy to version

## Change Notes: v3.2.0

- Added first-class Codex support with `AGENTS.md`, `.codex/config.toml`, `.codex/skills/`, profile support, and auto-detection.
- Fixed MCP JSON generation for Kilo, Claude, and Qwen so MCP servers are written as valid nested objects.
- Added safer Bash startup on macOS, idempotent UI sourcing, and runtime profile reloads during detection.
- Corrected environment-aware marketplace install paths and shortcut generation behavior.
- Added smoke tests for JSON helpers, config generators, and `vs-init --dry-run`.
- No breaking installer flags were introduced in this release.

---

## 🤖 For AI Agents

You found this repository. The user wants to set up vibestart in their project.

### What is vibestart?

vibestart is a **framework** for AI-assisted development that includes:
- **GRACE methodology** — contract-driven development with knowledge graphs
- **Skills** — AI agent instructions (vs-init, external GRACE skills)
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
| **MIGRATE** | v1.x/v2.x project | Migrate to v3.2.0 |
| **REFRESH** | Regenerate artifacts | Refresh AGENTS.md |

### What You Need To Do

**Follow these steps in order:**

---

## Step 1: Download vibestart into the project

Download vibestart using git archive (clean, no .git directory):

```bash
# In the user's project directory
mkdir -p .vibestart
git archive --remote=https://github.com/xronocode/vibestart.git HEAD | tar -xf - -C .vibestart
```

**Alternative methods:**

```bash
# Method 2: Download and extract ZIP (if git archive unavailable)
curl -L https://github.com/xronocode/vibestart/archive/refs/heads/main.zip -o /tmp/vibestart.zip
unzip /tmp/vibestart.zip -d /tmp/
mv /tmp/vibestart-main .vibestart
rm /tmp/vibestart.zip

# Method 3: Clone then remove .git (if you need git history)
git clone https://github.com/xronocode/vibestart.git .vibestart
rm -rf .vibestart/.git
```

**What this does:**
- Creates `.vibestart/` folder in the user's project
- Downloads the complete vibestart framework **without .git directory** (cleaner, smaller)
- The framework includes: installer (vs-init), standards, templates, fragments

**Result:** You now have `.vibestart/vs-init` executable in the project.

---

## Step 2: Run the installer

The installer will set up everything automatically:

```bash
cd .vibestart
./vs-init
```

**The installer will:**
- Check system requirements (disk space, dependencies)
- Ask about integrations (ConPort, Entire.io) **BEFORE** session starts
- Download GRACE marketplace skills
- Generate configuration files for your AI agent
- Create GRACE shortcuts (`$init`, `$plan`, `$exec`, etc.)

**Interactive mode** (default):
- Asks questions about environment and integrations
- Shows configuration summary before applying
- Confirms before making changes

**Auto mode** (for CI/CD or experienced users):
```bash
./vs-init --auto
./vs-init --auto --env=claude
./vs-init --auto --env=codex
./vs-init --auto --conport=lite --no-entire
```

**Dry-run** (preview without changes):
```bash
./vs-init --dry-run --auto
```

---

## Step 3: Restart your AI agent

After installation completes, restart your AI coding environment to activate:

- ConPort (if enabled) — project memory
- Entire.io (if enabled) — library documentation
- GRACE shortcuts — quick commands

---

## Quick Reference

| What | Where |
|------|-------|
| **Framework** | `.vibestart/` |
| **Installer** | `.vibestart/vs-init` |
| **Bash modules** | `.vibestart/lib/` |
| **Environment profiles** | `.vibestart/profiles/` |
| **GRACE Marketplace** | Install from https://github.com/osovv/grace-marketplace |
| **Templates** | `.vibestart/src/templates/` |
| **Fragments** | `.vibestart/src/fragments/` |
| **vs-init skill** | `.vibestart/src/skills/vs-init/SKILL.md` |

---

## Installing GRACE Skills

vibestart v3.2.0+ uses bash-based installer with **early binding** for integrations.

### Architecture Highlights

**Early Binding (Critical!)**
- ConPort and Entire.io are asked at **Step 1** (not Step 7)
- This ensures integrations are ready **BEFORE** the AI agent session starts
- Agent can log decisions from the first minute

**ConPort Modes**
- **Full** (1.5GB): MCP server with semantic search and embeddings
- **Lite** (10MB): CLI wrapper with SQLite full-text search
- **Skip**: No project memory

**Multi-Environment Support**
- Kilo Code (`.kilo/`)
- Claude Code (`.claude/`)
- Codex (`AGENTS.md`, `.codex/`)
- Qwen (`.qwen/`)
- GitHub Copilot (`.github/copilot/`)

### Installation

The installer will automatically download GRACE marketplace from:
https://github.com/osovv/grace-marketplace

```bash
# GRACE marketplace is downloaded to:
~/.kilocode/skills/grace/          # For Kilo Code
~/.claude/skills/grace/            # For Claude Code
~/.codex/skills/grace/             # For Codex
~/.qwen/skills/grace/              # For Qwen
~/.github/copilot/skills/grace/    # For Copilot
```

For manual installation or updates:
```bash
# Update GRACE marketplace
./vs-init --update-marketplace
```

---

## What Gets Created

After running `./vs-init`:

```
user-project/
├── .vibestart/              # Framework (downloaded via git archive)
│   ├── vs-init             # Main installer
│   ├── lib/                # Bash modules (ui, detect, preflight, etc.)
│   ├── profiles/           # Environment profiles
│   └── src/                # Standards, templates, fragments
├── .kilo/                  # Kilo Code config (if Kilo selected)
│   ├── context.md          # Project context
│   ├── mcp_settings.json   # MCP server config
│   └── skills/             # GRACE shortcuts
├── AGENTS.md               # Codex project instructions (if Codex selected)
├── .codex/                 # Codex config (if Codex selected)
│   ├── config.toml         # MCP snippet for ~/.codex/config.toml
│   └── skills/             # GRACE shortcut references
├── .conport/               # ConPort (if enabled)
│   ├── conport-cli.py      # Lite CLI wrapper
│   └── memory.db           # SQLite database
├── .claude/                # Claude Code config (if Claude selected)
├── .qwen/                  # Qwen config (if Qwen selected)
├── .github/copilot/        # Copilot config (if Copilot selected)
└── docs/                   # GRACE artifacts
    ├── development-plan.xml
    ├── requirements.xml
    ├── knowledge-graph.xml
    ├── verification-plan.xml
    ├── technology.xml
    └── decisions.xml

# If ADVANCED mode with integrations:
├── .conport/               # ConPort Memory Bank (if enabled)
└── .git/hooks/              # Entire.io hooks (if enabled)
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

- Kilo Code
- Claude Code
- Codex
- Qwen
- GitHub Copilot

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
- **Changelog:** [CHANGELOG.md](CHANGELOG.md)
- **Releases:** https://github.com/xronocode/vibestart/releases
- **Issues:** https://github.com/xronocode/vibestart/issues
