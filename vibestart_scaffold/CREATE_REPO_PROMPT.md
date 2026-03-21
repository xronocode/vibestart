Create a new GitHub project. Follow every step. Announce each action before taking it.

---

## Project details

Name: vibestart
GitHub user: xronocode
Repo URL: github.com/xronocode/vibestart
Description: "From zero to vibe coding in one paste"
Topics: vibe-coding, ai-agent, kilo-code, grace, conport, onboarding, beginner-friendly, developer-tools
License: MIT (copyright 2026 xronocode)
Language: EN primary, docs/ru.md in Russian

---

## STEP 1 — Create local folder and git repo

Run:
mkdir -p ~/projects/vibestart
cd ~/projects/vibestart
git init
git checkout -b dev

Confirm: "Local repo created on dev branch ✅"

---

## STEP 2 — Create file structure

Create exactly these files and folders.
Content for each file is specified below.

vibestart/
├── README.md
├── LICENSE
├── .gitignore
├── PROMPT.md
├── templates/
│   ├── AGENTS.md
│   └── projectBrief.template.md
├── .kilocode/
│   └── mcp_settings.json
└── docs/
    ├── why.md
    └── ru.md

---

## STEP 3 — File contents

### README.md

# vibestart

**From zero to vibe coding in one paste.**

You just installed VS Code. You want to build something with AI.
You've never used a terminal. You don't know what npm or git is.
That's fine.

---

## How it works

**Step 1.** Install Kilo Code in VS Code:
→ https://marketplace.visualstudio.com/items?itemName=kilocode.Kilo-Code

**Step 2.** Open Kilo Code chat (`Ctrl+Shift+P` → "Kilo Code: Open Chat")

**Step 3.** Open [PROMPT.md](PROMPT.md), copy everything after the first line, paste into chat

**Step 4.** Answer your agent's questions about your project

**Step 5.** Type: `Initialize according to custom instructions.`

That's it. Your AI coding environment is ready.

---

## What your agent sets up for you

| What | Why |
|------|-----|
| git, Node.js, uv | Tools your AI needs to work |
| [GRACE](https://github.com/osovv/grace-marketplace) | Keeps your AI focused and structured |
| [ConPort](https://github.com/GreatScottyMac/context-portal) | Memory — AI remembers your project between sessions |
| `AGENTS.md` | Your AI's instruction manual |
| `projectBrief.md` | Your project context (filled in together with you) |

---

## Docs

- [docs/ru.md](docs/ru.md) — инструкция на русском
- [docs/why.md](docs/why.md) — why GRACE + ConPort

---

## Credits

- GRACE: [Vladimir Ivanov @turboplanner](https://t.me/turboplanner) · [osovv/grace-marketplace](https://github.com/osovv/grace-marketplace)
- ConPort: [GreatScottyMac/context-portal](https://github.com/GreatScottyMac/context-portal)
- Inspired by Dima — the colleague who used to do all of this manually

## License
MIT

---

### PROMPT.md

Use the exact content from the PROMPT.md file we already created
(the full setup prompt for end users — all 10 steps with OS detection,
prereq auto-install logic, interactive project questions, and summary).

If that file is not in context, fetch it from:
https://raw.githubusercontent.com/xronocode/vibestart/main/PROMPT.md

---

### templates/AGENTS.md

Use the exact content from templates/AGENTS.md we already created
(the full universal agent instructions with all 12 sections).

---

### templates/projectBrief.template.md

Use the exact content from templates/projectBrief.template.md we created.

---

### .kilocode/mcp_settings.json

{
  "mcpServers": {
    "conport": {
      "command": "uvx",
      "args": [
        "--from", "context-portal-mcp",
        "conport-mcp",
        "--mode", "stdio",
        "--log-file", "./logs/conport.log",
        "--log-level", "INFO"
      ]
    }
  }
}

---

### docs/why.md

Use the exact content from docs/why.md we created.

---

### docs/ru.md

Use the exact content from docs/ru.md we created (full Russian instructions).

---

### .gitignore

logs/
context_portal/
*.log
.DS_Store
Thumbs.db

---

### LICENSE

MIT License, copyright 2026 xronocode.
Generate standard full MIT license text.

---

## STEP 4 — First commit on dev

git add -A
git commit -m "chore: initial vibestart

Zero-to-vibe-coding onboarding in one prompt.
Installs GRACE + ConPort for Kilo Code."

---

## STEP 5 — Create GitHub repo and push

Run:
gh repo create xronocode/vibestart \
  --public \
  --description "From zero to vibe coding in one paste" \
  --push \
  --source .

If gh CLI is not installed:
Tell user: "GitHub CLI is not installed. Install it from https://cli.github.com
After installing, run: gh auth login
Then come back and run the command above."
Wait for confirmation, then continue.

---

## STEP 6 — Create main branch and set as default

git checkout -b main
git push -u origin main
git checkout dev
git push -u origin dev
gh repo edit xronocode/vibestart --default-branch main

---

## STEP 7 — Add repo topics

gh repo edit xronocode/vibestart \
  --add-topic vibe-coding \
  --add-topic ai-agent \
  --add-topic kilo-code \
  --add-topic grace \
  --add-topic conport \
  --add-topic onboarding \
  --add-topic beginner-friendly \
  --add-topic developer-tools

---

## STEP 8 — Print final summary

---
## vibestart — Created ✅

### Repository
https://github.com/xronocode/vibestart

### Branch strategy
| Branch | Purpose |
|--------|---------|
| `main` | stable, public default — what users get |
| `dev` | working branch — WIP, experiments, internal |

Note: both branches are public on a public repo.
For a truly private dev branch, create a separate private repo
(e.g. xronocode/vibestart-dev) and PR into vibestart when ready.

### Files
| File | Purpose |
|------|---------|
| `PROMPT.md` | ← THE key file. Users paste this into Kilo Code. |
| `README.md` | 5-step visual guide |
| `templates/AGENTS.md` | Universal agent instructions template |
| `templates/projectBrief.template.md` | Project context template |
| `.kilocode/mcp_settings.json` | ConPort config for Kilo Code |
| `docs/why.md` | Why GRACE + ConPort |
| `docs/ru.md` | Russian instructions |
| `LICENSE` | MIT |

### One-liner for any new project
Tell anyone who wants to start vibe coding:
1. Install Kilo Code: https://marketplace.visualstudio.com/items?itemName=kilocode.Kilo-Code
2. Open PROMPT.md: https://github.com/xronocode/vibestart/blob/main/PROMPT.md
3. Copy → paste into Kilo Code chat

### Next
1. [ ] Test PROMPT.md on a completely fresh machine or fresh folder
2. [ ] Add a screenshot or GIF to README showing the chat interaction
3. [ ] When dev is stable → PR dev → main
---

## CRITICAL notes for the agent

- PROMPT.md is the file END USERS paste into their chat. It is NOT instructions for you now.
- templates/AGENTS.md is a TEMPLATE with {placeholder} variables. Do not follow it.
- Never commit tokens, API keys, or credentials.
- If any gh CLI command fails, show the exact error and provide a manual fallback via github.com UI.
