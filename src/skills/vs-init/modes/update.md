# UPDATE Mode

Режим обновления существующей установки vibestart.

## Когда используется

| Условие | Режим |
|---------|-------|
| `vs.project.toml` существует | UPDATE |
| Версия < текущей (3.0.0) | UPDATE |
| `.vibestart/` существует | UPDATE |

## Flow

### Шаг 1: Git Checkpoint Safety

```
[SKILL:vs-init] Step 1: Creating safety checkpoint...

Creating safety tag: vs-init-backup-YYYYMMDD-HHMMSS
  → git tag -a vs-init-backup-YYYYMMDD-HHMMSS -m "vs-init update checkpoint"

If something goes wrong, rollback with:
  git checkout vs-init-backup-YYYYMMDD-HHMMSS
```

---

### Шаг 2: Чтение текущей конфигурации

```
[SKILL:vs-init] Step 2: Reading current configuration...

Current configuration:
  • Version: 2.1.0
  • Mode: lite
  • Installed at: 2026-03-20T10:30:00Z
  • Integrations:
    - Entire.io: disabled
    - ConPort: disabled
```

---

### Шаг 3: Определение изменений

```
[SKILL:vs-init] Step 3: Analyzing changes...

Changes in v3.0.0:
  ✓ New: UPDATE/REPAIR/MIGRATE modes
  ✓ New: Entire.io integration
  ✓ New: ConPort integration
  ✓ New: LITE/ADVANCED installation modes
  ✓ Updated: vs-init skill structure (modular)
  ✓ Updated: Conflict detection (6 types)
  ✓ Updated: Documentation
```

---

### Шаг 4: Backup текущей установки

```
[SKILL:vs-init] Step 4: Creating backup...

Backup location: .vibestart/.backup/update-YYYYMMDD-HHMMSS/

Files to backup:
  ✓ .vibestart/ (entire directory)
  ✓ vs.project.toml
  ✓ AGENTS.md
  ✓ docs/*.xml

Creating backup...
  ✓ Copied 45 files to .vibestart/.backup/update-YYYYMMDD-HHMMSS/
```

---

### Шаг 5: Обновление файлов

#### 5.1: Обновление .vibestart/

```
Updating .vibestart/ framework files:

  ✓ src/skills/vs-init/SKILL.md (updated structure)
  ✓ src/skills/vs-init/detect-mode.md (new)
  ✓ src/skills/vs-init/conflicts.md (new)
  ✓ src/skills/vs-init/resolvers.md (new)
  ✓ src/skills/vs-init/modes/install.md (new)
  ✓ src/skills/vs-init/modes/update.md (new)
  ✓ src/skills/vs-init/modes/repair.md (new)
  ✓ src/skills/vs-init/modes/migrate.md (new)
  ✓ src/skills/vs-init/modes/refresh.md (new)
  ✓ src/skills/vs-init/integrations/entire.md (new)
  ✓ src/skills/vs-init/integrations/conport.md (new)
  ✓ src/fragments/features/entire-session-capture.md (new)
  ✓ src/fragments/features/conport-memory.md (new)

Total: 15 new files, 1 updated file
```

#### 5.2: Обновление vs.project.toml

```
Updating vs.project.toml:

Old version:
  vibestart.version = "2.1.0"

New version:
  vibestart.version = "3.0.0"
  vibestart.last_updated = "$TIMESTAMP"

Preserving user settings:
  ✓ project.name
  ✓ project.mode
  ✓ features.grace
  ✓ features.conport
  ✓ features.entire
```

#### 5.3: Обновление AGENTS.md

```
Regenerating AGENTS.md:

  ✓ Reading current fragments
  ✓ Updating from new templates
  ✓ Preserving custom sections (if any)
  ✓ Writing new AGENTS.md
```

#### 5.4: Проверка GRACE артефактов

