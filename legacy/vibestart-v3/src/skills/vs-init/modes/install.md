# INSTALL Mode

Режим новой установки vibestart.

## Режимы установки

| Режим | Описание | Время | Для кого |
|-------|----------|-------|----------|
| **LITE** | GRACE + XML артефакты + vs-init | 1-2 мин | Быстрый старт, малые проекты |
| **ADVANCED** | LITE + Entire.io + ConPort | 10-15 мин | Сложные проекты, команда, аудит |

---

## Flow

### Шаг 1: Git Checkpoint Safety

```
[SKILL:vs-init] Step 1: Creating safety checkpoint...

Git status:
  • Repository: [yes/no]
  • Clean working directory: [yes/no]
  • Current branch: [branch-name]
```

#### Scenario A: Git repository exists, clean

```
Creating safety tag: vs-init-backup-YYYYMMDD-HHMMSS
  → git tag -a vs-init-backup-YYYYMMDD-HHMMSS -m "vs-init checkpoint"

If something goes wrong, rollback with:
  git checkout vs-init-backup-YYYYMMDD-HHMMSS
```

#### Scenario B: Git repository exists, dirty

```
╔═══════════════════════════════════════════════════════════════╗
║                    UNCOMMITTED CHANGES DETECTED               ║
╠═══════════════════════════════════════════════════════════════╣
║                                                                ║
║  Your project has uncommitted changes.                         ║
║                                                                ║
║  Options:                                                      ║
║    [C] Commit changes now (RECOMMENDED)                       ║
║        → git add . && git commit -m "chore: pre-vs-init save" ║
║                                                                ║
║    [S] Stash changes temporarily                              ║
║        → git stash push -m "pre-vs-init-backup"               ║
║                                                                ║
║    [A] Abort vs-init                                          ║
║        → Manually commit/stash, then run vs-init again        ║
║                                                                ║
╚═══════════════════════════════════════════════════════════════╝

Your choice [C/S/A]:
```

#### Scenario C: No Git repository

```
╔═══════════════════════════════════════════════════════════════╗
║                    NO GIT REPOSITORY DETECTED                 ║
╠═══════════════════════════════════════════════════════════════╣
║                                                                ║
║  This project is not under version control.                   ║
║                                                                ║
║  Options:                                                      ║
║    [I] Initialize git with initial commit (RECOMMENDED)       ║
║        → git init && git add . && git commit -m "initial"     ║
║                                                                ║
║    [2] Continue without git safety net (NOT recommended)      ║
║        → Continue at your own risk                            ║
║                                                                ║
║    [A] Abort vs-init                                          ║
║                                                                ║
╚═══════════════════════════════════════════════════════════════╝

Your choice [I/2/A]:
```

---

### Шаг 2: Detect Conflicts

Проверка 6 типов конфликтов (см. `conflicts.md`):

```
[SKILL:vs-init] Step 2: Detecting conflicts...

Checking:
  • AGENTS.md: [exists/missing]
  • docs/*.xml: [count] files
  • MCP servers: [configured/none]
  • Entire.io: [installed/not installed]
  • ConPort: [installed/not installed]
  • Git hooks: [exists/none]
```

Если конфликты обнаружены → перейти к `resolvers.md`.

---

### Шаг 3: Выбор режима установки

```
╔═══════════════════════════════════════════════════════════════╗
║                    INSTALLATION MODE                          ║
╠═══════════════════════════════════════════════════════════════╣
║                                                                ║
║  Select installation mode:                                    ║
║                                                                ║
║  [L] LITE (RECOMMENDED for first-time users)                  ║
║      • GRACE methodology (XML artifacts)                      ║
║      • Basic GRACE skills                                     ║
║      • No external dependencies                               ║
║      • Time: 1-2 minutes                                      ║
║                                                                ║
║  [A] ADVANCED (for complex projects)                          ║
║      • LITE + Entire.io (session audit)                       ║
║      • LITE + ConPort (long-term memory)                      ║
║      • Time: 10-15 minutes                                    ║
║                                                                ║
╚═══════════════════════════════════════════════════════════════╝

Your choice [L/A]:
```

---

### Шаг 4: LITE режим

Если выбран LITE:

```
[SKILL:vs-init] LITE mode selected

Creating files:
  ✓ vs.project.toml (mode="lite")
  ✓ AGENTS.md (from core fragments)
  ✓ docs/requirements.xml
  ✓ docs/technology.xml
  ✓ docs/knowledge-graph.xml
  ✓ docs/development-plan.xml
  ✓ docs/verification-plan.xml
  ✓ docs/decisions.xml

╔═══════════════════════════════════════════════════════════════╗
║                    LITE INSTALLATION COMPLETE                 ║
╠═══════════════════════════════════════════════════════════════╣
║                                                                ║
║  Project: <project-name>                                      ║
║  Mode: LITE                                                   ║
║                                                                ║
║  Created files:                                               ║
║    ✓ vs.project.toml                                          ║
║    ✓ AGENTS.md                                                ║
║    ✓ docs/*.xml (6 files)                                     ║
║                                                                ║
║  Next steps:                                                  ║
║    • Review AGENTS.md                                         ║
║    • Start with /grace-plan or /grace-ask                     ║
║                                                                ║
║  To add integrations later:                                   ║
║    /vs-init --add-entire                                      ║
║    /vs-init --add-conport                                     ║
║                                                                ║
╚═══════════════════════════════════════════════════════════════╝
```

