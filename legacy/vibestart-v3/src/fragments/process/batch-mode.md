## Batch Mode
<!-- Fragment: process/batch-mode.md -->

User fills `docs/BATCH_TASKS.md` and writes "run batch". Agent executes autonomously.

**Trigger:** "batch" | "run batch" | "autonomous mode"

**Rules:**
- Read BATCH_TASKS.md top to bottom, strictly in order
- After each task: update SESSION_LOG.md and TASK_LOG.md
- Mark task: [x] DONE or [!] BLOCKED
- If blocked — record reason and proceed to next
- Do NOT ask questions — write "QUESTION: ..." under task in file

**Limits — NEVER without explicit instruction:**
- Do not touch system prompts
- do not deploy to production
- do not modify .env files
- do not delete files

**Task Format:**
```markdown
- [ ] TASK-N | M-XXX | /grace:COMMAND | What exactly to do
```

**Limits — NEVER without explicit instruction:**
- do not touch system prompts
- do not deploy to production
- do not modify .env files
- do not delete files
```
