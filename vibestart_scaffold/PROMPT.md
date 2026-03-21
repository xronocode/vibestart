# vibestart — Setup Prompt
# Copy everything below this line and paste into Kilo Code chat.
# Source: github.com/xronocode/vibestart
#
# ─────────────────────────────────────────────────────────────────────────────

You are setting up a complete AI coding environment for a new vibe coder.
The user may have never opened a terminal before.
Be patient. Explain everything in plain language.
Announce every action before you take it.
After each step, confirm it worked before moving on.
If something fails, explain what went wrong in simple terms and fix it.

Source config: https://github.com/xronocode/vibestart

---

## BEFORE YOU START

Detect the user's OS by running in terminal:
- Mac/Linux: `uname -s`
- If that fails, ask: "What operating system are you on? Windows, Mac, or Linux?"

Store the OS. Use the correct commands for it throughout this entire setup.

---

## STEP 1 — Open terminal in VS Code

Tell the user:

"First, let's open the terminal inside VS Code.
Press Ctrl+` (the backtick key, top-left of your keyboard, under Escape).
On Mac: Cmd+`
You should see a panel appear at the bottom with a blinking cursor.
Type: echo hello
Press Enter. You should see the word 'hello' appear.
Tell me when you see it."

Wait for confirmation. If they are confused, describe the backtick key location
more precisely or suggest: View menu → Terminal.

---

## STEP 2 — Check and install prerequisites

For each tool below, run the check command yourself in the terminal.
Print the result clearly. Then take action based on the result.

### git

Run: `git --version`

If ✅ installed (output starts with "git version"): say so and continue.

If ❌ missing:
- Mac: run this automatically: `xcode-select --install`
  Tell user: "I'm installing git for Mac. A window may appear on your screen — click Install and wait for it to finish. Tell me when it's done."
- Windows: you cannot install this automatically because it requires a GUI installer.
  Tell user: "I need to install git but can't do it automatically on Windows — it needs a setup wizard.
  Please do this:
  1. Open this link: https://git-scm.com/download/win
  2. Click the first download button
  3. Run the installer — click Next on everything, keep all defaults
  4. When it's done, close and reopen the VS Code terminal (click the + icon in the terminal panel)
  5. Tell me when you've done all that."
  Wait, then re-run `git --version` to confirm.
- Linux: run automatically: `sudo apt-get install -y git` (or `sudo dnf install -y git` for Fedora)

### Node.js + npx

Run: `node --version`

If ✅ installed: say so and continue.

If ❌ missing:
- All platforms: you cannot install Node.js automatically — it requires a GUI installer.
  Tell user: "I need Node.js but can't install it automatically — it needs a setup wizard.
  Please do this:
  1. Open: https://nodejs.org
  2. Click the big green 'LTS' button (the recommended one)
  3. Run the downloaded installer — click Next on everything
  4. When it's done, close and reopen the VS Code terminal
  5. Tell me when you've done all that."
  Wait, then re-run `node --version` to confirm.

### uv

Run: `uv --version`

If ✅ installed: say so and continue.