```
Checking GRACE artifacts:

  ✓ docs/requirements.xml (no schema changes)
  ✓ docs/technology.xml (no schema changes)
  ✓ docs/knowledge-graph.xml (no schema changes)
  ✓ docs/development-plan.xml (no schema changes)
  ✓ docs/verification-plan.xml (no schema changes)
  ✓ docs/decisions.xml (no schema changes)

No updates required for GRACE artifacts.
```

---

### Шаг 6: Обновление интеграций

#### Если Entire.io включён

```
Updating Entire.io integration:

  ✓ Checking entire CLI version
  ✓ Current version: 1.2.0
  ✓ Latest version: 1.2.0
  ✓ No update required
```

#### Если ConPort включён

```
Updating ConPort integration:

  ✓ Checking ConPort MCP config
  ✓ Config is up-to-date
  ✓ Memory Bank exists
  ✓ No update required
```

---

### Шаг 7: Финальная проверка

```
[SKILL:vs-init] Step 7: Verifying update...

Verifying updated files:
  ✓ .vibestart/src/skills/vs-init/SKILL.md
  ✓ .vibestart/src/skills/vs-init/detect-mode.md
  ✓ .vibestart/src/skills/vs-init/conflicts.md
  ✓ .vibestart/src/skills/vs-init/resolvers.md
  ✓ .vibestart/src/skills/vs-init/modes/*.md (5 files)
  ✓ .vibestart/src/skills/vs-init/integrations/*.md (2 files)
  ✓ vs.project.toml (version updated)
  ✓ AGENTS.md (regenerated)

Running verify-vibestart.sh:
  ✓ Framework integrity: PASS
  ✓ Skills integrity: PASS
  ✓ Templates integrity: PASS
  ✓ Fragments integrity: PASS
```

---

### Шаг 8: Вывод результата

```
╔═══════════════════════════════════════════════════════════════╗
║                    UPDATE COMPLETE                            ║
╠═══════════════════════════════════════════════════════════════╣
║                                                                ║
║  Project: <project-name>                                      ║
║  Updated: v2.1.0 → v3.0.0                                     ║
║                                                                ║
║  Changes applied:                                             ║
║    ✓ Framework files updated (15 new, 1 updated)              ║
║    ✓ vs.project.toml updated                                  ║
║    ✓ AGENTS.md regenerated                                    ║
║    ✓ Integrations verified                                    ║
║                                                                ║
║  Backup location:                                             ║
║    .vibestart/.backup/update-YYYYMMDD-HHMMSS/                 ║
║                                                                ║
║  To rollback:                                                 ║
║    git checkout vs-init-backup-YYYYMMDD-HHMMSS                ║
║                                                                ║
║  Next steps:                                                  ║
║    • Review AGENTS.md for new features                        ║
║    • Check docs/INTEGRATIONS.md for new integrations          ║
║    • Run /grace-status to verify GRACE health                 ║
║                                                                ║
╚═══════════════════════════════════════════════════════════════╝
```

---

## Edge Cases

| Случай | Обработка |
|--------|-----------|
| Обновление с v1.x | Переключение на MIGRATE flow |
| Отсутствуют файлы .vibestart/ | Переключение на REPAIR flow |
| vs.project.toml не имеет версии | Предположить v2.0.0, продолжить UPDATE |
| Интеграции сломаны | Предложить переустановку |
| Git не доступен | Продолжить без safety checkpoint с предупреждением |

---

## Откат (Rollback)

Если обновление прошло неудачно:

```bash
# Вариант 1: Git rollback
git checkout vs-init-backup-YYYYMMDD-HHMMSS

# Вариант 2: Ручной restore из backup
cp -r .vibestart/.backup/update-YYYYMMDD-HHMMSS/* .vibestart/
cp .vibestart/.backup/update-YYYYMMDD-HHMMSS/vs.project.toml .
cp .vibestart/.backup/update-YYYYMMDD-HHMMSS/AGENTS.md .
```
