# vibestart

**From zero to vibe coding in one paste.**

You just installed VS Code. You want to build something with AI.
You've never used a terminal. You don't know what npm or git is.
That's fine.

---

## How it works

**Step 1.** Install Kilo Code in VS Code:
→ https://marketplace.visualstudio.com/items?itemName=kilocode.Kilo-Code

**Step 2.** Open Kilo Code chat (Ctrl+Shift+P → "Kilo Code: Open Chat")

**Step 3.** Open [PROMPT.md](PROMPT.md), copy everything after the first line, and paste it into chat.

<details>
<summary>Click to expand the full prompt content (copy-paste from here as an alternative)</summary>

```markdown
You are setting up my AI coding environment from scratch.
I am new to coding. Please be patient and explain each step clearly.
Do not assume I know terminal commands or developer tools.

Source: github.com/xronocode/vibestart

First, what is your preferred language for my responses? (e.g., English, Russian, etc.) If unsure, say 'English'.

Work through these steps one at a time.
After each step, confirm it worked before moving on.
If something fails, explain what went wrong in simple terms.

---

## CHECK: Is Kilo Code installed?

I should already have the Kilo Code extension installed in VS Code —
that is how I am talking to you right now.

If I am using a different AI assistant (GitHub Copilot, Cursor, Windsurf),
tell me: "For the best experience, install Kilo Code:
https://marketplace.visualstudio.com/items?itemName=kilocode.Kilo-Code
You can continue with your current assistant, but some features may differ."

---

## STEP 1 — Open a terminal in VS Code

Tell me to open the VS Code terminal:
"Press Ctrl+` (backtick) to open the terminal. On Mac use Cmd+`"
"You should see a panel appear at the bottom with a blinking cursor."
"Type: echo hello — and press Enter. You should see 'hello' printed."

If I confirm the terminal works, continue.
If I am confused, give me a screenshot description or more detail.

---

## STEP 2 — Check what is already installed

Run these commands one at a time and tell me what each result means:

git --version
→ If output starts with "git version" — ✅ git is installed
→ If "command not found" — explain: "Git is a tool that saves your code history."
  Give install link for my OS:
  Windows: https://git-scm.com/download/win
  Mac: run `xcode-select --install` in terminal
  Linux: run `sudo apt install git` in terminal

node --version
→ If output starts with "v" — ✅ Node.js is installed
→ If missing — explain: "Node.js lets us run JavaScript tools."
  Install: https://nodejs.org — click "LTS" download

uv --version
→ If output starts with "uv" — ✅ uv is installed
→ If missing — explain: "uv manages Python tools. We need it for memory features."
  Windows (paste in terminal): powershell -c "irm https://astral.sh/uv/install.ps1 | iex"
  Mac/Linux (paste in terminal): curl -LsSf https://astral.sh/uv/install.sh | sh
  After running, close and reopen the terminal, then run `uv --version` again.

For each missing tool: give me the install command, ask me to run it,
wait for me to confirm it works, then continue.

---

## STEP 3 — Install GRACE

GRACE is a methodology that helps AI agents work more reliably on your project.
It is like a set of rules that keeps your AI assistant focused and organized.

Run in terminal:
npx skills add osovv/grace-marketplace

You may see a prompt asking to install a package — type y and press Enter.

If it succeeds: ✅ GRACE installed
If it fails: show me the error and we will fix it together.

---

## STEP 4 — Set up project memory (ConPort)

ConPort gives your AI assistant a memory bank —
it remembers what you are building across sessions.
Without it, you have to re-explain your project every time.

Create a file at this path: .kilocode/mcp_settings.json
(Create the .kilocode folder first if it does not exist)

File content:
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

Also create a logs/ folder.

Verify ConPort works — run in terminal:
uvx --from context-portal-mcp conport-mcp --help

If you see help text: ✅ ConPort ready
If you see an error: show me the error.

---

## STEP 5 — Download agent instructions

These two files tell your AI assistant how to work on your project.

Fetch and save AGENTS.md:
URL: https://raw.githubusercontent.com/xronocode/vibestart/main/templates/AGENTS.md
Save as: ./AGENTS.md

Fetch and save projectBrief.md:
URL: https://raw.githubusercontent.com/xronocode/vibestart/main/templates/projectBrief.template.md
Save as: ./projectBrief.md

---

## STEP 6 — Tell me about your project

Ask me these questions one at a time, in simple language.
Fill in the placeholders in projectBrief.md with my answers.

1. "What is your project called?"
2. "What does it do? Describe it in one sentence as if explaining to a friend."
3. "Who will use it?"
4. "What technology are you planning to use?
   (If you are not sure, just say 'not sure yet' and we will figure it out)"
5. "What is your goal — what should be working in the next 4 weeks?"

After filling in my answers, show me the completed projectBrief.md
and ask: "Does this look right? Type yes to continue or tell me what to change."

---

## STEP 7 — Final setup

Add these lines to .gitignore (create the file if it does not exist):
logs/conport.log
context_portal/

---

## STEP 8 — Reload and start

Tell me:
"Now reload VS Code so the memory features activate.
Press Ctrl+Shift+P (Cmd+Shift+P on Mac), type 'Reload Window', press Enter."

After I confirm reload, tell me:
"You are ready. Your AI development environment is set up.

To start your first real session, type:
Initialize according to custom instructions.

Your AI assistant will load your project context and wait for your first task."

---

## STEP 9 — Print setup summary

---
## ✅ vibestart — Setup Complete

### Installed
| Tool | Status |
|------|--------|
| git | ✅ |
| Node.js | ✅ |
| uv | ✅ |
| Kilo Code | ✅ |
| GRACE skills | ✅ |
| ConPort MCP | ✅ |

### Files Created
| File | What it does |
|------|-------------|
| AGENTS.md | Tells your AI how to work on your project |
| projectBrief.md | Your project context — update this as your project evolves |
| .kilocode/mcp_settings.json | Memory bank configuration |

### Your first command
Open Kilo Code chat and type:
Initialize according to custom instructions.

Welcome to vibe coding. 🚀
---
```

</details>

**Step 4.** Answer your agent's questions about your project

**Step 5.** Type: Initialize according to custom instructions.

That's it. Your AI coding environment is ready.

---

## What your agent sets up for you

| What | Why |
|------|-----|
| git, Node.js, uv | Tools your AI needs to work |
| [GRACE](https://github.com/osovv/grace-marketplace) | Keeps your AI focused and structured |
| [ConPort](https://github.com/GreatScottyMac/context-portal) | Memory — AI remembers your project between sessions |
| AGENTS.md | Your AI's instruction manual |
| projectBrief.md | Your project context (filled in together with you) |

---

## Docs

- [docs/ru.md](docs/ru.md) — инструкция на русском
- [docs/why.md](docs/why.md) — why GRACE + ConPort

---

## Credits

- GRACE: [Vladimir Ivanov @turboplanner](https://t.me/turboplanner) · [osovv/grace-marketplace](https://github.com/osovv/grace-marketplace)
- ConPort: [GreatScottyMac/context-portal](https://github.com/GreatScottyMac/context-portal)
- Inspired by Dima — the friend who guided me and many colleagues by the hand through this process; I adapted this template from each new project I set up, using that experience as inspiration.

## License
MIT
---