---

### Шаг 5: ADVANCED режим

Если выбран ADVANCED:

```
[SKILL:vs-init] ADVANCED mode selected

Optional integrations (choose any):
```

#### Вопрос 1: Entire.io

```
╔═══════════════════════════════════════════════════════════════╗
║                    Entire.io Integration                      ║
╠═══════════════════════════════════════════════════════════════╣
║                                                                ║
║  Entire.io — AI session audit                                 ║
║                                                                ║
║  Features:                                                    ║
║    • Capture AI agent sessions                                ║
║    • Link sessions to git commits                             ║
║    • Searchable history                                       ║
║    • Checkpoints with full context                            ║
║                                                                ║
║  Requirements:                                                ║
║    • entire CLI (npm install -g @entire/cli)                  ║
║    • Git repository                                           ║
║                                                                ║
║  Storage: Git branch (entire/checkpoints/v1)                  ║
║  Cost: Free (MIT license)                                     ║
║                                                                ║
║  Enable Entire.io? [Y/n]:                                     ║
║                                                                ║
╚═══════════════════════════════════════════════════════════════╝
```

Если "Y":
```
Setting up Entire.io:
  ✓ Checking entire CLI installation
  ✓ Running: entire enable
  ✓ Verifying git hooks
  ✓ Creating branch: entire/checkpoints/v1
```

#### Вопрос 2: ConPort

```
╔═══════════════════════════════════════════════════════════════╗
║                    ConPort Integration                        ║
╠═══════════════════════════════════════════════════════════════╣
║                                                                ║
║  ConPort — Long-term memory for AI agents                     ║
║                                                                ║
║  Features:                                                    ║
║    • Persistent memory between sessions                       ║
║    • Semantic search                                          ║
║    • Context carry-over                                       ║
║    • Decision migration to GRACE                              ║
║                                                                ║
║  Requirements:                                                ║
║    • ConPort MCP server                                       ║
║    • Agent with MCP support (Claude, Kilo, Cursor)            ║
║                                                                ║
║  Storage: Local file (.conport/memory.db)                     ║
║  Cost: Free (open source)                                     ║
║                                                                ║
║  Enable ConPort? [Y/n]:                                       ║
║                                                                ║
╚═══════════════════════════════════════════════════════════════╝
```

Если "Y":
```
Setting up ConPort:
  ✓ Checking ConPort CLI installation
  ✓ Adding to MCP config
  ✓ Initializing Memory Bank
  ✓ Verifying connection
```

#### Финальный шаг ADVANCED

```
Creating files:
  ✓ vs.project.toml (mode="advanced")
  ✓ AGENTS.md (with integration fragments)
  ✓ docs/*.xml (6 files)

╔═══════════════════════════════════════════════════════════════╗
║                 ADVANCED INSTALLATION COMPLETE                ║
╠═══════════════════════════════════════════════════════════════╣
║                                                                ║
║  Project: <project-name>                                      ║
║  Mode: ADVANCED                                               ║
║                                                                ║
║  Integrations:                                                ║
║    ✓ Entire.io — [enabled/disabled]                           ║
║    ✓ ConPort — [enabled/disabled]                             ║
║                                                                ║
║  Created files:                                               ║
║    ✓ vs.project.toml                                          ║
║    ✓ AGENTS.md                                                ║
║    ✓ docs/*.xml (6 files)                                     ║
║                                                                ║
║  Next steps:                                                  ║
║    • Review AGENTS.md                                         ║
║    • Test Entire.io: entire status                            ║
║    • Test ConPort: conport status                             ║
║    • Start with /grace-plan or /grace-ask                     ║
║                                                                ║
╚═══════════════════════════════════════════════════════════════╝
```

---

## vs.project.toml Шаблон

### LITE режим

```toml
[project]
name = "$PROJECT_NAME"
version = "0.1.0"
mode = "lite"

[features]
grace = true
conport = false
entire = false

[vibestart]
version = "3.0.0"
installed_at = "$TIMESTAMP"
```

### ADVANCED режим

```toml
[project]
name = "$PROJECT_NAME"
version = "0.1.0"
mode = "advanced"

[features]
grace = true
conport = true  # если выбрано
entire = true   # если выбрано

[integrations.entire]
enabled = true
cli_version = "1.2.0"
checkpoints_branch = "entire/checkpoints/v1"

[integrations.conport]
enabled = true
mcp_configured = true
memory_bank_path = ".conport/memory.db"

[vibestart]
version = "3.0.0"
installed_at = "$TIMESTAMP"
```

---

## Edge Cases

| Случай | Обработка |
|--------|-----------|
| Нет Git | Предложить инициализировать или продолжить без safety checkpoint |
| entire CLI не установлен | Предложить установку или пропустить интеграцию |
| ConPort не установлен | Показать инструкцию по установке или пропустить |
| MCP конфиг не найден | Создать или показать путь к файлу конфига |
| Git хуки уже есть | Предложить объединить или заменить |
