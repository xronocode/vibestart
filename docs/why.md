# Why GRACE + ConPort?

## The problem vibestart solves

When you use an AI coding agent on a real project, two things break quickly:

**Problem 1 — No memory.**  
Every session you re-explain: "I'm building X, using Y, the current task is Z."  
The agent forgets everything when the chat closes. This gets exhausting fast.

**Problem 2 — No structure.**  
GRACE and ConPort both store project knowledge — but differently.  
Without explicit rules, your agent writes the same decision to both places,  
they drift apart in 2-3 days, and you no longer know what's true.

## The solution

vibestart installs both tools and gives your agent a hard rule:

| System | Stores | Never stores |
|--------|--------|-------------|
| **GRACE** (`docs/*.xml`) | Architecture, contracts, final decisions | Session state |
| **ConPort** (memory bank) | What's being built right now, blockers, temp notes | Finalized decisions |

GRACE is like your project's constitution — permanent, git-versioned.  
ConPort is like your agent's working notepad — fast, searchable, session-aware.

## Why not just one of them?

**GRACE alone:** great for structure, but no persistent memory across sessions.  
**ConPort alone:** great for memory, but no structured methodology for the agent to follow.  
**Together:** your agent knows how to work (GRACE) and remembers what it did (ConPort).

## What AGENTS.md does

The `AGENTS.md` file vibestart creates in your project tells your agent:
- Which tool to use for which type of information (no duplication)
- How to announce what it's doing (you can always see what's happening)
- When to stop and wait for you (gates, blockers, decisions that need your input)
- How to start every session (diagnostic sequence)

This is the file Dima used to configure manually for every new teammate.  
vibestart does it in one prompt.