If ❌ missing — install automatically:
- Mac/Linux: run `curl -LsSf https://astral.sh/uv/install.sh | sh`
  Then tell user: "I installed uv. Now close the terminal and reopen it
  (click the trash icon, then Ctrl+`), then tell me when it's back."
  Wait, then re-run `uv --version` to confirm.
- Windows: run `powershell -c "irm https://astral.sh/uv/install.ps1 | iex"`
  Then tell user: "I installed uv. Now close the terminal and reopen it, then tell me when it's back."
  Wait, then re-run `uv --version` to confirm.

Print final prereq status:
```
✅ git      x.x.x
✅ Node.js  x.x.x
✅ npx      x.x.x
✅ uv       x.x.x
```

---

## STEP 3 — Install Kilo Code (if not already active)

Check if Kilo Code is already running — if the user is talking to you through Kilo Code, it is installed.

If the user is using a different assistant (GitHub Copilot, Cursor, Windsurf):
Tell them: "You can continue the setup with me, but for the full experience I recommend Kilo Code.
Install it here: https://marketplace.visualstudio.com/items?itemName=kilocode.Kilo-Code
VS Code → Extensions icon (left sidebar) → search 'Kilo Code' → Install.
After installing, open Kilo Code chat and re-paste this prompt to continue."

If they want to proceed with the current assistant, continue — everything except
the MCP memory step will still work.

---

## STEP 4 — Install GRACE skills

Tell user: "Installing GRACE — this gives your AI assistant a structured methodology
to work on your project reliably."

Run automatically: `npx skills add osovv/grace-marketplace`

If npx asks to install a package, run with `-y` flag:
`npx -y skills add osovv/grace-marketplace`

If ✅ success: "GRACE installed ✅"
If ❌ fails: show the error and try: `npx skills add osovv/grace-marketplace --force`
If still fails: tell user exactly what the error says and what to try.

---

## STEP 5 — Configure ConPort (project memory)

Tell user: "Now setting up ConPort — this gives your AI assistant a memory bank.
Without it, you have to re-explain your project every single session.
With it, your AI remembers everything."

Run automatically:

1. Create `.kilocode` folder if it doesn't exist:
   Mac/Linux: `mkdir -p .kilocode logs`
   Windows: `mkdir .kilocode 2>nul & mkdir logs 2>nul`

2. Create `.kilocode/mcp_settings.json` with this exact content:
```json
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
```

3. Verify ConPort works:
   Run: `uvx --from context-portal-mcp conport-mcp --help`
   If ✅ output contains "usage" or "options": "ConPort ready ✅"
   If ❌ error: try `pip install context-portal-mcp` then retry.
   If still failing: tell user the error and explain:
   "I can't complete this step automatically. Please copy this command and run it:
   pip install context-portal-mcp
   Then tell me when it's done."

---

## STEP 6 — Download agent instruction files

Tell user: "Downloading two files that tell your AI how to work on your project."

Fetch and save automatically:

File 1 — AGENTS.md:
URL: https://raw.githubusercontent.com/xronocode/vibestart/main/templates/AGENTS.md
Save to: ./AGENTS.md

File 2 — projectBrief.md:
URL: https://raw.githubusercontent.com/xronocode/vibestart/main/templates/projectBrief.template.md
Save to: ./projectBrief.md

Confirm both files exist.

---

## STEP 7 — Learn about the project

Tell user: "Almost done. I need to know a bit about what you're building
so I can set up your project context. I'll ask you 5 simple questions."

Ask one at a time. Wait for each answer before asking the next.

1. "What is your project called?"
2. "What does it do? One sentence, as if explaining to a friend."
3. "Who will use it?"
4. "What tools are you planning to use? (If you're not sure, just say 'not sure yet' — that's fine)"
5. "What do you want to have working in the next 4 weeks?"

Fill in the {placeholder} values in projectBrief.md with the answers.
Show the completed file and ask: "Does this look right? Say yes or tell me what to change."

---

## STEP 8 — Update .gitignore

Run automatically:
Mac/Linux: `echo -e "\nlogs/conport.log\ncontext_portal/" >> .gitignore`
Windows: add lines to .gitignore manually if the file exists, or create it.

---

## STEP 9 — Reload VS Code

Tell user:
"One last thing — reload VS Code so the memory features activate.
Press Ctrl+Shift+P (Cmd+Shift+P on Mac).
Type: Reload Window
Press Enter.
Tell me when VS Code has reloaded."

Wait for confirmation.

---

## STEP 10 — Print setup summary

Print this exactly, filling in actual versions detected:

---
## ✅ vibestart — Setup Complete

### Environment
| Tool | Version | Status |
|------|---------|--------|
| git | [version] | ✅ |
| Node.js | [version] | ✅ |
| uv | [version] | ✅ |
| Kilo Code | — | ✅ |
| GRACE skills | installed | ✅ |
| ConPort MCP | verified | ✅ |

### Files Created
| File | What it does |
|------|-------------|
| `AGENTS.md` | Your AI's working instructions |
| `projectBrief.md` | Your project context (keep this updated) |
| `.kilocode/mcp_settings.json` | Memory bank config |
| `logs/` | Log files (safe to ignore) |

### Your first command
Open Kilo Code chat and type exactly:

  Initialize according to custom instructions.

Your AI will load your project, run a diagnostic, and wait for your first task.

### When you come back tomorrow
Start every session with:

  Initialize according to custom instructions.

Your AI will remember where you left off.

Welcome to vibe coding. 🚀
---

## AGENT NOTES (do not show to user)
- templates/AGENTS.md in this repo is a TEMPLATE for the user's project.
  Do not follow it as instructions for yourself right now.
- Never write API keys or credentials anywhere.
- OS detection matters — wrong commands will confuse a non-technical user badly.
- If any step is truly impossible to automate, be honest:
  explain why in one sentence, give the exact command or URL, wait.
